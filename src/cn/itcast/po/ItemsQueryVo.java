package cn.itcast.po;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ItemsQueryVo {
	private Items items;
	private ItemsCustom itemsCustom;
	private List<ItemsCustom> itemsList;
	public List<ItemsCustom> getItemsList() {
		return itemsList;
	}
	public void setItemsList(List<ItemsCustom> itemsList) {
		this.itemsList = itemsList;
	}
	public Items getItems() {
		return items;
	}
	public void setItems(Items items) {
		this.items = items;
	}
	public ItemsCustom getItemsCustom() {
		return itemsCustom;
	}
	public void setItemsCustom(ItemsCustom itemsCustom) {
		this.itemsCustom = itemsCustom;
	}
	
}
