package com.myweb.persistence.subscribe;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.myweb.domain.subscribe.SubscribeDTO;
import com.myweb.domain.subscribe.SubscribeVO;

//구독DAO by 동현,2021/07/06
@Repository
public class SubscribeDAO implements SubscribeDAORule {

	private final String NS="SubscribeMapper.";
	
	@Inject
	private SqlSession sql;
	
	//구독 신청
	@Override
	public int insert(SubscribeVO svo) {
		return sql.insert(NS+"reg",svo);
	}
	
	//구독 신청한 리스트
	@Override
	public List<SubscribeDTO> selectListSend(int mno) {
		return sql.selectList(NS+"listSend", mno);
	}

	//구독 신청받은 리스트
	@Override
	public List<SubscribeDTO> selectListReceived(int mno) {
		return sql.selectList(NS+"listReceived", mno);
	}
	// 구독 가능인지 체크
	@Override
	public SubscribeVO selectOneCheck(SubscribeVO svo) {
		 return sql.selectOne(NS+"subscribeCheck", svo);
		
	}
	// 구독 토글의 기능
	@Override
	public int updateSubscribe(SubscribeVO svo, int status) {
		Map<String,Integer> map = new HashMap<String, Integer>();
		map.put("sendNo", (Integer)svo.getSendNo());
		map.put("receiveNo", (Integer)svo.getReceiveNo());
		map.put("status", (Integer)status);
		return sql.update(NS+"changeSubscribe",map);
	}
	@Override
	public List<SubscribeDTO> selectRank4List() {
		return sql.selectList(NS+"listRank4");
	}
	@Override
	public int selectFollowerOne(int sendNo) {
		return sql.selectOne(NS+"followerNum", sendNo);
	}

	@Override
	public int selectFollowingOne(int mno) {
		return sql.selectOne(NS+"followingNum", mno);
	}

	
	
}
