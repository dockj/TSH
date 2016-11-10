package com.tsh.assess.entity;

import com.tsh.common.BaseDTO;

public class TypeDTO extends BaseDTO
{
	private String type;
	private String typeCode;
	private Integer sumTypeScore;
	private Integer sumType;
	private Double avgTypeScore;
	private Long userId;
	private Long evaId;

	public String getType()
	{
		return type;
	}

	public void setType(String type)
	{
		this.type = type;
	}

	public String getTypeCode()
	{
		return typeCode;
	}

	public void setTypeCode(String typeCode)
	{
		this.typeCode = typeCode;
	}

	public Integer getSumTypeScore()
	{
		return sumTypeScore;
	}

	public void setSumTypeScore(Integer sumTypeScore)
	{
		this.sumTypeScore = sumTypeScore;
	}

	public Integer getSumType()
	{
		return sumType;
	}

	public void setSumType(Integer sumType)
	{
		this.sumType = sumType;
	}

	public Double getAvgTypeScore()
	{
		return avgTypeScore;
	}

	public void setAvgTypeScore(Double avgTypeScore)
	{
		this.avgTypeScore = avgTypeScore;
	}

	public Long getUserId()
	{
		return userId;
	}

	public void setUserId(Long userId)
	{
		this.userId = userId;
	}

	public Long getEvaId()
	{
		return evaId;
	}

	public void setEvaId(Long evaId)
	{
		this.evaId = evaId;
	}

}
