package com.tsh.bbs.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Param;
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
@RequestMapping("ptsBBS")
public class PtsBBSController extends BaseController
{

	private final static Logger logger = Logger.getLogger(BBSController.class);

	@Autowired
	private BBSService bbsService;

	@RequestMapping("toMain")
	public String toMain(HttpServletRequest request, HttpServletResponse response, Model model, TopicDTO dto)
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
			dto.setStatus("2");
			PaginatedDTO<TopicDTO> pageList = bbsService.qryPageTopic(dto);
			PaginatedDTO<PostDTO> postList = null;
			for (TopicDTO topicDTO : pageList.getDataList())
			{

				// 分页查询post
				PostDTO postDTO = new PostDTO();
				postDTO.setStatus("2");
				postDTO.setTopicId(topicDTO.getId());
				postDTO.setPageNumber(1);
				postDTO.setPageSize(5);
				postList = bbsService.qryPagePost(postDTO);
				for (PostDTO postDTO2 : postList.getDataList())
				{
					int len = 0;
					if (postDTO2.getPostContent().length() <= 100)
					{
						len = postDTO2.getPostContent().length();
					}
					else
					{
						len = 100;
					}
					postDTO2.setPostContent(postDTO2.getPostContent().substring(0, len));
					initPostNum(topicDTO);
					initReplyNum(postDTO2);
				}
				topicDTO.setPosts(postList.getDataList());
			}
			model.addAttribute("topics", pageList.getDataList());
			model.addAttribute("total", pageList.getTotal());
			model.addAttribute("currPage", pageList.getPageNumber());
			model.addAttribute("pageCount", pageList.getPageCount());
			model.addAttribute("pageSize", pageList.getPageSize());

		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
		return "bbs/pts/pts_bbs_main";
	}

	/**
	 * 创建帖子
	 */
	@RequestMapping("toAddPost")
	public String toAddPost(HttpServletResponse response, HttpServletRequest request, Model model)
	{
		String topicId = request.getParameter("topicId");
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", topicId);
		TopicDTO dto = bbsService.qryTopicByMap(param).get(0);
		initPostNum(dto);
		model.addAttribute("topic", dto);
		return "bbs/pts/pts_add_post";
	}

	/**
	 * 新增帖子
	 */
	@RequestMapping("addPost")
	public void addPost(HttpServletRequest request, HttpServletResponse response, PostDTO dto)
	{
		JSONObject result = new JSONObject();
		dto.setStatus("2");
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
	 * 分页查询回复数
	 */
	@RequestMapping("toViewReply")
	public String toViewReply(HttpServletRequest request, HttpServletResponse response, ReplyDTO dto, Model model)
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
		return "bbs/pts/pts_bbs_reply";
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

	/**
	 * 查询更多
	 */
	@RequestMapping("toSeeMore")
	public String toSeeMore(HttpServletRequest request, HttpServletResponse response,PostDTO dto,Model model)
	{
		
		// 分页查询患者信息
		// 获取分页参数
		int pageNumber = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));
		int pageSize = request.getParameter("rows") == null ? 10 : Integer.valueOf(request.getParameter("rows"));
		dto.setPageNumber(pageNumber);
		dto.setPageSize(pageSize);
		dto.setStatus("2");
		PaginatedDTO<PostDTO> pageList = bbsService.qryPagePost(dto);
		for (PostDTO postDTO2 : pageList.getDataList())
		{
			int len = 0;
			if (postDTO2.getPostContent().length() <= 200)
			{
				len = postDTO2.getPostContent().length();
			}
			else
			{
				len = 200;
			}
			postDTO2.setPostContent(postDTO2.getPostContent().substring(0, len));
			initReplyNum(postDTO2);
		}
		// 查询帖子信息
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", dto.getTopicId());
		TopicDTO topicDTO = bbsService.qryTopicByMap(param).get(0);
		model.addAttribute("posts", pageList.getDataList());
		model.addAttribute("total", pageList.getTotal());
		model.addAttribute("currPage", pageList.getPageNumber());
		model.addAttribute("pageCount", pageList.getPageCount());
		model.addAttribute("pageSize", pageList.getPageSize());
		model.addAttribute("topic", topicDTO);
		return "bbs/pts/pts_bbs_more";
	}
	
	private void initReplyNum(PostDTO postDTO)
	{
		Map<String,Object> paramNum=new HashMap<String,Object>();
		paramNum.put("postStatus", "2");
		paramNum.put("postId", postDTO.getId());
		postDTO.setReplyNum(bbsService.qryReplyNum(paramNum));
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
}
