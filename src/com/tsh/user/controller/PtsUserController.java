package com.tsh.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tsh.common.BaseController;
import com.tsh.user.entity.RoleDTO;
import com.tsh.user.entity.UserDTO;
import com.tsh.user.service.UserService;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/ptsUsers")
public class PtsUserController extends BaseController
{
	private final static Logger logger = Logger.getLogger(UserController.class);
	@Autowired
	private UserService userService;

	/**
	 * 进入注册页面
	 */
	@RequestMapping("toRegister")
	public String toRegister(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("status", "1");
		List<RoleDTO> dtos = userService.queryRoles(param);
		if (dtos == null || dtos.size() < 1)
		{
			logger.info("未初始化数据库角色表信息。");
		}
		model.addAttribute("roles", dtos);
		return "/user/pts/register";
	}

	/**
	 * 用户注册
	 */
	@RequestMapping("register")
	public void register(HttpServletRequest request, HttpServletResponse response, UserDTO userDTO)
	{
		JSONObject result = new JSONObject();
		// 1、参数校验
		if (!userService.checkParam(userDTO, result, null))
		{
			logger.info("用户注册失败：" + result.toString());
			this.printJSON(response, result);
			return;
		}

		// 2、插入数据库
		Long userId = userService.saveUserInfo(userDTO);
		result.put("resultCode", "0");
		result.put("note", "注册成功！");

		// 将数据放置session中
		JSONObject user = new JSONObject();
		user.put("username", userDTO.getUsername());
		user.put("userId", userId);
		user.put("roleNo", userDTO.getRoleNo());
		user.put("roleName", userDTO.getRoleName());
		request.getSession().setAttribute("user", user);

		this.printJSON(response, result);
	}

	/**
	 * 进入主页
	 */
	@RequestMapping("index")
	public String toIndex(HttpServletRequest request, HttpServletResponse response)
	{
		return "ptsIndex";
	}

	/**
	 * 进入修改密码页面
	 */
	@RequestMapping("toModifyPwd")
	public String toModifyPwd(HttpServletRequest request, HttpServletResponse response)
	{
		return "/user/pts/pts_pwd_modify";
	}

	/**
	 * 进入修改用户信息页面
	 */
	@RequestMapping("toModify")
	public String toModify(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		// 1、从session中获取用户id
		JSONObject user = (JSONObject) request.getSession().getAttribute("user");
		UserDTO userDTO = userService.queryUserById(user.optString("userId"));
		userDTO.setRoleNo(user.optString("roleNo"));
		userDTO.setRoleName(user.optString("roleName"));
		model.addAttribute("userDTO", userDTO);
		return "/user/pts/pts_register_modify";
	}

	/**
	 * 退出登入
	 * 
	 */
	@RequestMapping("logout")
	public String logout(HttpServletRequest request, HttpServletResponse response)
	{
		request.getSession().invalidate();
		return "redirect:/users/toLogin";
	}

}
