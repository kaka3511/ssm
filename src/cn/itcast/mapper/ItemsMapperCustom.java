package cn.itcast.mapper;

import java.util.List;

import cn.itcast.po.ItemsCustom;
import cn.itcast.po.ItemsQueryVo;

public interface ItemsMapperCustom {
	public List<ItemsCustom> findItemsList(ItemsQueryVo itemsQueryVo) throws Exception;
	
	
}