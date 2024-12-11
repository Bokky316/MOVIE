package com.javalab.board.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 영화 정보와 이미지 정보를 함께 담는 클래스
 * - 영화정보(MovieVo)와 이미지 정보(ImgVo)를 조인한 결과를 담는 클래스
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter 
@Setter
@ToString
public class MovieWithImageVo {
	// 속성, 필드, 멤버변수
	private Long movieId;			// 영화ID
	private String name;			// 영화명
	private String description;		// 영화설명
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date movieDate;			// 영화개봉일
	
	private Date regDate;			// 영화등록일
	private String imgPath;			// 대표 이미지 경로
	private String fileName;		// 대표 이미지명
	private List<ImgVo> imgList;	// 한 영화의 여러개 이미지
}
