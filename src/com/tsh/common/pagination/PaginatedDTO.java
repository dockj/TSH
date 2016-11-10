package com.tsh.common.pagination;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class PaginatedDTO<T> implements Serializable
{

	private static final long serialVersionUID = 1L;

	private Integer pageSize = 10;
	private Integer pageNumber = 1;
	private Integer total;
	private Integer pageCount;
	private List<T> dataList = new ArrayList<T>();

	public Integer getPageSize()
	{
		return pageSize;
	}

	public void setPageSize(Integer pageSize)
	{
		this.pageSize = pageSize;
	}

	public Integer getPageNumber()
	{
		return pageNumber;
	}

	public void setPageNumber(Integer pageNumber)
	{
		this.pageNumber = pageNumber;
	}

	public Integer getTotal()
	{
		return total;
	}

	public void setTotal(Integer total)
	{
		this.total = total;
	}

	public List<T> getDataList()
	{
		return dataList;
	}

	public void setDataList(List<T> dataList)
	{
		this.dataList = dataList;
	}

	public Integer getPageCount()
	{
		return pageCount;
	}

	public void setPageCount(Integer pageCount)
	{
		this.pageCount = pageCount;
	}
	

}
