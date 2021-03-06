package com.tsh.bbs.service;

import java.util.List;
import java.util.Map;

import com.tsh.bbs.entity.PostDTO;
import com.tsh.bbs.entity.ReplyDTO;
import com.tsh.bbs.entity.TopicDTO;
import com.tsh.common.pagination.PaginatedDTO;

import net.sf.json.JSONObject;

public interface BBSService
{
	
	/**
	 * 分页查询话题
	 */
	PaginatedDTO<TopicDTO> qryPageTopic(TopicDTO dto);

	/**
	 * 添加话题
	 * @param dto
	 */
	Long addTopic(TopicDTO dto);

	/**
	 * 条件查询话题
	 */
	List<TopicDTO> qryTopicByMap(Map<String, Object> param);
	
	/**
	 * 更新话题
	 * @param dto
	 */
	void updateTopic(TopicDTO dto);
	/**
	 * 添加帖子
	 */
	Long addPost(PostDTO dto, JSONObject user,JSONObject result);

	/**
	 * 分页查询帖子
	 * @param dto
	 * @return
	 */
	PaginatedDTO<PostDTO> qryPagePost(PostDTO dto);
	
	/**
	 * 条件查询帖子信息
	 */
	List<PostDTO> qryPostByMap(Map<String, Object> param);
	
	/**
	 * 修改帖子
	 */
	boolean updatePost(PostDTO dto, JSONObject user,JSONObject result);

	/**
	 * 分页查询回复列表
	 */
	PaginatedDTO<ReplyDTO> qryPageReply(ReplyDTO dto);

	/**
	 * 添加回复
	 */
	Long addReply(ReplyDTO dto, JSONObject user, JSONObject result);
	
	/**
	 * 查询帖子数量
	 */
	Integer qryPostNum(Map<String, Object> param);

	/**
	 * 查询回复数量
	 */
	Integer qryReplyNum(Map<String, Object> paramNum);

}
