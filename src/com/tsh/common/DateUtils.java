package com.tsh.common;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils
{
	public static String formate(Date date)
	{
		return new SimpleDateFormat("yyyy-MM-dd").format(date);
	}
}
