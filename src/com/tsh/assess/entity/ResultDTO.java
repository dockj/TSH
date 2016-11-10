package com.tsh.assess.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.tsh.common.BaseDTO;

public class ResultDTO extends BaseDTO
{
	/**
	 * 评测结果ID
	 */
	private Long id;
	/**
	 * 用户id
	 */
	private Long userId;
	/**
	 * 评测总分
	 */
	private Double totalScore;

	/**
	 * 评测总项目数
	 */
	private Integer totalItem;

	/**
	 * 评测时间
	 */
	private Date evaDate;

	/**
	 * 评测返回时间
	 */
	private String strEvaDate;

	/**
	 * 平均分数
	 */
	private Double avgScore;

	/**
	 * 评论结果
	 * 
	 * @return
	 */
	private String result;

	/**
	 * 评论用户id
	 * 
	 */
	private Long assessUserId;
	/**
	 * 评论用户名
	 */
	private String assessUserName;
	/**
	 * 用户名
	 * 
	 * @return
	 */
	private String username;
	/**
	 * 评测状态
	 * 
	 * @return
	 */
	private String status;

	/**
	 * 评论时间
	 */
	private String resultDate;

	/**
	 * 类型结果集
	 * 
	 * @return
	 */
	private List<TypeDTO> types = new ArrayList<TypeDTO>();

	public Long getId()
	{
		return id;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public Long getUserId()
	{
		return userId;
	}

	public void setUserId(Long userId)
	{
		this.userId = userId;
	}

	public Double getTotalScore()
	{
		return totalScore;
	}

	public void setTotalScore(Double totalScore)
	{
		this.totalScore = totalScore;
	}

	public Integer getTotalItem()
	{
		return totalItem;
	}

	public void setTotalItem(Integer totalItem)
	{
		this.totalItem = totalItem;
	}

	public Date getEvaDate()
	{
		return evaDate;
	}

	public void setEvaDate(Date evaDate)
	{
		this.evaDate = evaDate;
	}

	public Double getAvgScore()
	{
		return avgScore;
	}

	public void setAvgScore(Double avgScore)
	{
		this.avgScore = avgScore;
	}

	public String getResult()
	{
		return result;
	}

	public void setResult(String result)
	{
		this.result = result;
	}

	public Long getAssessUserId()
	{
		return assessUserId;
	}

	public void setAssessUserId(Long assessUserId)
	{
		this.assessUserId = assessUserId;
	}

	public String getAssessUserName()
	{
		return assessUserName;
	}

	public void setAssessUserName(String assessUserName)
	{
		this.assessUserName = assessUserName;
	}

	public String getUsername()
	{
		return username;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

	public String getStatus()
	{
		return status;
	}

	public void setStatus(String status)
	{
		this.status = status;
	}

	public List<TypeDTO> getTypes()
	{
		return types;
	}

	public void setTypes(List<TypeDTO> types)
	{
		this.types = types;
	}

	public String getStrEvaDate()
	{
		return strEvaDate;
	}

	public void setStrEvaDate(String strEvaDate)
	{
		this.strEvaDate = strEvaDate;
	}

	public String getResultDate()
	{
		return resultDate;
	}

	public void setResultDate(String resultDate)
	{
		this.resultDate = resultDate;
	}

}
