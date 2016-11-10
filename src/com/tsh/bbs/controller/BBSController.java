package com.tsh.bbs.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tsh.bbs.entity.PostDTO;
import com.tsh.bbs.entity.ReplyDTO;
import com.tsh.bbs.entity.TopicDTO;
import com.tsh.bbs.service.BBSService;
import com.tsh.common.BaseController;
import com.tsh.common.pagination.PaginatedDTO;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("bbs")
public class BBSController extends BaseController
{

	private final static Logger logger = Logger.getLogger(BBSController.class);

	@Autowired
	private BBSService bbsService;

	@RequestMapping("toTopicMain")
	public String toTopicMain(HttpServletRequest request, HttpServletResponse response)
	{
		return "bbs/manage/topic_main";
	}

	/**
	 * 分页查询话题列表
	 */
	@RequestMapping("qryTopicList")
	public void qryTopicList(HttpServletRequest request, HttpServletResponse response, TopicDTO dto)
	{
		// 分页查询患者信息
		// 获取分页参数
		int pageNumber = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));
		int pageSize = request.getParameter("rows") == null ? 10 : Integer.valueOf(request.getParameter("rows"));
		dto.setPageNumber(pageNumber);
		dto.setPageSize(pageSize);
		try
		{
			if (dto.getTopicName() != null)
			{
				String topicName = URLDecoder.decode(dto.getTopicName(), "UTF-8");// 把传来的URL转换成中文
				dto.setTopicName(topicName);
			}
			PaginatedDTO<TopicDTO> pageList = bbsService.qryPageTopic(dto);
			for(TopicDTO topicDTO:pageList.getDataList())
			{
				initPostNum(topicDTO);
			}
			JSONObject result = new JSONObject();
			result.put("total", pageList.getTotal());
			result.put("rows", pageList.getDataList());
			result.put("currPage", pageList.getPageNumber());
			result.put("pageSize", pageList.getPageSize());
			this.printJSON(response, result);
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * 添加话题
	 */
	@RequestMapping("addTopic")
	public void addTopic(HttpServletRequest request, HttpServletResponse response, TopicDTO dto)
	{
		JSONObject result = new JSONObject();
		try
		{

			if (StringUtils.isEmpty(dto.getTopicName()))
			{
				result.put("resultCode", "-1");
				result.put("note", "话题名称不能为空!");
				this.printJSON(response, result);
				return;
			}

			// 封装参数
			JSONObject user = (JSONObject) request.getSession().getAttribute("user");
			Long userId = Long.valueOf(user.optString("userId"));
			Date now = new Date();

			dto.setCreateBy(userId);
			dto.setUpdateBy(userId);
			dto.setCreateDate(now);
			dto.setUpdateDate(now);
			dto.setUserId(userId);
			bbsService.addTopic(dto);

			result.put("resultCode", "0");
			result.put("note", "添加话题成功！");
			this.printJSON(response, result);
			return;
		}
		catch (Exception e)
		{

			result.put("resultCode", "-200");
			result.put("note", "系统异常！");
			this.printJSON(response, result);
			logger.error("插入话题失败！", e);
			return;
		}

	}

	/**
	 * 条件查询话题
	 */
	@RequestMapping("qryTopic")
	public void qryTopic(HttpServletRequest request, HttpServletResponse response)
	{
		JSONObject result = new JSONObject();
		String id = request.getParameter("id");
		if (StringUtils.isEmpty(id))
		{
			result.put("resultCode", "-1");
			result.put("note", "id为空！");
			this.printJSON(response, result);
			return;
		}

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", id);
		TopicDTO dto = bbsService.qryTopicByMap(param).get(0);
		
		initPostNum(dto);
		result.put("resultCode", "0");
		result.put("note", "查询成功");
		result.put("topic", dto);
		this.printJSON(response, result);
		return;
	}

	private void initPostNum(TopicDTO dto)
	{
		Map<String, Object> paramNum=new HashMap<String,Object>();
		paramNum.put("postStatus", "2");
		paramNum.put("topicId", dto.getId());
		dto.setPostNum(bbsService.qryPostNum(paramNum));
		paramNum.put("postStatus", "1");
		dto.setSavePostNum(bbsService.qryPostNum(paramNum));
		paramNum.put("postStatus", "3");
		dto.setUnUsePostNum(bbsService.qryPostNum(paramNum));
	}

	/**
	 * 修改话题
	 */
	@RequestMapping("editTopic")
	public void editTopic(HttpServletRequest request, HttpServletResponse response, TopicDTO dto)
	{
		JSONObject result = new JSONObject();
		try
		{

			if (StringUtils.isEmpty(dto.getTopicName()))
			{
				result.put("resultCode", "-1");
				result.put("note", "话题名称不能为空!");
				this.printJSON(response, result);
				return;
			}

			// 封装参数
			JSONObject user = (JSONObject) request.getSession().getAttribute("user");
			Long userId = Long.valueOf(user.optString("userId"));
			Date now = new Date();

			dto.setUpdateBy(userId);
			dto.setUpdateDate(now);
			dto.setUserId(userId);
			bbsService.updateTopic(dto);
			result.put("resultCode", "0");
			result.put("note", "添加话题成功！");
			this.printJSON(response, result);
			return;
		}
		catch (Exception e)
		{

			result.put("resultCode", "-200");
			result.put("note", "系统异常！");
			this.printJSON(response, result);
			logger.error("插入话题失败！", e);
			return;
		}

	}

	/**
	 * 进入添加帖子页面
	 */
	@RequestMapping("toAddPost")
	public String toAddPost(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		String topicId = request.getParameter("topicId");
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", topicId);
		TopicDTO dto = bbsService.qryTopicByMap(param).get(0);
		initPostNum(dto);
		model.addAttribute("topic", dto);
		return "bbs/manage/post_add";
	}

	/**
	 * 添加帖子
	 */
	@RequestMapping("addPost")
	public void addPost(HttpServletRequest request, HttpServletResponse response, PostDTO dto)
	{
		JSONObject result = new JSONObject();
		try
		{

			JSONObject user = (JSONObject) request.getSession().getAttribute("user");
			if (bbsService.addPost(dto, user, result) != null)
			{
				result.put("resultCode", "0");
				result.put("note", "添加帖子成功！");
				this.printJSON(response, result);
				return;
			}
			else
			{
				this.printJSON(response, result);
				return;
			}
		}
		catch (Exception e)
		{
			result.put("resultCode", "-200");
			result.put("note", "系统异常！");
			this.printJSON(response, result);
			logger.error("插入帖子失败！", e);
			return;
		}
	}

	/**
	 * 进入帖子管理主页
	 */
	@RequestMapping("toPostMain")
	public String toPostMain(HttpServletRequest request, HttpServletResponse response)
	{
		return "bbs/manage/post_main";
	}

	/**
	 * 分页查询帖子
	 */
	@RequestMapping("qryPostList")
	public void qryPostList(HttpServletRequest request, HttpServletResponse response, PostDTO dto)
	{
		// 分页查询患者信息
		// 获取分页参数
		int pageNumber = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));
		int pageSize = request.getParameter("rows") == null ? 10 : Integer.valueOf(request.getParameter("rows"));
		dto.setPageNumber(pageNumber);
		dto.setPageSize(pageSize);
		try
		{
			if (dto.getTopicName() != null)
			{
				String topicName = URLDecoder.decode(dto.getTopicName(), "UTF-8");// 把传来的URL转换成中文
				dto.setTopicName(topicName);
			}
			if (dto.getPostName() != null)
			{
				String postName = URLDecoder.decode(dto.getPostName(), "UTF-8");// 把传来的URL转换成中文
				dto.setPostName(postName);
			}
			dto.setTopicStatus("2");
			PaginatedDTO<PostDTO> pageList = bbsService.qryPagePost(dto);
			for(PostDTO postDTO:pageList.getDataList())
			{
				initReplyNum(postDTO);
			}
			
			JSONObject result = new JSONObject();
			result.put("total", pageList.getTotal());
			result.put("rows", pageList.getDataList());
			this.printJSON(response, result);
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
	}

	private void initReplyNum(PostDTO postDTO)
	{
		Map<String,Object> paramNum=new HashMap<String,Object>();
		paramNum.put("postStatus", "2");
		paramNum.put("postId", postDTO.getId());
		postDTO.setReplyNum(bbsService.qryReplyNum(paramNum));
	}

	/**
	 * 进入修改帖子页面
	 */
	@RequestMapping("toEditPost")
	public String toEditPost(HttpServletRequest request, HttpServletResponse response, Model model)
	{
		String postId = request.getParameter("postId");
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", postId);
		PostDTO dto = bbsService.qryPostByMap(param).get(0);
		param.put("id", dto.getTopicId());
		TopicDTO topicDTO = bbsService.qryTopicByMap(param).get(0);
		initPostNum(topicDTO);
		model.addAttribute("post", dto);
		model.addAttribute("topic", topicDTO);
		return "bbs/manage/post_edit";
	}

	/**
	 * 修改帖子
	 */
	@RequestMapping("editPost")
	public void editPost(HttpServletRequest request, HttpServletResponse response, PostDTO dto)
	{
		JSONObject result = new JSONObject();
		try
		{

			JSONObject user = (JSONObject) request.getSession().getAttribute("user");
			if (bbsService.updatePost(dto, user, result))
			{
				result.put("resultCode", "0");
				result.put("note", "修改成功！");
				this.printJSON(response, result);
				return;
			}
			else
			{
				this.printJSON(response, result);
				return;
			}
		}
		catch (Exception e)
		{
			result.put("resultCode", "-200");
			result.put("note", "无权限修改！");
			this.printJSON(response, result);
			logger.error("插入帖子失败！", e);
			return;
		}
	}

	/**
	 * 进入回复管理界面
	 */
	@RequestMapping("toViewReply")
	public String toReplyMain(HttpServletRequest request, HttpServletResponse response, ReplyDTO dto,Model model)
	{
		// 分页查询患者信息
		// 获取分页参数
		int pageNumber = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));
		int pageSize = request.getParameter("rows") == null ? 10 : Integer.valueOf(request.getParameter("rows"));
		dto.setPageNumber(pageNumber);
		dto.setPageSize(pageSize);
		PaginatedDTO<ReplyDTO> pageList = bbsService.qryPageReply(dto);

		// 查询帖子信息
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", dto.getPostId());
		PostDTO postDTO = bbsService.qryPostByMap(param).get(0);
		initReplyNum(postDTO);
		model.addAttribute("rows", pageList.getDataList());
		model.addAttribute("post", postDTO);
		model.addAttribute("total", pageList.getTotal());
		model.addAttribute("currPage", pageList.getPageNumber());
		model.addAttribute("pageCount", pageList.getPageCount());
		model.addAttribute("pageSize", pageList.getPageSize());

		return "bbs/manage/reply_main";
	}
	
	/**
	 * 添加回复
	 */
	@RequestMapping("addReply")
	public void addReply(HttpServletRequest request, HttpServletResponse response, ReplyDTO dto)
	{
		JSONObject result = new JSONObject();
		try
		{
			JSONObject user = (JSONObject) request.getSession().getAttribute("user");
			dto.setStatus("2");
			if (bbsService.addReply(dto, user, result) != null)
			{
				result.put("resultCode", "0");
				result.put("note", "回复成功！");
				this.printJSON(response, result);
				return;
			}
			else
			{
				this.printJSON(response, result);
				return;
			}
		}
		catch (Exception e)
		{
			result.put("resultCode", "-200");
			result.put("note", "系统异常！");
			this.printJSON(response, result);
			logger.error("回复帖子失败！", e);
			return;
		}
	}

}
