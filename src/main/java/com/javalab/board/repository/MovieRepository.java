package com.javalab.board.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.javalab.board.vo.ImgVo;
import com.javalab.board.vo.MovieVo;
import com.javalab.board.vo.MovieWithImageVo;

/**
 * 상품 매퍼 인터페이스
 * - 서비스 레이어와 매퍼XML을 연결해주는 Bridge 역할
 */
@Mapper
public interface MovieRepository {
	// 상품 정보 등록
	void insertMovie(MovieVo movie);
	// 상품 이미지 정보 등록
	void insertImages(List<ImgVo> images);
	// 상품 목록 조회
	List<MovieVo> getAllMovies();
	// 상품 조회
	MovieWithImageVo getMovieWithImages(@Param("movieId") Long movieId);
	
	//MovieVo getMovieById(@Param("movieId") Long movieId);
	//List<ImgVo> getImgagesByMovieId(@Param("movieId") Long movieId);
	
    // 상품 수정
    void updateMovieWithImages(MovieVo movie);
    
    // 상품과 관련된 이미지를 삭제하는 메소드
    void deleteImagesByMovieId(Long movieId);

    // 상품 삭제
    void deleteMovie(@Param("movieId") Long movieId);

}

