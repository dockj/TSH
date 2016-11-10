package com.tsh.bbs.entity;

import com.tsh.common.BaseDTO;

public class ReplyDTO extends BaseDTO
{
	private Long id;
	private String replyName;
	private String replyContent;
	private String status;
	private String postName;
	private Long postId;
	private Long userId;
	private String realname;
	private String username;
	private String createTime;
	private String updateTime;
	private Integer floor;

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public String getReplyName()
	{
		return replyName;
	}

	public void setReplyName(String replyName)
	{
		this.replyName = replyName;
	}

	public String getReplyContent()
	{
		return replyContent;
	}

	public void setReplyContent(String replyContent)
	{
		this.replyContent = replyContent;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public String getPostName()
	{
		return postName;
	}

	public void setPostName(String postName)
	{
		this.postName = postName;
	}

	public Long getPostId()
	{
		return postId;
	}

	public void setPostId(Long postId)
	{
		this.postId = postId;
	}

	public Long getUserId()
	{
		return userId;
	}

	public void setUserId(Long userId)
	{
		this.userId = userId;
	}

	public String getRealname()
	{
		return realname;
	}

	public void setRealname(String realname)
	{
		this.realname = realname;
	}

	public String getUsername()
	{
		return username;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

	public String getCreateTime()
	{
		return createTime;
	}

	public void setCreateTime(String createTime)
	{
		this.createTime = createTime;
	}

	public String getUpdateTime()
	{
		return updateTime;
	}

	public void setUpdateTime(String updateTime)
	{
		this.updateTime = updateTime;
	}

	public Integer getFloor()
	{
		return floor;
	}

	public void setFloor(Integer floor)
	{
		this.floor = floor;
	}
	

}
