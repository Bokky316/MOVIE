package com.javalab.board.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.javalab.board.service.MemberService;
import com.javalab.board.vo.BoardVo;
import com.javalab.board.vo.MemberVo;
import com.javalab.board.vo.ResponseVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member") // 클래스 차원의 RequestMapping
@RequiredArgsConstructor
@Slf4j
public class MemberController {
	private final MemberService memberService; // 회원 서비스 주입

	/**
	 * 회원 목록 조회 - 모든 회원 정보를 가져와서 모델에 추가하고, 회원 목록 JSP를 반환합니다.
	 */
	@GetMapping("/list")
	public String listMembers(Model model) {
		List<MemberVo> memberList = memberService.getMemberList(); // 회원 목록 조회
		model.addAttribute("memberList", memberList); // 모델에 회원 목록 추가
		return "member/memberList"; // JSP 이름 반환
	}

	/**
	 * 회원 상세 보기 - 특정 회원 ID를 받아 해당 회원 정보를 조회하여 모델에 추가합니다.
	 */
	@GetMapping("/view")
	public String viewMember(@RequestParam("memberId") String memberId, Model model) {
		MemberVo member = memberService.getMember(memberId); // 회원 정보 조회
		model.addAttribute("member", member); // 모델에 회원 정보 추가
		return "member/memberView"; // JSP 이름 반환
	}
	
    /**
     * 특정 회원의 마이페이지
     * - 특정 회원 ID를 받아 해당 회원 정보를 조회하여 모델에 추가합니다.
     */
	@GetMapping("/myPage")
	public String myPage(@SessionAttribute("loginUser") MemberVo loginUser, Model model, HttpSession session) {
	    // 세션에서 로그인한 사용자 정보를 가져와 모델에 추가
	
	    model.addAttribute("member", loginUser);
	    return "member/myPage"; // 마이페이지 JSP 호출
	}

	/**
	 * 회원 등록 폼 - 빈 MemberVo 객체를 모델에 추가하여 회원 등록 폼을 표시합니다.
	 */
	@GetMapping("/insert")
	public String insertMemberForm(Model model, HttpSession session) {

		if (session.getAttribute("loginUser") != null) {
			return "redirect:/"; // 기본 홈 페이지로 리다이렉트
		}
		model.addAttribute("member", new MemberVo()); // 빈 객체를 모델에 추가
		return "member/memberInsert"; // JSP 이름 반환
	}

	/**
	 * 회원 등록 처리 - 폼에서 입력된 회원 정보를 MemberVo 객체로 바인딩하여 처리합니다. - 아이디 중복 여부를 확인하고, 중복일 경우
	 * 오류 메시지를 모델에 추가합니다.
	 */
	@PostMapping("/insert")
	public String insertMember(@ModelAttribute("member") MemberVo memberVo, Model model) {
		log.info("insertMember ==============");

		try {
			// 아이디 중복 확인
			if (memberService.isMemberIdDuplicated(memberVo.getMemberId())) {
				model.addAttribute("errorMessage", "이미 사용 중인 아이디입니다."); // 오류 메시지 추가
				return "member/memberInsert"; // 입력 화면으로 돌아감
			}
			memberService.insertMember(memberVo); // 회원 등록 처리
			return "redirect:/member/list"; // 성공 시 회원 목록으로 리다이렉트
		} catch (Exception e) {
			model.addAttribute("errorMessage", "회원 등록 중 오류가 발생했습니다."); // 오류 메시지 추가
			return "member/memberInsert"; // 입력 화면으로 돌아감
		}
	}

	/**
	 * 회원 수정 폼 - 특정 회원 ID를 받아 기존 데이터를 조회하여 수정 폼을 표시합니다.
	 */
	@GetMapping("/update")
	public String updateMemberForm(@RequestParam("memberId") String memberId, Model model) {
		MemberVo member = memberService.getMember(memberId); // 기존 데이터 조회
		model.addAttribute("member", member); // 모델에 기존 데이터 추가
		return "member/memberUpdate"; // JSP 이름 반환
	}

	/**
	 * 회원 수정 처리 - 수정된 정보를 받아서 업데이트하고, 성공 시 이전 페이지로  리다이렉트합니다.
	 */
	@PostMapping("/update")
	public String updateMember(@ModelAttribute("member") MemberVo memberVo, Model model, HttpSession session, HttpServletRequest request) {
		 // 현재 URL을 세션에 저장
        String currentUrl = request.getHeader("Referer");
        session.setAttribute("prevPage", currentUrl); // 이전 페이지 URL 저장
		try {
			memberService.updateMember(memberVo); // 회원 정보 수정 처리
			return "redirect:/"; // 성공 시 이전 페이지로 리다이렉트
		} catch (Exception e) {
			model.addAttribute("errorMessage", "회원 수정 중 오류가 발생했습니다."); // 오류 메시지 추가
			return "member/memberUpdate"; // 오류 발생 시 수정 폼으로 다시 이동
		}
	}

	/**
	 * 회원 삭제 처리 - 특정 회원 ID를 받아 해당 회원을 삭제하고, 성공 시 목록으로 리다이렉트합니다.
	 */
	@PostMapping("/delete")
	public String deleteMember(@RequestParam("memberId") String memberId, Model model) {
		try {
			memberService.deleteMember(memberId); // 회원 삭제 처리
			return "redirect:/member/list"; // 성공 시 회원 목록 페이지로 이동
		} catch (Exception e) {
			try {
				// 오류 메시지를 URL에 포함시키기 위해 인코딩
				String errorMessage = URLEncoder.encode("회원 삭제 중 오류가 발생했습니다: ", StandardCharsets.UTF_8.toString());
				return "redirect:/member/view?memberId=" + memberId + "&errorMessage=" + errorMessage; // 오류 발생 시 상세 보기로
																										// 리다이렉트
			} catch (Exception encodingException) {
				return "redirect:/member/view?memberId=" + memberId + "&errorMessage=Unknown%20error"; // 인코딩 실패 시 기본 오류
																										// 메시지 처리
			}
		}
	}

	/**
	 * 아이디 중복 확인 처리 - 클라이언트에서 전달된 아이디의 중복 여부를 확인하여 응답합니다.
	 */
	@GetMapping("/checkId")
	public ResponseEntity<ResponseVo> checkId(@RequestParam("memberId") String memberId) {
		boolean isDuplicate = memberService.isMemberIdDuplicated(memberId); // 중복 여부 확인
		String message = isDuplicate ? "이미 사용 중인 아이디입니다." : "사용 가능한 아이디입니다."; // 메시지 설정

		ResponseVo responseVo = new ResponseVo(isDuplicate, message); // 응답 객체 생성

		return ResponseEntity.ok(responseVo); // HttpStatus.OK와 함께 응답 반환
	}

}
