package com.tsh.test.dao;

import org.springframework.stereotype.Repository;

import com.tsh.common.pagination.PaginatedDAO;
import com.tsh.test.entity.TestDTO;

@Repository
public class TestDao extends PaginatedDAO
{

	public int queryCount(TestDTO dto)
	{
		return (int) this.getSqlMapClientTemplate().queryForObject("query.count",dto);
	}
}
