package cn.itcast.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itcast.po.ItemsCustom;
import cn.itcast.service.ItemsService;

@Controller
public class JsonTestController {
	@Autowired
	private ItemsService itemsService;
	
	
	@RequestMapping("/requestJson")
	public @ResponseBody ItemsCustom requestJson(@RequestBody ItemsCustom itemsCustom) throws Exception{
		ItemsCustom o = itemsService.findItemsByName(itemsCustom.getName());
		return o;
	}
	
	@RequestMapping("/responseJson")
	public @ResponseBody ItemsCustom responseJson(ItemsCustom itemsCustom) throws Exception{
		ItemsCustom o = itemsService.findItemsByName(itemsCustom.getName());
		return o;
	}
}
