package cn.itcast.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.itcast.exception.CustomException;
import cn.itcast.po.ItemsCustom;
import cn.itcast.po.ItemsQueryVo;
import cn.itcast.service.ItemsService;

/**
 * @author Administrator 商品controller
 */
@Controller
@RequestMapping("/Items")
public class ItemsController {
	@Autowired
	private ItemsService itemsService;

	@RequestMapping("/queryItems")
	public ModelAndView queryItems(ItemsQueryVo itemsQueryVo) throws Exception {
		List<ItemsCustom> itemsList = itemsService.findItemsList(itemsQueryVo);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("itemsList", itemsList);
		modelAndView.setViewName("items/itemsList");
		return modelAndView;
	}

	// @RequestMapping("/editItems")
	// public ModelAndView editItems() throws Exception{
	// ModelAndView modelAndView = new ModelAndView();
	// ItemsCustom itemsCustom = new ItemsCustom();
	// itemsCustom = itemsService.findItemsById(1);
	// modelAndView.addObject("itemsCustom", itemsCustom);
	// modelAndView.setViewName("items/editItems");
	// return modelAndView;
	// }

	@RequestMapping("/editItems")
	public String editItems(Model model, Integer id) throws Exception {
		ItemsCustom itemsCustom = itemsService.findItemsById(id);
		if(itemsCustom == null){
			throw new CustomException("商品信息不存在！");
		}
			
		model.addAttribute("itemsCustom", itemsCustom);
		return "items/editItems";
	}

	// @RequestMapping("/editItemsSubmit")
	// public ModelAndView editItemsSubmit() throws Exception{
	// ModelAndView modelAndView = new ModelAndView();
	// modelAndView.setViewName("success");
	// return modelAndView;
	// }

	@RequestMapping("/editItemsSubmit")
	public String editItemsSubmit(Model model,Integer id, @Validated ItemsCustom itemsCustom, BindingResult bindingResult
			,MultipartFile items_pic)
			throws Exception {
		if(bindingResult.hasErrors()){
			List<ObjectError> allErrors = bindingResult.getAllErrors();
			for(ObjectError error:allErrors){
				System.out.println(error.getDefaultMessage());
			}
			model.addAttribute("allErrors", allErrors);
			return "items/editItems";
		}
		String originalFileName = items_pic.getOriginalFilename();
		if(items_pic!=null){
			if(originalFileName!=null&&originalFileName.length()>0){
				String pic_path = "D:\\workSpace\\czbkSpringMVCMybatis\\WebRoot\\WEB-INF\\file\\pic\\";
				String newFileName = originalFileName.substring(0, originalFileName.indexOf(".")) + 
											new Date().getSeconds()
										+ originalFileName.substring(originalFileName.indexOf("."));
				File file = new File(pic_path+newFileName);
				items_pic.transferTo(file);
				itemsCustom.setPic(newFileName);
			}
		}
		itemsService.updateItems(id, itemsCustom);
		return "forward:queryItems.do";
	}

	@RequestMapping("/deleteItems")
	public String deleteItems(Integer id) throws Exception {
		// 若子表存在依赖，则需要先删除子表数据
		itemsService.deleteItems(id);
		return "forward:queryItems.do";
	}

	@RequestMapping("/deleteMuchItems")
	public String deleteMuchItems(Integer[] ids) throws Exception {
		if (ids != null)
			itemsService.deleteMuchItems(ids);
		return "forward:queryItems.do";
	}

	@RequestMapping("/addItems")
	public String addItems() throws Exception {
		return "items/addItems";
	}

	@RequestMapping("/addItemsSubmit")
	public String addItemsSubmit(ItemsCustom itemsCustom,MultipartFile items_pic) throws Exception {
		String originalFileName = items_pic.getOriginalFilename();
		if(items_pic!=null){
			if(originalFileName!=null&&originalFileName.length()>0){
				String pic_path = "D:\\workSpace\\czbkSpringMVCMybatis\\WebRoot\\WEB-INF\\file\\pic\\";
				String newFileName = originalFileName.substring(0, originalFileName.indexOf(".")) + 
										new Date().getSeconds()
										+ originalFileName.substring(originalFileName.indexOf("."));
				File file = new File(pic_path+newFileName);
				items_pic.transferTo(file);
				itemsCustom.setPic(newFileName);
			}
		}
		itemsService.addItems(itemsCustom);
		return "redirect:queryItems.do";
	}

	@RequestMapping("/editMuchItems")
	public String editItemsQuery(Model model, ItemsQueryVo itemsQueryVo,Integer[] ids) throws Exception {
		List<ItemsCustom> itemsList = new ArrayList<>();
		if(ids!=null&&ids.length>0){
			for(Integer id:ids){
				itemsList.add(itemsService.findItemsById(id));
			}
		}
		else{
			itemsList = itemsService.findItemsList(itemsQueryVo);
		}
		model.addAttribute("itemsList", itemsList);
		return "items/editMuchItems";

	}

	@RequestMapping("/editMuchItemsSubmit")
	public String editMuchItemsSubmit(ItemsQueryVo itemsQueryVo) throws Exception {
		for (ItemsCustom o : itemsQueryVo.getItemsList()){
			itemsService.editMuchItemsSubmit(o);
		}
		return "redirect:queryItems.do";
	}
	
	@ModelAttribute("itemsType")
	public Map<Integer,String> getItemsType(){
		Map<Integer,String> itemsType = new HashMap<>();
		itemsType.put(0, "所有");
		itemsType.put(1, "默认");
		itemsType.put(2, "自定义");
		return itemsType;
	}
	
	@RequestMapping("/selectItemsType")
	public String selectItemsType(Model model,ItemsQueryVo itemsQueryVo,Integer itemsType) throws Exception {
		List<ItemsCustom> itemsListOrign = itemsService.findItemsList(itemsQueryVo);
		List<ItemsCustom> itemsList = new ArrayList<>(); 
		if(itemsListOrign.size()>1){
			switch(itemsType){
			case 1:
				for(int i=0;i<3;i++)
					itemsList.add(itemsListOrign.get(i));
				break;
			case 2:
				for(int i=3;i<itemsListOrign.size();i++)
					itemsList.add(itemsListOrign.get(i));
				break;
			default:
				itemsList.addAll(itemsListOrign);
				break;
			}
		}else
			itemsList.addAll(itemsListOrign);
		model.addAttribute("itemsList", itemsList);
		return "items/itemsList";
	}
	
	//restful风格
	@RequestMapping("/itemsView/{id}")
	public @ResponseBody ItemsCustom itemsView(@PathVariable("id") Integer id) throws Exception{
		ItemsCustom itemsCustom = itemsService.findItemsById(id);
		return itemsCustom;
	}

}
