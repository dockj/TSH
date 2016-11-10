package com.tsh.assess.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tsh.assess.dao.AssessDao;
import com.tsh.assess.entity.AssessDTO;
import com.tsh.assess.entity.ResultDTO;
import com.tsh.assess.entity.ScoreDTO;
import com.tsh.assess.entity.TypeDTO;
import com.tsh.assess.service.AssessService;
import com.tsh.common.DateUtils;
import com.tsh.common.pagination.PaginatedDTO;

import net.sf.json.JSONObject;

@Service
public class AssessServiceImpl implements AssessService
{
	@Autowired
	private AssessDao assessDao;

	@Override
	public List<AssessDTO> qryAssessByMap(Map<String, Object> param)
	{
		List<AssessDTO> dtos = assessDao.qryAssessByMap(param);
		if (dtos == null || dtos.size() < 1)
		{
			return null;
		}
		return dtos;
	}

	@Transactional
	@Override
	public void insertAssess(AssessDTO dto, String[] scores, String[] options, JSONObject user) throws Exception
	{
		Date now = new Date();
		Long userId = Long.valueOf(user.optString("userId"));
		// 1、插入数据至t_tsh_assess表中
		dto.setFlushDate(DateUtils.formate(now));
		dto.setCreateBy(userId);
		dto.setUpdateBy(userId);
		dto.setCreateDate(now);
		dto.setUpdateDate(now);
		Long assessId = assessDao.insertAssess(dto);
		// 2、插入数据至t_tsh_assess_score
		ScoreDTO scoreDTO = null;
		for (int i = 0; i < scores.length; i++)
		{
			scoreDTO = new ScoreDTO();
			scoreDTO.setAssessId(assessId);
			scoreDTO.setCreateBy(userId);
			scoreDTO.setUpdateBy(userId);
			scoreDTO.setCreateDate(now);
			scoreDTO.setUpdateDate(now);
			scoreDTO.setOption(options[i]);
			scoreDTO.setScore(Integer.valueOf(scores[i]));
			assessDao.insertAssessScore(scoreDTO);
		}
	}

	@Override
	public PaginatedDTO<AssessDTO> qryPageAssess(AssessDTO dto)
	{
		return assessDao.qryPageAssess(dto);
	}

	@Transactional
	@Override
	public void delAssessById(String id)
	{
		assessDao.delAssessById(id);
		assessDao.delAssessScore(id);
	}

	@Override
	public List<ScoreDTO> qryScoreByMap(Map<String, Object> param)
	{
		return assessDao.qryScoreByMap(param);
	}

	@Transactional
	@Override
	public void updateAssess(AssessDTO dto, String[] scores, String[] options, JSONObject user, String[] ids)
	{
		Date now = new Date();
		Long userId = Long.valueOf(user.optString("userId"));
		dto.setUpdateBy(userId);
		dto.setUpdateDate(now);
		dto.setFlushDate(DateUtils.formate(now));
		assessDao.updateAssess(dto);

		ScoreDTO score = new ScoreDTO();
		for (int i = 0; i < scores.length; i++)
		{
			score.setId(Long.valueOf(ids[i]));
			score.setAssessId(dto.getId());
			score.setOption(options[i]);
			score.setScore(Integer.valueOf(scores[i]));
			score.setUpdateBy(userId);
			score.setUpdateDate(now);
			assessDao.updateScore(score);
		}
	}

	/**
	 * 插入自评信息
	 */
	@Transactional
	@Override
	public void insertAssessResult(String[] assessIds, List<String> scoreIds, double count, JSONObject user)
	{

		Long userId = Long.valueOf(user.optString("userId"));
		Date now = new Date();
		// 构造插入评测结果表信息t_tsh_eva_result
		ResultDTO resultDTO = new ResultDTO();
		resultDTO.setTotalScore(count);
		resultDTO.setUserId(userId);
		resultDTO.setTotalItem(assessIds.length);
		resultDTO.setCreateBy(userId);
		resultDTO.setUpdateBy(userId);
		resultDTO.setUpdateDate(now);
		resultDTO.setCreateDate(now);
		resultDTO.setEvaDate(now);
		resultDTO.setStatus("0");
		resultDTO.setUsername(user.optString("username"));
		Long evaId = assessDao.insertAssessResult(resultDTO);

		// 获取评测题目信息
		Map<String, Object> param = new HashMap<String, Object>();
		AssessDTO assessDTO = null;
		ScoreDTO scoreDTO = null;
		for (int i = 0; i < scoreIds.size(); i++)
		{
			param.put("id", assessIds[i]);
			assessDTO = qryAssessByMap(param).get(0);
			param.put("id", scoreIds.get(i));
			scoreDTO = qryScoreByMap(param).get(0);
			// 封装数据插入数据库
			// 构造数据插入至用户评测表中t_tsh_assess_user
			Map<String, Object> insertParam = new HashMap<String, Object>();
			insertParam.put("userId", userId);
			insertParam.put("evaId", evaId);
			insertParam.put("assessId", assessDTO.getId());
			insertParam.put("score", scoreDTO.getScore());
			insertParam.put("scoreId", scoreDTO.getId());
			insertParam.put("type", assessDTO.getType());
			insertParam.put("typeCode", assessDTO.getTypeCode());
			insertParam.put("createBy", userId);
			insertParam.put("updateBy", userId);
			insertParam.put("createDate", now);
			insertParam.put("updateDate", now);
			assessDao.insertAssessUser(insertParam);
		}
	}

	public List<AssessDTO> generateAssess()
	{
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("status", "1");
		List<AssessDTO> assessDTOs = qryAssessByMap(param);
		for (int i = 0; i < assessDTOs.size(); i++)
		{
			AssessDTO assessDTO = assessDTOs.get(i);
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("assessId", assessDTO.getId());
			List<ScoreDTO> scoreDTOs = qryScoreByMap(params);
			assessDTO.setScores(scoreDTOs);
		}
		return assessDTOs;
	}

	@Override
	public ResultDTO qryNewestResult(Map<String, Object> param)
	{
		return assessDao.qryNewestResult(param);
	}

	@Override
	public List<TypeDTO> qryNewestType(Map<String, Object> param)
	{
		return assessDao.qryNewestType(param);
	}

	/**
	 * 分页查询自评结果
	 */
	@Override
	public PaginatedDTO<ResultDTO> qryPageAssessResult(ResultDTO dto)
	{
		return assessDao.qryPageAssessResult(dto);
	}

	/**
	 * 条件查询自评结果类型
	 */
	public List<TypeDTO> qryAssessTypeResult(Map<String, Object> param)
	{
		return assessDao.qryAssessTypeResult(param);
	}
	
	/**
	 * 条件查询自评结果
	 */
	public List<ResultDTO> qryResultDTO(Map<String, Object> param)
	{
		return assessDao.qryResultDTO(param);
	}

	@Override
	public void addComment(ResultDTO dto, JSONObject user)
	{
		Long userId=Long.parseLong(user.optString("userId"));
		String username=user.optString("username");
		dto.setAssessUserId(userId);
		dto.setAssessUserName(username);
		dto.setUpdateBy(userId);
		dto.setUpdateDate(new Date());
		dto.setStatus("1");
		dto.setResultDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		assessDao.updateResult(dto);
	}

}
