package com.tsh.patient.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tsh.common.BaseController;
import com.tsh.patient.entity.FollowDTO;
import com.tsh.patient.service.PatientService;
import com.tsh.user.service.UserService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("ptsPatients")
public class PtsPatientController extends BaseController
{
	@Autowired
	private PatientService patientService;
	@Autowired
	private UserService userService;

	/**
	 * 访问患者管理首页
	 */
	@RequestMapping("toMain")
	public String toMain(HttpServletRequest request, HttpServletResponse response,Model model)
	{
		JSONObject user=(JSONObject) request.getSession().getAttribute("user");
		String userId=user.optString("userId");
		
		// 已随访查询随访时间信息
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", userId);
		param.put("status", "2");
		List<FollowDTO> followedDTOs = patientService.qryFollowsByMap(param);
		// 查询未随访随访时间信息
		param.put("status", "1");
		List<FollowDTO> followDTOs = patientService.qryFollowsByMap(param);
		//封装参数至前台
		model.addAttribute("follows", followDTOs);
		model.addAttribute("followeds", followedDTOs);
		return "patient/pts/pts_follow_date";
	}
}
