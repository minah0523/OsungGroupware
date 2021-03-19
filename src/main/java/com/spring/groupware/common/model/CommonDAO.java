package com.spring.groupware.common.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CommonDAO implements InterCommonDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

}
