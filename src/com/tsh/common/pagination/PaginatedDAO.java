package com.tsh.common.pagination;

import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

public class PaginatedDAO extends SqlMapClientDaoSupport {
  
	public PaginatedDTO paging(String statementName,PaginatedDTO paginatedDTO,Map<String,Object> paramMap){
		int rows = (Integer)getSqlMapClientTemplate().queryForObject(statementName+".total",paramMap);
		paginatedDTO.setTotal(rows);
		if(rows==0){
			return paginatedDTO;
		}
		int pageCount = 1;
		if(rows%paginatedDTO.getPageSize()==0){
			pageCount = rows/paginatedDTO.getPageSize();
		}else{
			if(rows/paginatedDTO.getPageSize()!=0){
				pageCount = rows/paginatedDTO.getPageSize()+1;
			}
		}
		paginatedDTO.setPageCount(pageCount);
		if(paginatedDTO.getPageNumber()<=0){
			paginatedDTO.setPageNumber(1);
		}
		if(paginatedDTO.getPageNumber()>pageCount){
			paginatedDTO.setPageNumber(pageCount);
		}
		int pageNumber = paginatedDTO.getPageNumber();
		int pageSize = paginatedDTO.getPageSize();
		paramMap.put("skipIndex", (pageNumber-1)*pageSize);
		paramMap.put("skipRows", pageSize);
		paramMap.put("paginationFlag", true);
		paginatedDTO.setDataList(getSqlMapClientTemplate().queryForList(statementName,paramMap));
		return paginatedDTO;
	}
}
