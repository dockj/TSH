package com.tsh.dictionary.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tsh.dictionary.dao.DictDao;
import com.tsh.dictionary.entity.DictDTO;
import com.tsh.dictionary.service.DictService;

@Service
public class DictServiceImpl implements DictService
{

	@Autowired
	private DictDao dictDao;
	@Override
	public List<DictDTO> qryDictByDataType(DictDTO dto)
	{
		return dictDao.qryDictByDataType(dto);
	}

}
