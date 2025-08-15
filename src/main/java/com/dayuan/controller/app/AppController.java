package com.dayuan.controller.app;

import com.dayuan.controller.BaseController;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * APP
 */
@Controller
@RequestMapping("/app")
public class AppController extends BaseController {

	private final Logger log=Logger.getLogger(AppController.class);

	/**
	 * APP使用教程（不拦截）
	 * @description
	 * @return
	 * @author Dz
	 * @date   2020年8月20日
	 */
	@RequestMapping("/useTutorial")
	public ModelAndView useTutorial() {
		return new ModelAndView("/app/useTutorial");
	}
}
