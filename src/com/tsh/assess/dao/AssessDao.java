package com.tsh.assess.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.tsh.assess.entity.AssessDTO;
import com.tsh.assess.entity.ResultDTO;
import com.tsh.assess.entity.ScoreDTO;
import com.tsh.assess.entity.TypeDTO;
import com.tsh.common.pagination.PaginatedDAO;
import com.tsh.common.pagination.PaginatedDTO;

@Repository
public class AssessDao extends PaginatedDAO
{
	/**
	 * 条件查询自评表信息
	 */
	public List<AssessDTO> qryAssessByMap(Map<String, Object> param)
	{
		return this.getSqlMapClientTemplate().queryForList("qry.assess.list", param);
	}

	/**
	 * 插入数据至t_tsh_assess
	 */
	public Long insertAssess(AssessDTO dto)
	{
		return (Long) this.getSqlMapClientTemplate().insert("insert.assess", dto);
	}

	/**
	 * 插入数据至t_tsh_assess_score表中
	 */
	public Long insertAssessScore(ScoreDTO scoreDTO)
	{
		return (Long) this.getSqlMapClientTemplate().insert("insert.assess.score", scoreDTO);
	}

	/**
	 * 分页查询自评信息
	 */
	public PaginatedDTO<AssessDTO> qryPageAssess(AssessDTO dto)
	{
		PaginatedDTO<AssessDTO> paginatedDTO = new PaginatedDTO<AssessDTO>();
		paginatedDTO.setPageNumber(dto.getPageNumber());
		paginatedDTO.setPageSize(dto.getPageSize());
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("assCode", dto.getAssCode());
		param.put("title", dto.getTitle());
		param.put("status", dto.getStatus());
		param.put("typeCode", dto.getTypeCode());
		return this.paging("qry.assess.list", paginatedDTO, param);
	}

	/**
	 * 通过id删除自评表信息 t_tsh_assess
	 */
	public void delAssessById(String id)
	{
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		this.getSqlMapClientTemplate().delete("del.assess", param);
	}

	/**
	 * 通过自评表id删除t_tsh_assess_score
	 * 
	 * @param id
	 */
	public void delAssessScore(String id)
	{
		Map<String, String> param = new HashMap<String, String>();
		param.put("assessId", id);
		this.getSqlMapClientTemplate().delete("del.assess.score", param);
	}

	/**
	 * 条件查询分数表信息
	 */
	public List<ScoreDTO> qryScoreByMap(Map<String, Object> param)
	{
		return this.getSqlMapClientTemplate().queryForList("qry.score.list", param);
	}

	/**
	 * 更新自评表信息
	 */
	public void updateAssess(AssessDTO dto)
	{
		this.getSqlMapClientTemplate().update("update.assess", dto);
	}

	/**
	 * 更新分数表信息
	 */
	public void updateScore(ScoreDTO score)
	{
		this.getSqlMapClientTemplate().update("update.score", score);
	}

	/**
	 * 插入数据至评测结果表中
	 * 
	 * @param resultDTO
	 */
	public Long insertAssessResult(ResultDTO resultDTO)
	{
		return (Long) this.getSqlMapClientTemplate().insert("insert.assess.result", resultDTO);
	}

	/**
	 * 插入数据至用户评测表中
	 * 
	 * @param insertParam
	 */
	public Long insertAssessUser(Map<String, Object> insertParam)
	{
		return (Long) this.getSqlMapClientTemplate().insert("insert.assess.user", insertParam);
	}

	/**
	 * 查询最新的类型结果
	 */
	public List<TypeDTO> qryNewestType(Map<String, Object> param)
	{
		return this.getSqlMapClientTemplate().queryForList("qry.newest.assess.type", param);
	}

	/**
	 * 查询最新测评结果
	 */
	public ResultDTO qryNewestResult(Map<String, Object> param)
	{
		return (ResultDTO) this.getSqlMapClientTemplate().queryForObject("qry.newest.assess.result", param);
	}

	/**
	 * 分页查询评测结果
	 */
	public PaginatedDTO<ResultDTO> qryPageAssessResult(ResultDTO dto)
	{
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("username", dto.getUsername());
		param.put("userId", dto.getUserId());
		param.put("evaDate", dto.getEvaDate());
		param.put("status", dto.getStatus());
		return this.paging("qry.assess.result.list", dto, param);
	}

	/**
	 * 查询最新类型结果
	 */
	public List<TypeDTO> qryAssessTypeResult(Map<String, Object> param)
	{
		return this.getSqlMapClientTemplate().queryForList("qry.assess.result.type",param);
	}

	/**
	 * 条件查询结果
	 */
	public List<ResultDTO> qryResultDTO(Map<String, Object> param)
	{
		return this.getSqlMapClientTemplate().queryForList("qry.assess.result.list",param);
	}

	/**
	 * 更新结果表
	 */
	public void updateResult(ResultDTO dto)
	{
		this.getSqlMapClientTemplate().update("update.result", dto);
	}

}
