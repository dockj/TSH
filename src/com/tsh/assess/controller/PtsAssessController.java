package com.tsh.assess.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tsh.assess.entity.AssessDTO;
import com.tsh.assess.entity.ResultDTO;
import com.tsh.assess.entity.TypeDTO;
import com.tsh.assess.service.AssessService;
import com.tsh.common.BaseController;
import com.tsh.common.pagination.PaginatedDTO;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/ptsAssess")
public class PtsAssessController extends BaseController
{
	@Autowired
	private AssessService assessService;

	/**
	 * 生产自评表
	 */
	@RequestMapping("generateAssess")
	public String generateAssess(HttpServletRequest request, HttpServletResponse response, Model model)
	{

		List<AssessDTO> assessDTOs = assessService.generateAssess();
		model.addAttribute("rows", assessDTOs);
		return "assess/pts/self_assess";
	}

	/**
	 * 提交自评信息
	 */
	@RequestMapping("submitAssess")
	public void submit(HttpServletRequest request, HttpServletResponse response)
	{
		JSONObject result = new JSONObject();
		try
		{
			// 1、获取题目
			String[] assessIds = request.getParameterValues("assessIds");
			if (assessIds == null)
			{
				result.put("resultCode", "-1");
				result.put("note", "系统异常！");
				this.printJSON(response, result);
				return;
			}
			// 获取每个题目的每个答案
			List<String> scoreIds = new ArrayList<String>();
			// 计算总分
			double count = 0;
			for (int i = 0; i < assessIds.length; i++)
			{
				String scoreId = request.getParameter("score_" + assessIds[i]);
				if (scoreId == null)
				{
					result.put("resultCode", "-2");
					result.put("note", "第" + (i + 1) + "题，无结果！");
					this.printJSON(response, result);
					return;
				}
				String[] scoreIdAndScore = scoreId.split("_");
				count += Double.valueOf(scoreIdAndScore[1]);
				scoreIds.add(scoreIdAndScore[0]);
			}

			// 获取用户信息
			JSONObject user = (JSONObject) request.getSession().getAttribute("user");
			assessService.insertAssessResult(assessIds, scoreIds, count, user);
			result.put("resultCode", "0");
			result.put("note", "提交成功");
		}
		catch (Exception e)
		{
			result.put("resultCode", "-200");
			result.put("note", "系统异常！");
		}
		this.printJSON(response, result);
		return;

	}

	/**
	 * 查看评测结果
	 */
	@RequestMapping("viewAssessResult")
	public String viewAssessResult(HttpServletRequest request, HttpServletResponse response, Model model, ResultDTO dto)
	{
		JSONObject user=(JSONObject) request.getSession().getAttribute("user");
		// 获取分页参数
		int pageNumber = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));
		int pageSize = request.getParameter("rows") == null ? 10 : Integer.valueOf(request.getParameter("rows"));
		dto.setPageNumber(pageNumber);
		dto.setPageSize(pageSize);
		dto.setUserId(user.optLong("userId"));
		try
		{
			if (dto.getUsername() != null)
			{
				String username = URLDecoder.decode(dto.getUsername(), "UTF-8");// 把传来的URL转换成中文
				dto.setUsername(username);
			}
			PaginatedDTO<ResultDTO> pageList = assessService.qryPageAssessResult(dto);

			if (pageList == null || pageList.getDataList() == null || pageList.getDataList().size() < 1)
			{
				pageList.setDataList(new ArrayList<ResultDTO>());
			}
			
			for(ResultDTO resultDTO:pageList.getDataList())
			{
				Map<String, Object> param=new HashMap<String,Object>();
				param.put("evaId", resultDTO.getId());
				param.put("userId", user.optString("userId"));
				List<TypeDTO> typeDTOs=assessService.qryAssessTypeResult(param);
				resultDTO.setTypes(typeDTOs);
			}
			
			model.addAttribute("rows", pageList.getDataList());
			model.addAttribute("total", pageList.getTotal());
			model.addAttribute("currPage", pageList.getPageNumber());
			model.addAttribute("pageCount", pageList.getPageCount());
			model.addAttribute("pageSize", pageList.getPageSize());
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
		return "assess/pts/assess_result";
	}

}
