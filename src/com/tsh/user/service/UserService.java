package com.tsh.user.service;

import java.util.List;
import java.util.Map;

import com.tsh.user.entity.RoleDTO;
import com.tsh.user.entity.UserDTO;

import net.sf.json.JSONObject;

public interface UserService
{
	/**
	 * 查询平台所有角色
	 */
	public List<RoleDTO> queryRoles(Map<String, Object> param);

	/**
	 * 校验用户输入参数
	 */
	public boolean checkParam(UserDTO userDTO, JSONObject result,String username);

	/**
	 * 保存用户信息
	 */
	public Long saveUser(UserDTO userDTO);

	/**
	 * 通过用户名密码获取用户信息
	 */
	public UserDTO queryUserByNameAndPwd(String username, String passwrod);

	/**
	 * 保存用户信息
	 */
	public Long saveUserInfo(UserDTO userDTO);

	/**
	 * 通过用户id查询角色信息
	 */
	public List<RoleDTO> queryRoleByUserId(Long id);

	/**
	 * 通过用户id查询用户信息
	 */
	public UserDTO queryUserById(String userId);

	/**
	 * 更新用户信息
	 * 
	 */
	public void updateUser(UserDTO userDTO);

}
