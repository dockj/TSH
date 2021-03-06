package com.tsh.patient.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.tsh.common.pagination.PaginatedDTO;
import com.tsh.patient.entity.FollowDTO;
import com.tsh.patient.entity.PatientDTO;
import com.tsh.patient.service.PatientService;
import com.tsh.user.entity.UserDTO;
import com.tsh.user.service.UserService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("patients")
public class PatientController extends BaseController
{
	@Autowired
	private PatientService patientService;
	@Autowired
	private UserService userService;

	/**
	 * 访问患者管理首页
	 */
	@RequestMapping("toMain")
	public String toMain(HttpServletRequest request, HttpServletResponse response)
	{
		return "patient/manage/patient_main";
	}

	/**
	 * 分页查询患者信息
	 */
	@RequestMapping("qryPatientsList")
	public void qryPagePatients(HttpServletRequest request, HttpServletResponse response, PatientDTO dto)
	{
		// 分页查询患者信息
		// 获取分页参数
		int pageNumber = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));
		int pageSize = request.getParameter("rows") == null ? 10 : Integer.valueOf(request.getParameter("rows"));
		dto.setPageNumber(pageNumber);
		dto.setPageSize(pageSize);
		try
		{
			if (dto.getRealname() != null)
			{
				String realname = URLDecoder.decode(dto.getRealname(), "UTF-8");// 把传来的URL转换成中文
				dto.setRealname(realname);
			}
			PaginatedDTO<PatientDTO> pageList = patientService.qryPagePatients(dto);

			JSONObject result = new JSONObject();
			result.put("total", pageList.getTotal());
			result.put("rows", pageList.getDataList());
			this.printJSON(response, result);
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * 随访时间主页
	 */
	@RequestMapping("toFollowMain")
	public String toFollowMain(HttpServletRequest request, HttpServletResponse response)
	{
		return "patient/manage/follow_main";
	}

	/**
	 * 分页查询用户随访时间信息
	 */
	@RequestMapping("qryFollowsList")
	public void qryFollowsList(HttpServletRequest request, HttpServletResponse response, PatientDTO dto)
	{
		// 分页查询患者信息
		// 获取分页参数
		int pageNumber = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));
		int pageSize = request.getParameter("rows") == null ? 10 : Integer.valueOf(request.getParameter("rows"));
		dto.setPageNumber(pageNumber);
		dto.setPageSize(pageSize);
		try
		{
			if (dto.getRealname() != null)
			{
				String realname = URLDecoder.decode(dto.getRealname(), "UTF-8");// 把传来的URL转换成中文
				dto.setRealname(realname);
			}
			PaginatedDTO<PatientDTO> pageList = patientService.qryPageFollows(dto);

			JSONObject result = new JSONObject();
			result.put("total", pageList.getTotal());
			result.put("rows", pageList.getDataList());
			this.printJSON(response, result);
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * 查询患者自评结果
	 */
	@RequestMapping("qryAssessResult")
	public String qryAssessResult(HttpServletRequest request, HttpServletResponse response)
	{
		// 获取用户id
		String id = request.getParameter("id");
		return "";
	}

	/**
	 * 进入新增随访时间页面
	 */
	@RequestMapping("toAddFollow")
	public String toAddFollow(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		String userId = request.getParameter("id");
		// 查询用户信息
		UserDTO userDTO = userService.queryUserById(userId);
		// 查询随访时间信息
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", userId);
		List<FollowDTO> followDTOs = patientService.qryFollowsByMap(param);
		model.addAttribute("patient", userDTO);
		model.addAttribute("follows", followDTOs);
		return "patient/manage/follow_add";

	}

	/**
	 * 添加随访时间
	 */
	@RequestMapping("addFollows")
	public void addFollows(HttpServletRequest request, HttpServletResponse response)
	{
		String[] followsDates = request.getParameterValues("followDate");
		String userId = request.getParameter("userId");
		JSONObject result = new JSONObject();
		if (followsDates == null)
		{
			result.put("resultCode", "-1");
			result.put("note", "题目编码不能为空!");
			this.printJSON(response, result);
			return;
		}
		for (int i = 0; i < followsDates.length; i++)
		{
			try
			{
				Date followDate = new SimpleDateFormat("yyyy-MM-dd").parse(followsDates[i]);
			}
			catch (ParseException e)
			{
				result.put("resultCode", "-2");
				result.put("note", "第" + (i + 1) + "行，日期格式输入有误。正确格式如下：2016-05-01");
				this.printJSON(response, result);
				return;
			}
		}
		JSONObject user = (JSONObject) request.getSession().getAttribute("user");
		try
		{
			patientService.addFollows(followsDates, userId, result, user);
			result.put("resultCode", "0");
			result.put("note", "添加成功");
		}
		catch (Exception e)
		{
			result.put("resultCode", "-300");
			result.put("note", "系统异常！");
		}
		this.printJSON(response, result);
	}

	/**
	 * 进入修改随访时间页面
	 */
	@RequestMapping("toEditFollow")
	public String toEditFollow(HttpServletRequest request, HttpServletResponse response,Model model)
	{
		String userId = request.getParameter("id");
		// 查询用户信息
		UserDTO userDTO = userService.queryUserById(userId);
		// 已随访查询随访时间信息
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userId", userId);
		param.put("status", "2");
		List<FollowDTO> followedDTOs = patientService.qryFollowsByMap(param);
		// 查询未随访随访时间信息
		param.put("status", "1");
		List<FollowDTO> followDTOs = patientService.qryFollowsByMap(param);
		//封装参数至前台
		model.addAttribute("patient", userDTO);
		model.addAttribute("follows", followDTOs);
		model.addAttribute("followeds", followedDTOs);
		return "patient/manage/follow_edit";
	}
	/**
	 * 修改随访时间
	 */
	@RequestMapping("editFollows")
	public void editFollows(HttpServletRequest request, HttpServletResponse response)
	{
		String[] followsDates = request.getParameterValues("followDate");
		String[] followIds=request.getParameterValues("followId");
		String userId = request.getParameter("userId");
		JSONObject result = new JSONObject();
		if (followsDates == null)
		{
			result.put("resultCode", "-1");
			result.put("note", "题目编码不能为空!");
			this.printJSON(response, result);
			return;
		}
		for (int i = 0; i < followsDates.length; i++)
		{
			try
			{
				Date followDate = new SimpleDateFormat("yyyy-MM-dd").parse(followsDates[i]);
			}
			catch (ParseException e)
			{
				result.put("resultCode", "-2");
				result.put("note", "第" + (i + 1) + "行，日期格式输入有误。正确格式如下：2016-05-01");
				this.printJSON(response, result);
				return;
			}
		}
		JSONObject user = (JSONObject) request.getSession().getAttribute("user");
		try
		{
			patientService.updateFollow(followsDates, userId, result, user,followIds);
			result.put("resultCode", "0");
			result.put("note", "修改成功");
		}
		catch (Exception e)
		{
			result.put("resultCode", "-300");
			result.put("note", "系统异常！");
		}
		this.printJSON(response, result);
	}
	
	/**
	 * 标记已随访
	 */
	@RequestMapping("flagFollowed")
	public void flagFollowed(HttpServletRequest request,HttpServletResponse response,FollowDTO dto)
	{
		JSONObject result = new JSONObject();
		try
		{
			Date followDate = new SimpleDateFormat("yyyy-MM-dd").parse(dto.getFollowedDate());
		}
		catch (ParseException e)
		{
			result.put("resultCode", "-2");
			result.put("note", "日期格式输入有误。正确格式如下：2016-05-01");
			this.printJSON(response, result);
			return;
		}
		JSONObject user = (JSONObject) request.getSession().getAttribute("user");
		try
		{
			
			dto.setUpdateBy(Long.valueOf(user.optString("userId")));
			dto.setUpdateDate(new Date());
			dto.setStatus("2");
			patientService.updateFollow(dto);
			result.put("resultCode", "0");
			result.put("note", "标记成功");
		}
		catch (Exception e)
		{
			result.put("resultCode", "-300");
			result.put("note", "系统异常！");
		}
		this.printJSON(response, result);
	}
}
