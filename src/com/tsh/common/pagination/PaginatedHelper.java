package com.tsh.common.pagination;

import java.io.Serializable;

/**
 * 分页参数读取辅助类
 *
 */
public class PaginatedHelper implements Serializable {
	// 每页记录条数
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected int page=1;
	protected int rows;

	// 开始位置
	protected int startIndex;
	protected int endIndex;
	public static final int PAGE_SIZE = 15;
	/**
	 * 获取当前页
	 * @return
	 */
	public int getCurrentPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public void setRows(int rows) {
		if (rows > 0) {
			this.rows = rows;
		} else {
			this.rows = PAGE_SIZE;
		}
	}
	// 计算查询开始位置
	private void calculatestartIndex() {
		if (this.page > 0) {
		} else {
			page = 1;
		}
		this.startIndex = (this.page - 1) * this.rows;
	}
	
	/**
	 * 取得开始位置
	 * @return
	 */
	public int getStartIndex() {
		calculatestartIndex();
		return startIndex;
	}
	
	public int getEndIndex(){
		calculatestartIndex();
		return startIndex+rows;
	}
	public int getPageSize(){
		return this.rows;
	}
	public int getRows() {
		return rows;
	}
}
