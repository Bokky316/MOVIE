package com.javalab.board.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 영화 이미지 클래스
 *
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@ToString
public class ImgVo {
	private Long imgId;			// 영화이미지ID(자동증가)
	private Long movieId;		// 영화ID
	private String imgPath;		// 영화이미지 경로
	private String fileName;	// 영화 이미지명
	private int isMain;			// 대표 이미지 여부(0-대표이미지)
}
