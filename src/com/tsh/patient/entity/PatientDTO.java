package com.tsh.patient.entity;

import com.tsh.common.BaseDTO;

public class PatientDTO extends BaseDTO
{
	/**
	 * 用户id
	 */
	private Long id;
	/**
	 * 访问时间表id
	 */
	private Long followId;
	/**
	 * 用户名
	 */
	private String username;
	/**
	 * 用户真实姓名
	 */
	private String realname;
	/**
	 * 密码
	 */
	private String password;
	/**
	 * 年龄
	 */
	private String age;
	/**
	 * 性别 1、男 2、女
	 */
	private String sex;
	/**
	 * 证件类型
	 */
	private String certiType;
	/**
	 * 证件号码
	 */
	private String certiCode;
	/**
	 * 电话号码
	 */
	private String mobilePhone;
	/**
	 * 电子邮箱
	 */
	private String email;
	/**
	 * 联系地址
	 */
	private String address;
	/**
	 * 出院时间
	 */
	private String levHosDate;

	/**
	 * 角色编码
	 */
	private String roleNo;
	/**
	 * 角色名称
	 */
	private String roleName;
	/**
	 * 用户状态 1、正常使用
	 */
	private String status;

	/**
	 * 访问状态
	 * 
	 * @return
	 */
	private String followStatus;
	/**
	 * 访问时间
	 * 
	 * @return
	 */
	private String followDate;
	/**
	 * 记录访问时间
	 * 
	 * @return
	 */
	private String followedDate;

	/**
	 * 最新随访时间
	 * 
	 * @return
	 */
	private String newestfollowDate;
	/**
	 * 随访结果
	 * 
	 * @return
	 */
	private String result;

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public String getUsername()
	{
		return username;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

	public String getPassword()
	{
		return password;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public String getAge()
	{
		return age;
	}

	public void setAge(String age)
	{
		this.age = age;
	}

	public String getSex()
	{
		return sex;
	}

	public void setSex(String sex)
	{
		this.sex = sex;
	}

	public String getCertiType()
	{
		return certiType;
	}

	public void setCertiType(String certiType)
	{
		this.certiType = certiType;
	}

	public String getCertiCode()
	{
		return certiCode;
	}

	public void setCertiCode(String certiCode)
	{
		this.certiCode = certiCode;
	}

	public String getMobilePhone()
	{
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone)
	{
		this.mobilePhone = mobilePhone;
	}

	public String getEmail()
	{
		return email;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public String getAddress()
	{
		return address;
	}

	public void setAddress(String address)
	{
		this.address = address;
	}

	public String getLevHosDate()
	{
		return levHosDate;
	}

	public void setLevHosDate(String levHosDate)
	{
		this.levHosDate = levHosDate;
	}

	public String getRealname()
	{
		return realname;
	}

	public void setRealname(String realname)
	{
		this.realname = realname;
	}

	public String getRoleNo()
	{
		return roleNo;
	}

	public void setRoleNo(String roleNo)
	{
		this.roleNo = roleNo;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public String getRoleName()
	{
		return roleName;
	}

	public void setRoleName(String roleName)
	{
		this.roleName = roleName;
	}

	public String getFollowStatus()
	{
		return followStatus;
	}

	public void setFollowStatus(String followStatus)
	{
		this.followStatus = followStatus;
	}

	public String getFollowDate()
	{
		return followDate;
	}

	public void setFollowDate(String followDate)
	{
		this.followDate = followDate;
	}

	public String getFollowedDate()
	{
		return followedDate;
	}

	public void setFollowedDate(String followedDate)
	{
		this.followedDate = followedDate;
	}

	public String getNewestfollowDate()
	{
		return newestfollowDate;
	}

	public void setNewestfollowDate(String newestfollowDate)
	{
		this.newestfollowDate = newestfollowDate;
	}

	public Long getFollowId()
	{
		return followId;
	}

	public void setFollowId(Long followId)
	{
		this.followId = followId;
	}

	public String getResult()
	{
		return result;
	}

	public void setResult(String result)
	{
		this.result = result;
	}

}
