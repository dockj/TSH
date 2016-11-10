package com.tsh.dictionary.entity;

import com.tsh.common.BaseDTO;

public class DictDTO extends BaseDTO
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private long id;

	private String dataKey;

	private String dataValue;

	private String dataType;

	public long getid()
	{
		return id;
	}

	public void setId(long id)
	{
		this.id = id;
	}

	public String getDataKey()
	{
		return dataKey;
	}

	public void setDataKey(String dataKey)
	{
		this.dataKey = dataKey;
	}

	public String getDataValue()
	{
		return dataValue;
	}

	public void setDataValue(String dataValue)
	{
		this.dataValue = dataValue;
	}

	public String getDataType()
	{
		return dataType;
	}

	public void setDataType(String dataType)
	{
		this.dataType = dataType;
	}

}
