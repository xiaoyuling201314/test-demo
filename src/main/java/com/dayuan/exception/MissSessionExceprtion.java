package com.dayuan.exception;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

public class MissSessionExceprtion extends ModelAndViewDefiningException {
	private static final long serialVersionUID = -9066396282867980403L;
	private static ModelAndView rediectView = new ModelAndView("redirect:/toLogin.do");
	
	public MissSessionExceprtion() {
		super(rediectView);
	}

}
