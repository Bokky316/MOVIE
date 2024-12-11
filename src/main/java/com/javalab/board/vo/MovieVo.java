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
 * 영화 클래스
 * - Long : 포장클래스, 오라클에 number와 매핑, int보다 더 많은 값을 저장, 
 * 			데이터베이스 값이 없을 경우 널을 저장할 수 있다. 하지만 int, long, double 기본형이기 때문에 
 * 			null 값을 저장할 수 없다. -> Long 포장클래스 사용 이유 
 * 
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class MovieVo {
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
