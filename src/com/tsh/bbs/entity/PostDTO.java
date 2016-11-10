package com.tsh.bbs.entity;

import com.tsh.common.BaseDTO;

public class PostDTO extends BaseDTO
{
	private Long id;
	private String postName;
	private String postContent;
	private Integer replyNum;
	private String realname;
	private String username;
	private String topicName;
	private Long topicId;
	private String status;
	private Long userId;
	private String createTime;
	private String updateTime;
	private String topicStatus;

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public String getPostName()
	{
		return postName;
	}

	public void setPostName(String postName)
	{
		this.postName = postName;
	}

	public String getPostContent()
	{
		return postContent;
	}

	public void setPostContent(String postContent)
	{
		this.postContent = postContent;
	}

	public Integer getReplyNum()
	{
		return replyNum;
	}

	public void setReplyNum(Integer replyNum)
	{
		this.replyNum = replyNum;
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

	public String getTopicName()
	{
		return topicName;
	}

	public void setTopicName(String topicName)
	{
		this.topicName = topicName;
	}

	public Long getTopicId()
	{
		return topicId;
	}

	public void setTopicId(Long topicId)
	{
		this.topicId = topicId;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public Long getUserId()
	{
		return userId;
	}

	public void setUserId(Long userId)
	{
		this.userId = userId;
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

	public String getTopicStatus()
	{
		return topicStatus;
	}

	public void setTopicStatus(String topicStatus)
	{
		this.topicStatus = topicStatus;
	}

}
