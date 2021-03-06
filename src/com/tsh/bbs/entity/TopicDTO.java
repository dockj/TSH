package com.tsh.bbs.entity;

import java.util.ArrayList;
import java.util.List;

import com.tsh.common.BaseDTO;

public class TopicDTO extends BaseDTO
{
	private Long id;
	private String topicName;
	private Integer postNum;
	private Integer savePostNum;
	private Integer unUsePostNum;
	private String status;
	private String createTime;
	private String updateTime;
	private Long userId;
	private List<PostDTO> posts = new ArrayList<PostDTO>();

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public String getTopicName()
	{
		return topicName;
	}

	public void setTopicName(String topicName)
	{
		this.topicName = topicName;
	}


	public Integer getPostNum()
	{
		return postNum;
	}

	public void setPostNum(Integer postNum)
	{
		this.postNum = postNum;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
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

	public List<PostDTO> getPosts()
	{
		return posts;
	}

	public void setPosts(List<PostDTO> posts)
	{
		this.posts = posts;
	}

	public Long getUserId()
	{
		return userId;
	}

	public void setUserId(Long userId)
	{
		this.userId = userId;
	}

	public Integer getSavePostNum()
	{
		return savePostNum;
	}

	public void setSavePostNum(Integer savePostNum)
	{
		this.savePostNum = savePostNum;
	}

	public Integer getUnUsePostNum()
	{
		return unUsePostNum;
	}

	public void setUnUsePostNum(Integer unUsePostNum)
	{
		this.unUsePostNum = unUsePostNum;
	}

	
}
