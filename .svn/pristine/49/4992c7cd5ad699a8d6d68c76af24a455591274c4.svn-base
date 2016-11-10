package com.tsh.dictionary.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.tsh.common.pagination.PaginatedDAO;
import com.tsh.dictionary.entity.DictDTO;

@Repository
public class DictDao extends PaginatedDAO
{

	/**
	 * 查询数据字典列表
	 * @param dto
	 * @return
	 */
	public List<DictDTO> qryDictByDataType(DictDTO dto){
		return this.getSqlMapClientTemplate().queryForList("dictList.query", dto);
	}
	
	/**
	 * 保存数据字典
	 * @param dto
	 * @return
	 */
	public Object saveDict(DictDTO dto) {
		return this.getSqlMapClientTemplate().insert("dict.save", dto);
	}
	
	/**
	 * 新增数据字典
	 * @param dto
	 * @return
	 */
	public int updateDict(DictDTO dto) {
		return this.getSqlMapClientTemplate().update("dict.update", dto);
	}
}
