package com.tsh.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.sun.jndi.toolkit.url.Uri;

import net.sf.json.JSONObject;

public class LoginInterceptor extends HandlerInterceptorAdapter
{
	private List<String> uncheckUrls = new ArrayList<String>();

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
	{
		String uri = request.getRequestURI();
		uri=uri.substring(uri.indexOf("/", 1));
		if (uncheckUrls.contains(uri))
		{
			return true;
		}
		else
		{
			JSONObject user = (JSONObject) request.getSession().getAttribute("user");
			if (user == null)
			{
				response.sendRedirect(request.getContextPath()+"/users/toLogin");
				return false;
			}
			else
			{
				return true;
			}

		}
	}

	public List<String> getUncheckUrls()
	{
		return uncheckUrls;
	}

	public void setUncheckUrls(List<String> uncheckUrls)
	{
		this.uncheckUrls = uncheckUrls;
	}

}
