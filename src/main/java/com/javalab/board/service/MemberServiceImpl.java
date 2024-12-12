package com.javalab.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.javalab.board.repository.MemberRepository;
import com.javalab.board.vo.MemberVo;
import com.javalab.board.vo.RoleVo;

import lombok.RequiredArgsConstructor;

/**
 * 회원 관련 서비스 구현 클래스.
 * 이 클래스는 회원 정보를 관리하는 비즈니스 로직을 포함합니다.
 */
@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
    private final MemberRepository repository; // 회원 정보를 관리하는 레포지토리

    /**
     * 모든 회원 정보를 조회합니다.
     *
     * @return 회원 목록
     */
    @Override
    public List<MemberVo> getMemberList() {
        return repository.getMemberList();
    }

    /**
     * 특정 회원 정보를 조회합니다.
     *
     * @param memberId 조회할 회원의 ID
     * @return 해당 회원의 정보 (MemberVo 객체)
     */
    @Override
    public MemberVo getMember(String memberId) {
        return repository.getMember(memberId);
    }

    /**
     * 회원 아이디 중복 여부를 확인합니다.
     *
     * @param memberId 중복 체크할 회원 ID
     * @return 중복 여부 (true: 중복, false: 중복 아님)
     */
    public boolean isMemberIdDuplicated(String memberId) {
        int result = repository.existsById(memberId); // 결과는 1(중복) 또는 0(중복아님)
        return result > 0; // 1/0을 true(중복)/false(중복아님)로 변환
    }

    /**
     * 새로운 회원을 등록합니다.
     *
     * @param memberVo 등록할 회원의 정보
     * @return 등록 성공 시 1, 실패 시 0
     */
    @Override
    public int insertMember(MemberVo memberVo) {
        return repository.insertMember(memberVo);
    }

    /**
     * 기존 회원 정보를 수정합니다.
     *
     * @param memberVo 수정할 회원의 정보
     * @return 수정 성공 시 1, 실패 시 0
     */
    @Override
    public int updateMember(MemberVo memberVo) {
        return repository.updateMember(memberVo);
    }

    /**
     * 특정 회원을 삭제합니다.
     *
     * @param memberId 삭제할 회원의 ID
     * @return 삭제 성공 시 1, 실패 시 0
     */
    @Override
    public int deleteMember(String memberId) {
        return repository.deleteMember(memberId);
    }
}
