package cn.itcast.service;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itcast.mapper.ItemsMapper;
import cn.itcast.mapper.ItemsMapperCustom;
import cn.itcast.po.Items;
import cn.itcast.po.ItemsCustom;
import cn.itcast.po.ItemsExample;
import cn.itcast.po.ItemsQueryVo;

public class ItemsService {
	@Autowired
	private ItemsMapperCustom itemsMapperCustom;
	
	@Autowired
	private ItemsMapper itemsMapper;
	
	public List<ItemsCustom> findItemsList(ItemsQueryVo itemsQueryVo) throws Exception{
		return itemsMapperCustom.findItemsList(itemsQueryVo);
		
	}
	
	public ItemsCustom findItemsById(Integer id) throws Exception{
		Items items = itemsMapper.selectByPrimaryKey(id);
		ItemsCustom itemsCustom = null;
		if(items!=null){
			itemsCustom = new ItemsCustom();
			BeanUtils.copyProperties(items, itemsCustom);
		}
		return itemsCustom;
	}
	
	public void updateItems(Integer id,ItemsCustom itemsCustom) throws Exception{
		Items old = itemsMapper.selectByPrimaryKey(id);
		itemsCustom.setId(id);
		if(old.getPic()!=null&&(itemsCustom.getPic()==""||itemsCustom.getPic()==null))
				itemsCustom.setPic(old.getPic());
		itemsMapper.updateByPrimaryKeyWithBLOBs(itemsCustom);
	}
	
	public void deleteItems(Integer id) throws Exception{
		itemsMapper.deleteByPrimaryKey(id);
	}
	
	public void deleteMuchItems(Integer[] ids) throws Exception{
		for(Integer id:ids)
			itemsMapper.deleteByPrimaryKey(id);
	}
	
	public void addItems(ItemsCustom itemsCustom) throws Exception{
		itemsMapper.insert(itemsCustom);
	}
	
	public void editMuchItemsSubmit(ItemsCustom itemsCustom) throws Exception{
		Integer id = itemsCustom.getId();
		Items old = itemsMapper.selectByPrimaryKey(id);
		itemsCustom.setId(id);
		if(old.getPic()!=null&&(itemsCustom.getPic()==""||itemsCustom.getPic()==null))
				itemsCustom.setPic(old.getPic());
		ItemsExample example = new ItemsExample();
		example.createCriteria().andIdEqualTo(itemsCustom.getId());
		itemsMapper.updateByExampleWithBLOBs(itemsCustom, example);
	}
	
	public ItemsCustom findItemsByName(String name) throws Exception{
		ItemsExample example = new ItemsExample();
		example.createCriteria().andNameLike(name);
		Items items = itemsMapper.selectByExample(example).get(0);
		ItemsCustom itemsCustom = new ItemsCustom();
		BeanUtils.copyProperties(items, itemsCustom);
		return itemsCustom;
	}
	
}
