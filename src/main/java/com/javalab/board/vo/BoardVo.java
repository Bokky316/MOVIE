package com.javalab.board.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 게시물 자바 빈즈 클래스
 * - 롬복 적용
 */
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class BoardVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private int boardNo;          // 게시물 번호    
    private String title;         // 게시물 제목
    private String content;       // 게시물 내용
    private String memberId;      // 게시물 작성자 ID
    private int hitNo;            // 조회수
    private Date regDate;         // 게시물 작성일자    
    /* 계층형 답변 게시판용 속성 */
    private int replyGroup = 0;   // 그룹 번호(본글과 답글을 묶어주는 역할) 
    private int replyOrder = 0;   // 그룹 내 순서(그룹 내에서의 순서를 결정) 
    private int replyIndent = 0;  // 들여쓰기(본글을 기준으로 depth가 내려갈 때마다 한칸씩 들여씀)
    private Float rating;         // 별점 (1.0 ~ 5.0)
    private String spoiler;       // 스포일러 체크

    private Long movieId;         // 영화 ID (외래키)
    private MovieWithImageVo movieWithImage;  // 영화 정보 추가
}
