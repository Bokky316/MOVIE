package com.javalab.board.repository;

import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.javalab.board.vo.MemberVo;

public interface LoginRepository {
    // 사용자 아이디와 비밀번호로 사용자 조회 (Map을 사용)
    MemberVo checkLogin(Map<String, String> params);
}
