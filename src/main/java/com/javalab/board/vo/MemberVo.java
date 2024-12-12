package com.javalab.board.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
@ToString
public class MemberVo {
    private String memberId; // 회원 ID
    private String password; // 비밀번호
    private String name; // 이름
    private String email; // 이메일
    private Date regDate; // 가입 날짜
    private String phone; // 전화번호 
    private String roleId; // 역할 ID
}
