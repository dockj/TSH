package com.tsh.bbs.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tsh.bbs.dao.BBSDao;
import com.tsh.bbs.entity.PostDTO;
import com.tsh.bbs.entity.ReplyDTO;
import com.tsh.bbs.entity.TopicDTO;
import com.tsh.bbs.service.BBSService;
import com.tsh.common.pagination.PaginatedDTO;

import net.sf.json.JSONObject;

@Service
public class BBSServiceImpl implements BBSService
{
	@Autowired
	private BBSDao bbsDao;

	/**
	 * 分页查询话题列表
	 */
	@Override
	public PaginatedDTO<TopicDTO> qryPageTopic(TopicDTO dto)
	{
		return bbsDao.qryPageTopic(dto);
	}

	@Override
	public Long addTopic(TopicDTO dto)
	{
		return bbsDao.addTopic(dto);
	}

	@Override
	public List<TopicDTO> qryTopicByMap(Map<String, Object> param)
	{
		return bbsDao.qryTopicByMap(param);
	}

	@Override
	public void updateTopic(TopicDTO dto)
	{
		bbsDao.updateTopic(dto);
	}

	@Transactional
	@Override
	public Long addPost(PostDTO dto, JSONObject user, JSONObject result)
	{
		// 参数校验
		if (StringUtils.isEmpty(dto.getPostContent()))
		{
			result.put("resultCode", "-1");
			result.put("note", "帖子内容为空！");
			return null;
		}
		if (StringUtils.isEmpty(dto.getPostName()))
		{
			result.put("resultCode", "-2");
			result.put("note", "帖子名称为空！");
			return null;
		}
		if (StringUtils.isEmpty(dto.getStatus()))
		{
			result.put("resultCode", "-3");
			result.put("note", "帖子状态为空！");
			return null;
		}
		// 构建存库数据
		Long userId = Long.valueOf(user.optString("userId"));
		String realname = user.optString("realname");
		String username = user.optString("username");
		Date now = new Date();

		dto.setCreateBy(userId);
		dto.setUpdateBy(userId);
		dto.setUserId(userId);
		dto.setUsername(username);
		dto.setRealname(realname);
		dto.setCreateDate(now);
		dto.setUpdateDate(now);
		Long postId = bbsDao.addPost(dto);
		return postId;
	}

	@Override
	public PaginatedDTO<PostDTO> qryPagePost(PostDTO dto)
	{
		return bbsDao.qryPagePost(dto);
	}

	@Override
	public List<PostDTO> qryPostByMap(Map<String, Object> param)
	{
		return bbsDao.qryPostByMap(param);
	}

	@Transactional
	@Override
	public boolean updatePost(PostDTO dto, JSONObject user, JSONObject result)
	{
		// 参数校验
		if (StringUtils.isEmpty(dto.getPostContent()))
		{
			result.put("resultCode", "-1");
			result.put("note", "帖子内容为空！");
			return false;
		}
		if (StringUtils.isEmpty(dto.getPostName()))
		{
			result.put("resultCode", "-2");
			result.put("note", "帖子名称为空！");
			return false;
		}
		if (StringUtils.isEmpty(dto.getStatus()))
		{
			result.put("resultCode", "-3");
			result.put("note", "帖子状态为空！");
			return false;
		}
		// 查询老的帖子
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", dto.getId());
		PostDTO oldPost = bbsDao.qryPostByMap(param).get(0);
		// 构建存库数据
		Long userId = Long.valueOf(user.optString("userId"));
		String realname = user.optString("realname");
		String username = user.optString("username");
		Date now = new Date();

		dto.setUpdateBy(userId);
		dto.setUserId(userId);
		dto.setUsername(username);
		dto.setRealname(realname);
		dto.setUpdateDate(now);
		bbsDao.updatePost(dto);
		return true;
	}

	@Override
	public PaginatedDTO<ReplyDTO> qryPageReply(ReplyDTO dto)
	{
		return bbsDao.qryPageReply(dto);
	}

	@Transactional
	@Override
	public Long addReply(ReplyDTO dto, JSONObject user, JSONObject result)
	{
		if (dto.getPostId() == null)
		{
			result.put("resultCode", "-1");
			result.put("note", "postId为空");
			return null;
		}
		if (StringUtils.isEmpty(dto.getReplyContent()))
		{

			result.put("resultCode", "-2");
			result.put("note", "回复内容为空！");
			return null;
		}

		// 构造插入数据
		Long userId = Long.valueOf(user.optString("userId"));
		String realname = user.optString("realname");
		String username = user.optString("username");
		Date now = new Date();

		ReplyDTO newestReplyDto = bbsDao.qryReplyNewest(dto);
		if (newestReplyDto == null || newestReplyDto.getFloor() == null)
		{
			dto.setFloor(1);
		}
		else
		{
			dto.setFloor(newestReplyDto.getFloor() + 1);
		}

		dto.setCreateBy(userId);
		dto.setUpdateBy(userId);
		dto.setUpdateDate(now);
		dto.setCreateDate(now);
		dto.setUserId(userId);
		dto.setRealname(realname);
		dto.setUsername(username);
		Long replyId = bbsDao.addReply(dto);
		if (replyId != null)
		{
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("id", dto.getPostId());
			PostDTO postDTO = bbsDao.qryPostByMap(param).get(0);
			postDTO.setUpdateBy(userId);
			postDTO.setUpdateDate(now);
			bbsDao.updatePost(postDTO);
		}
		return replyId;
	}

	@Override
	public Integer qryPostNum(Map<String, Object> param)
	{
		return bbsDao.qryPostNum(param);
	}

	@Override
	public Integer qryReplyNum(Map<String, Object> paramNum)
	{
		return bbsDao.qryReplyNum(paramNum);
	}

}
