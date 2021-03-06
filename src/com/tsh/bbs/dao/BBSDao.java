package com.tsh.bbs.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.tsh.bbs.entity.PostDTO;
import com.tsh.bbs.entity.ReplyDTO;
import com.tsh.bbs.entity.TopicDTO;
import com.tsh.common.pagination.PaginatedDAO;
import com.tsh.common.pagination.PaginatedDTO;

@Repository
public class BBSDao extends PaginatedDAO
{

	/**
	 * 分页查询话题
	 */
	public PaginatedDTO<TopicDTO> qryPageTopic(TopicDTO dto)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("topicName", dto.getTopicName());
		paramMap.put("status", dto.getStatus());
		return this.paging("qry.topic.list", dto, paramMap);
	}

	/**
	 * 插入话题
	 * 
	 * @param dto
	 * @return
	 */
	public Long addTopic(TopicDTO dto)
	{
		return (Long) this.getSqlMapClientTemplate().insert("insert.topic", dto);
	}

	/**
	 * 条件查询话题
	 * 
	 * @param param
	 * @return
	 */
	public List<TopicDTO> qryTopicByMap(Map<String, Object> param)
	{
		return this.getSqlMapClientTemplate().queryForList("qry.topic.list", param);
	}

	/**
	 * 更新话题
	 * 
	 * @param dto
	 */
	public void updateTopic(TopicDTO dto)
	{
		this.getSqlMapClientTemplate().update("update.topic", dto);
	}

	/**
	 * 添加帖子
	 */
	public Long addPost(PostDTO dto)
	{
		return (Long) this.getSqlMapClientTemplate().insert("insert.post", dto);
	}

	/**
	 * 分页查询帖子
	 * 
	 * @param dto
	 * @return
	 */
	public PaginatedDTO<PostDTO> qryPagePost(PostDTO dto)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("topicName", dto.getTopicName());
		paramMap.put("status", dto.getStatus());
		paramMap.put("username", dto.getUsername());
		paramMap.put("postName", dto.getPostName());
		paramMap.put("realname", dto.getRealname());
		paramMap.put("topicId", dto.getTopicId());
		paramMap.put("topicStatus", dto.getTopicStatus());
		return this.paging("qry.post.list", dto, paramMap);
	}

	/**
	 * 条件查询帖子信息
	 */
	public List<PostDTO> qryPostByMap(Map<String, Object> param)
	{
		return this.getSqlMapClientTemplate().queryForList("qry.post.list", param);
	}

	/**
	 * 更新帖子
	 * 
	 * @param dto
	 */
	public void updatePost(PostDTO dto)
	{
		this.getSqlMapClientTemplate().update("update.post", dto);
	}

	/**
	 * 分页查询回复列表
	 */
	public PaginatedDTO<ReplyDTO> qryPageReply(ReplyDTO dto)
	{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("status", dto.getStatus());
		paramMap.put("username", dto.getUsername());
		paramMap.put("postName", dto.getPostName());
		paramMap.put("realname", dto.getRealname());
		paramMap.put("postId", dto.getPostId());
		return this.paging("qry.reply.list", dto, paramMap);
	}

	/**
	 * 插入回复
	 */
	public Long addReply(ReplyDTO dto)
	{
		return (Long) this.getSqlMapClientTemplate().insert("insert.reply", dto);
	}

	/**
	 * 查询帖子数量
	 */
	public Integer qryPostNum(Map<String, Object> param)
	{
		return (Integer) this.getSqlMapClientTemplate().queryForObject("qry.post.num", param);
	}

	/**
	 * 查询回复数量
	 */
	public Integer qryReplyNum(Map<String, Object> param)
	{
		return (Integer) this.getSqlMapClientTemplate().queryForObject("qry.reply.num", param);
	}

	/**
	 * 查询最新的回复
	 */
	public ReplyDTO qryReplyNewest(ReplyDTO dto)
	{
		return (ReplyDTO) this.getSqlMapClientTemplate().queryForObject("qry.reply.newest", dto);
	}

}
