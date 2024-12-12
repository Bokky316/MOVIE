package com.javalab.board.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.javalab.board.vo.ImgVo;
import com.javalab.board.vo.MovieVo;
import com.javalab.board.vo.MovieWithImageVo;

public interface MovieService {
    // 영화 정보 등록
    void addMovie(MovieVo movie);

    // 영화 이미지 정보 등록
    boolean saveMovieWithImages(MovieVo movie, List<MultipartFile> files, String filePath);

    // 영화 목록 조회
    List<MovieWithImageVo> getAllMovies();

    // 특정 영화 조회 (이미지 포함)
    MovieWithImageVo getMovieWithImages(@Param("movieId") Long movieId);

    // 이미지 저장
    void insertImages(List<ImgVo> images);
    
    // 특정 영화 ID로 영화 조회
    // MovieVo getMovieById(@Param("movieId") Long movieId);
    
    // 특정 영화 ID로 이미지 목록 조회
    // List<ImgVo> getImgagesByMovieId(@Param("movieId") Long movieId);
    
    // 영화 수정
    boolean updateMovieWithImages(MovieVo movie, List<MultipartFile> files, List<Long> existingImageIds, String filePath);
    
    // 영화 삭제
    boolean deleteMovie(@Param("movieId") Long movieId);

	
}
