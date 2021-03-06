package com.tsh.user.service.impl;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sun.org.apache.bcel.internal.generic.DASTORE;
import com.tsh.user.dao.UserDao;
import com.tsh.user.entity.RoleDTO;
import com.tsh.user.entity.UserDTO;
import com.tsh.user.service.UserService;

import net.sf.json.JSONObject;
import sun.misc.BASE64Encoder;

@Service
public class UserServiceImpl implements UserService
{
	@Autowired
	private UserDao userDao;

	@Override
	public List<RoleDTO> queryRoles(Map<String, Object> param)
	{
		return userDao.queryRoles(param);
	}

	@Override
	public Long saveUser(UserDTO userDTO)
	{
		return userDao.saveUser(userDTO);
	}

	@Override
	public UserDTO queryUserByNameAndPwd(String username, String passwrod)
	{
		return userDao.queryUserByNameAndPwd(username, passwrod);
	}

	@Transactional
	public Long saveUserInfo(UserDTO userDTO)
	{
		userDTO.setCertiType("1");// 代表身份证
		userDTO.setStatus("1");// 正常使用
		userDTO.setUpdateDate(new Date());
		userDTO.setCreateDate(new Date());
		userDTO.setRegisterDate(new Date());
		try
		{
			userDTO.setPassword(new BASE64Encoder().encode(userDTO.getPassword().getBytes("utf-8")));
		}
		catch (UnsupportedEncodingException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Long userId = saveUser(userDTO);
		RoleDTO roleDTO = new RoleDTO();
		roleDTO.setUserId(userId);
		roleDTO.setCreateDate(new Date());
		roleDTO.setUpdateDate(new Date());
		roleDTO.setRoleNo(userDTO.getRoleNo());
		if ("1".equals(userDTO.getRoleNo()))
		{

			roleDTO.setDescription("医生");
		}
		else if ("2".equals(userDTO.getRoleNo()))
		{
			roleDTO.setDescription("患者");
		}
		saveUserRole(roleDTO);
		return userId;
	}

	private Long saveUserRole(RoleDTO roleDTO)
	{
		return userDao.saveUserRole(roleDTO);

	}

	@Override
	public boolean checkParam(UserDTO userDTO, JSONObject result, String oldUsername)
	{
		// 1、用户名校验
		String username = userDTO.getUsername();
		if (StringUtils.isEmpty(username))
		{
			result.put("resultCode", "-1");
			result.put("note", "用户名输入为空！");
			return false;
		}
		if (!username.matches("[A-Za-z0-9_]+"))
		{
			result.put("resultCode", "-1");
			result.put("note", "用户名须由数字字母或下划线组成！");
			return false;
		}
		if (username.length() > 30)
		{
			result.put("resultCode", "-1");
			result.put("note", "用户名长度不应超过30个字符！");
			return false;
		}
		// 注册用户
		if (StringUtils.isEmpty(oldUsername))
		{
			if (userDao.queryUserByUserName(username) != null)
			{
				result.put("resultCode", "-1");
				result.put("note", "用户名已存在！");
				return false;
			}
		}
		// 修改注册信息
		else
		{
			if (!userDTO.getUsername().equals(oldUsername))
			{
				if (userDao.queryUserByUserName(username) != null)
				{
					result.put("resultCode", "-1");
					result.put("note", "用户名已存在！");
					return false;
				}
			}
		}

		// 2、密码校验
		if (StringUtils.isEmpty(oldUsername))
		{
			String password = userDTO.getPassword();
			String rePasswrod = userDTO.getRePassword();
			if (StringUtils.isEmpty(password) || StringUtils.isEmpty(rePasswrod))
			{
				result.put("resultCode", "-2");
				result.put("note", "密码输入为空!");
				return false;
			}
			if (!password.equals(rePasswrod))
			{
				result.put("resultCode", "-2");
				result.put("note", "两次密码输入不一致!");
				return false;
			}
		}
		// 3、真实姓名
		String realname = userDTO.getRealname();
		if (StringUtils.isEmpty(realname))
		{
			result.put("resultCode", "-3");
			result.put("note", "真实姓名输入为空!");
			return false;
		}
		if (realname.length() > 30)
		{
			result.put("resultCode", "-3");
			result.put("note", "真实姓名不超过30个字符!");
			return false;
		}
		// 4、身份证号码
		String certiCode = userDTO.getCertiCode();
		if (StringUtils.isEmpty(certiCode))
		{
			result.put("resultCode", "-4");
			result.put("note", "证件号码不能为空!");
			return false;
		}
		if (!certiCode.matches("(\\d{14}[0-9a-zA-Z])|(\\d{17}[0-9a-zA-Z])"))
		{
			result.put("resultCode", "-4");
			result.put("note", "证件输入有误!");
			return false;
		}
		// 5、性别
		String sex = userDTO.getSex();
		if (StringUtils.isEmpty(sex) || !sex.matches("[12]"))
		{
			result.put("resultCode", "-5");
			result.put("note", "性别录入有误！");
			return false;
		}
		// 6、年龄
		String age = userDTO.getAge();
		if (StringUtils.isEmpty(age) || !age.matches("[1-9][0-9]|[1-9][0-3][1-9]"))
		{
			result.put("resultCode", "-6");
			result.put("note", "请输入正确的年龄！");
			return false;
		}
		// 7、电子邮箱
		String email = userDTO.getEmail();
		if (StringUtils.isNotEmpty(email)
				&& !email.matches("^\\s*\\w+(?:\\.{0,1}[\\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\\.[a-zA-Z]+\\s*$"))
		{
			result.put("resultCode", "-7");
			result.put("note", "请输入正确的电子邮箱！");
			return false;
		}
		// 8、联系方式
		String mobilePhone = userDTO.getMobilePhone();
		if (StringUtils.isEmpty(mobilePhone) || !mobilePhone.matches("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$"))
		{
			result.put("resultCode", "-8");
			result.put("note", "请输入正确的手机号码！");
			return false;
		}
		// 9、家庭地址
		String address = userDTO.getAddress();
		if (StringUtils.isEmpty(address))
		{
			result.put("resultCode", "-9");
			result.put("note", "家庭地址输入为空！");
			return false;
		}
		// 10、出院日期
		String levHosDate = userDTO.getLevHosDate();
		if (StringUtils.isNotEmpty(levHosDate))
		{
			try
			{
				new SimpleDateFormat("yyyy-MM-dd").parse(levHosDate);
			}
			catch (Exception e)
			{
				result.put("resultCode", "-10");
				result.put("note", "出院日期格式输入有误,格式：yyyy-MM-dd！");
				return false;
			}
		}
		

		// 11、角色
		if (StringUtils.isEmpty(oldUsername))
		{
			String roleNo = userDTO.getRoleNo();
			if (StringUtils.isEmpty(roleNo))
			{
				result.put("resultCode", "-11");
				result.put("note", "请选择用户类型！");
				return false;
			}
			if (userDao.queryRoleByNo(roleNo) == null)
			{
				result.put("resultCode", "-11");
				result.put("note", "无该用户类型！");
				return false;
			}
		}
		return true;
	}

	@Override
	public List<RoleDTO> queryRoleByUserId(Long userId)
	{
		return userDao.queryRoleByUserId(userId);
	}

	@Override
	public UserDTO queryUserById(String userId)
	{
		return userDao.queryUserById(userId);
	}

	@Override
	public void updateUser(UserDTO userDTO)
	{
		userDTO.setUpdateDate(new Date());
		userDao.updateUser(userDTO);
	}

}
