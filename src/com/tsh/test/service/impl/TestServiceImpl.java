package com.tsh.test.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tsh.test.dao.TestDao;
import com.tsh.test.entity.TestDTO;
import com.tsh.test.service.TestService;

@Service
public class TestServiceImpl implements TestService
{
	@Autowired
	private TestDao testDao;

	public int queryCount(TestDTO dto)
	{
		return testDao.queryCount(dto);
	}
}
