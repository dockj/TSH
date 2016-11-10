package com.tsh.test.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tsh.common.BaseController;
import com.tsh.test.entity.TestDTO;
import com.tsh.test.service.TestService;

@RequestMapping("test")
@Controller
public class TestContoller extends BaseController
{
	@Autowired
	private TestService testService;
	@RequestMapping("select")
	public String queryCount(HttpServletRequest request, HttpServletResponse reponse,Model model)
	{
		TestDTO dto=new TestDTO();
		dto.setAge(2);
		int age=testService.queryCount(dto);
		model.addAttribute("age", age);
		return "test/test";
	}
}
