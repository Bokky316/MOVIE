package com.javalab.board.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javalab.board.repository.LoginRepository;
import com.javalab.board.vo.MemberVo;

@Service
public class LoginServiceImpl implements LoginService {

    @Autowired
    private LoginRepository loginRepository; // 로그인 레포지토리 주입

    // 사용자 로그인 확인
    public MemberVo checkLogin(String memberId, String password) {
        Map<String, String> params = new HashMap<>();
        params.put("memberId", memberId);
        params.put("password", password);
        
        return loginRepository.checkLogin(params); // 매퍼 호출하여 로그인 정보 확인
    }
}