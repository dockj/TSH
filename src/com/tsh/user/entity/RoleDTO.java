package com.tsh.user.entity;

import com.tsh.common.BaseDTO;
import com.tsh.common.pagination.PaginatedDTO;

public class RoleDTO extends BaseDTO
{
	private static final long serialVersionUID = -1280314138988540168L;
	/**
	 * 角色表用户表关联id
	 */
	private Long id;
	/**
	 * 角色名称
	 */
	private String name;
	/**
	 * 角色编号
	 */
	private String roleNo;

	/**
	 * 用户id
	 */
	private Long userId;
	/**
	 * 描述
	 */
	private String description;

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getRoleNo()
	{
		return roleNo;
	}

	public void setRoleNo(String roleNo)
	{
		this.roleNo = roleNo;
	}

	public Long getUserId()
	{
		return userId;
	}

	public void setUserId(Long userId)
	{
		this.userId = userId;
	}

	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

}
