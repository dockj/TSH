package com.tsh.assess.service;

import java.util.List;
import java.util.Map;

import com.tsh.assess.entity.AssessDTO;
import com.tsh.assess.entity.ResultDTO;
import com.tsh.assess.entity.ScoreDTO;
import com.tsh.assess.entity.TypeDTO;
import com.tsh.common.pagination.PaginatedDTO;

import net.sf.json.JSONObject;

public interface AssessService
{
	/**
	 * 条件查询获取自评信息
	 */
	List<AssessDTO> qryAssessByMap(Map<String, Object> param);

	/**
	 * 插入数据至t_tsh_assess表中
	 */
	void insertAssess(AssessDTO dto, String[] scores, String[] options, JSONObject user) throws Exception;

	/**
	 * 分页查询自评信息
	 */
	PaginatedDTO<AssessDTO> qryPageAssess(AssessDTO dto);

	/**
	 * 删除自评信息
	 */
	void delAssessById(String id);

	/**
	 * 查询自评分数表信息
	 */
	List<ScoreDTO> qryScoreByMap(Map<String, Object> param);

	/**
	 * 更新自评分数表信息
	 */
	void updateAssess(AssessDTO dto, String[] scores, String[] options, JSONObject user, String[] id);

	/**
	 * 插入用户自评信息
	 */
	void insertAssessResult(String[] assessIds, List<String> scoreIds, double count, JSONObject user);

	/**
	 * 生成自评表信息
	 */
	List<AssessDTO> generateAssess();

	/**
	 * 查询最新评测结果
	 */
	ResultDTO qryNewestResult(Map<String, Object> param);

	/**
	 * 查询根据类型分类的评测结果集
	 */
	List<TypeDTO> qryNewestType(Map<String, Object> param);

	/**
	 * 分页查询自评结果集
	 */
	PaginatedDTO<ResultDTO> qryPageAssessResult(ResultDTO dto);

	/**
	 * 条件查询自评结果类型
	 */
	public List<TypeDTO> qryAssessTypeResult(Map<String, Object> param);
	
	/**
	 * 条件查询自评结果
	 */
	public List<ResultDTO> qryResultDTO(Map<String, Object> param);

	/**
	 * 添加评论
	 */
	void addComment(ResultDTO dto, JSONObject user);

}
