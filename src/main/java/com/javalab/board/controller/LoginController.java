package com.javalab.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.javalab.board.service.LoginService;
import com.javalab.board.vo.MemberVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {

    @Autowired
    private LoginService loginService; // 로그인 서비스 주입

    // 로그인 화면 이동
    @GetMapping("/login")
    public String loginForm(HttpSession session, HttpServletRequest request) {
        // 세션에서 로그인 정보 확인
        MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");
        if (loginUser != null) {
            return "redirect:/";
        }

        // 현재 URL을 세션에 저장
        String currentUrl = request.getHeader("Referer");
        session.setAttribute("prevPage", currentUrl); // 이전 페이지 URL 저장

        // 로그인 폼으로 이동
        return "login/login";
    }
    
    // 로그인 처리
    @PostMapping("/login")
    public String login(String memberId, String password, HttpSession session, Model model) {
        // 로그인 서비스 호출
        MemberVo loginUser = loginService.checkLogin(memberId, password);
        log.info("loginUser: " + loginUser);
        
        if (loginUser != null) {
            // 로그인 성공 시 세션에 사용자 정보 저장
            session.setAttribute("loginUser", loginUser);
            
            // 이전 페이지 URL 가져오기
            String referer = (String) session.getAttribute("prevPage");
            if (referer != null && !referer.isEmpty()) {
                return "redirect:" + referer; // 이전 페이지로 리다이렉트
            } else {
                return "redirect:/"; // 기본 홈 페이지로 리다이렉트
            }
        } else {
            // 로그인 실패 시 에러 메시지와 함께 로그인 폼으로 이동
            model.addAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "login/login"; // 로그인 폼으로 돌아감
        }
    }

    // 로그아웃 처리
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 초기화
        return "redirect:/login"; // 로그인 페이지로 이동
    }
}
