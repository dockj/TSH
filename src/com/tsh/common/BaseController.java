package com.tsh.common;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.tsh.common.pagination.PaginatedDTO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 控制器基类
 * 
 * @author dinglei
 *
 */
public class BaseController
{

	private static Logger log = Logger.getLogger(BaseController.class);

	public static final String SUCCESS_KEY = "success";

	/**
	 * ajax return jsonObject
	 * 
	 * @param response
	 * @param jsonObject
	 */
	protected void printJSON(HttpServletResponse response, JSONObject jsonObject)
	{
		PrintWriter out = null;
		response.setContentType("application/x-json;charset=UTF-8");
		// response.setCharacterEncoding("UTF-8");
		try
		{
			out = response.getWriter();
			out.println(jsonObject);
		}
		catch (Exception e)
		{
			LogFactory.getLog(BaseController.class).error(e.getMessage());
		}
		finally
		{
			out.close();
		}
	}

	/**
	 * ajax return jsonArray
	 * 
	 * @param response
	 * @param jsonArray
	 */
	protected void printJSON(HttpServletResponse response, JSONArray jsonArray)
	{
		PrintWriter out = null;
		response.setContentType("application/x-json;charset=UTF-8");
		// response.setCharacterEncoding("UTF-8");
		try
		{
			out = response.getWriter();
			out.println(jsonArray);
		}
		catch (Exception e)
		{
			LogFactory.getLog(BaseController.class).error(e.getMessage());
		}
		finally
		{
			out.close();
		}
	}

	/**
	 * ajax return string
	 * 
	 * @param response
	 * @param object
	 */
	protected void printString(HttpServletResponse response, String object)
	{
		PrintWriter out = null;
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		try
		{
			out = response.getWriter();
			out.println(object);
		}
		catch (Exception e)
		{
			LogFactory.getLog(BaseController.class).error(e.getMessage());
		}
		finally
		{
			out.close();
		}
	}

	/**
	 * 返回页面提示框
	 * 
	 * @param response
	 * @param object
	 */
	protected void alertString(HttpServletResponse response, String object)
	{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out;
		try
		{
			out = response.getWriter();
			out.print("<script>alert('" + object + "');</script>");
			out.flush();
		}
		catch (IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	protected String getUtf8String(String str) throws UnsupportedEncodingException
	{
		if (StringUtils.isNotBlank(str))
		{
			str = new String(str.getBytes("iso-8859-1"), "utf-8");
		}
		return str;
	}

	/**
	 * 分页
	 * 
	 * @param request
	 * @return
	 */
	protected PaginatedDTO<HashMap<String, Object>> setPage(HttpServletRequest request)
	{
		// 获取分页参数
		int pageNumber = request.getParameter("page") == null ? 1 : Integer.valueOf(request.getParameter("page"));
		int pageSize = request.getParameter("rows") == null ? 10 : Integer.valueOf(request.getParameter("rows"));
		// 组装分页参数
		PaginatedDTO<HashMap<String, Object>> page = new PaginatedDTO<HashMap<String, Object>>();
		page.setPageNumber(pageNumber);
		page.setPageSize(pageSize);
		return page;
	}
}
