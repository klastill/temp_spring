package com.myweb.persistence.alarm;

import java.util.List;

import com.myweb.domain.AlarmVO;

public interface AlarmDAORule {
	public int getAlarm(AlarmVO avo);
	public List<AlarmVO> getAlarmList(String memberID);
	public int updateAlarm(int ano);
	public int selectCount(String memberID);
}
