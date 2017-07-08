package cn.itcast.test;

import java.util.Date;

import org.junit.Test;

public class TestItCast {
	@Test
	public void fun(){
		Date date = new Date();
		System.out.println(date.getSeconds());
	}

}
