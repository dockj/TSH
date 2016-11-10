package com.tsh.patient.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.tsh.common.pagination.PaginatedDAO;
import com.tsh.common.pagination.PaginatedDTO;
import com.tsh.patient.entity.FollowDTO;
import com.tsh.patient.entity.PatientDTO;

@Repository
public class PatientDao extends  PaginatedDAO
{

	/**
	 * 分页查询患者信息
	 */
	public PaginatedDTO<PatientDTO> qryPagePatients(PatientDTO dto)
	{
		Map<String, Object> param=new HashMap<String,Object>();
		param.put("realname", dto.getRealname());
		param.put("username", dto.getUsername());
		param.put("mobilePhone", dto.getMobilePhone());
		return this.paging("qry.patient.list", dto, param);
	}
	
	/**
	 * 分页获取随访时间
	 */
	public PaginatedDTO<PatientDTO> qryPageFollows(PatientDTO dto)
	{
		Map<String, Object> param=new HashMap<String,Object>();
		param.put("realname", dto.getRealname());
		param.put("username", dto.getUsername());
		param.put("mobilePhone", dto.getMobilePhone());
		param.put("followStatus", dto.getFollowStatus());
		return this.paging("qry.follow.list", dto, param);
	}
	
	/**
	 * 条件查询随机访问时间
	 */
	public List<FollowDTO> qryFollowsByMap(Map<String, Object> param)
	{
		return this.getSqlMapClientTemplate().queryForList("qry.follows.by.map", param);
	}
	
	/**
	 * 插入随机访问时间
	 */
	public Long insertFollow(FollowDTO dto)
	{
		return (Long) this.getSqlMapClientTemplate().insert("insert.follow", dto);
	}
	
	/**
	 * 更新随访时间
	 * @param dto
	 */
	public void updateFollow(FollowDTO dto)
	{
		this.getSqlMapClientTemplate().update("update.follow", dto);
	}

}
