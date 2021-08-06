package com.myweb.persistence.alarm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.myweb.domain.AlarmVO;

@Repository
public class AlarmDAO implements AlarmDAORule {
	private static Logger logger = LoggerFactory.getLogger(AlarmDAO.class);
	private String NS="AlarmMapper.";

	@Inject
	private SqlSession sql;
	
	@Override
	public int getAlarm(AlarmVO avo) {
		return sql.insert(NS+"reg",avo);
	}

	@Override
	public List<AlarmVO> getAlarmList(String memberID) {
		return sql.selectList(NS+"list",memberID);
	}

	@Override
	public int updateAlarm(int ano) {
		return sql.update(NS+"checkAlarm",ano);
	}

	@Override
	public int selectCount(String memberID) {
		return sql.selectOne(NS+"count",memberID);
	}
}
