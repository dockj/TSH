package com.tsh.patient.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tsh.common.pagination.PaginatedDTO;
import com.tsh.patient.dao.PatientDao;
import com.tsh.patient.entity.FollowDTO;
import com.tsh.patient.entity.PatientDTO;
import com.tsh.patient.service.PatientService;

import net.sf.json.JSONObject;

@Service
public class PatientServiceImpl implements PatientService
{
	@Autowired
	private PatientDao patientDao;

	@Override
	public PaginatedDTO<PatientDTO> qryPagePatients(PatientDTO dto)
	{
		return patientDao.qryPagePatients(dto);
	}

	@Override
	public PaginatedDTO<PatientDTO> qryPageFollows(PatientDTO dto)
	{
		return patientDao.qryPageFollows(dto);
	}

	@Override
	public List<FollowDTO> qryFollowsByMap(Map<String, Object> param)
	{
		return patientDao.qryFollowsByMap(param);
	}

	@Transactional
	@Override
	public boolean addFollows(String[] followsDates, String userId, JSONObject result, JSONObject user) throws Exception
	{
		FollowDTO dto = new FollowDTO();

		Long loginUserId = Long.valueOf(user.optString("userId"));
		Date now = new Date();
		for (int i = 0; i < followsDates.length; i++)
		{
			dto.setCreateBy(loginUserId);
			dto.setUpdateBy(loginUserId);
			dto.setCreateDate(now);
			dto.setUpdateDate(now);
			dto.setUserId(Long.valueOf(userId));
			dto.setFollowDate(followsDates[i]);
			dto.setStatus("1");
			patientDao.insertFollow(dto);
		}
		return true;
	}
	@Transactional
	@Override
	public void updateFollow(String[] followsDates, String userId, JSONObject result, JSONObject user,
			String[] followIds)
	{
		FollowDTO dto = new FollowDTO();

		Long loginUserId = Long.valueOf(user.optString("userId"));
		Date now = new Date();
		for (int i = 0; i < followsDates.length; i++)
		{
			dto.setUpdateBy(loginUserId);
			dto.setUpdateDate(now);
			dto.setUserId(Long.valueOf(userId));
			dto.setFollowDate(followsDates[i]);
			dto.setStatus("1");
			dto.setId(Long.valueOf(followIds[i]));
			patientDao.updateFollow(dto);
		}
	}

	@Override
	public void updateFollow(FollowDTO dto)
	{
		patientDao.updateFollow(dto);
	}

}
