 package com.dayuan3.terminal.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/** 
* @author yzh
* @Date 2020年6月28日 
* 功能描述
*/
@Controller
@RequestMapping("warningModeling")
public class WarningModeling {
	
	

	@RequestMapping("/index")
	public String list(){
		
		return "/waring/waringmodel";
	}
	
}
