package com.tsh.patient.service;

import java.util.List;
import java.util.Map;

import com.tsh.common.pagination.PaginatedDTO;
import com.tsh.patient.entity.FollowDTO;
import com.tsh.patient.entity.PatientDTO;

import net.sf.json.JSONObject;

public interface PatientService
{
	/**
	 * 分页查询患者信息
	 */
	PaginatedDTO<PatientDTO> qryPagePatients(PatientDTO dto);

	/**
	 * 分页查询获取随访时间
	 */
	PaginatedDTO<PatientDTO> qryPageFollows(PatientDTO dto);
	
	/**
	 * 条件查询随机访问时间
	 */
	List<FollowDTO> qryFollowsByMap(Map<String, Object> param);
	
	/**
	 * 新增随访时间
	 */
	boolean addFollows(String[] followsDates, String userId, JSONObject result,JSONObject user) throws Exception;
	
	/**
	 * 修改随访时间
	 */
	void updateFollow(String[] followsDates, String userId, JSONObject result, JSONObject user,String[] followIds);
	/**
	 * 更新随访表信息
	 */
	void updateFollow(FollowDTO dto);

}
