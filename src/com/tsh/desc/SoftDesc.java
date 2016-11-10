package com.tsh.desc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tsh.common.BaseController;

@Controller
@RequestMapping("softs")
public class SoftDesc extends BaseController
{
	@RequestMapping("ptsDesc")
	public String ptsDesc(HttpServletRequest request, HttpServletResponse response)
	{
		return "softDesc/pts/soft_desc";
	}
	
	@RequestMapping("desc")
	public String desc(HttpServletRequest request, HttpServletResponse response)
	{
		return "softDesc/manage/soft_desc";
	}
}
