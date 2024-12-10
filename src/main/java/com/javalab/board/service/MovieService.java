package com.javalab.board.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.javalab.board.vo.ImgVo;
import com.javalab.board.vo.MovieVo;
import com.javalab.board.vo.MovieWithImageVo;

public interface MovieService {
	// 상품 정보 등록
	void addMovie(MovieVo movie);
	// 상품 이미지 정보 등록
	boolean saveMovieWithImages(MovieVo movie, List<MultipartFile> files, String filePath);
	// 상품 목록 조회
	List<MovieVo> getAllMovies();
	// 상품 조회
	MovieWithImageVo getMovieWithImages(@Param("movieId") Long movieId);
	// 이미지 저장
	void insertImages(List<ImgVo> images);
	
	//MovieVo getMovieById(@Param("movieId") Long movieId);
	//List<ImgVo> getImgagesByMovieId(@Param("movieId") Long movieId);
	
    // 상품 수정
    boolean updateMovieWithImages(MovieVo movie, List<MultipartFile> files, String filePath);
    
    // 상품 삭제
    boolean deleteMovie(@Param("movieId") Long movieId);

}
