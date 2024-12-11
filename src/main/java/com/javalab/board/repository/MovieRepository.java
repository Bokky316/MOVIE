package com.javalab.board.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.javalab.board.vo.ImgVo;
import com.javalab.board.vo.MovieVo;
import com.javalab.board.vo.MovieWithImageVo;

/**
 * 영화 매퍼 인터페이스
 * - 서비스 레이어와 매퍼 XML을 연결해주는 Bridge 역할
 */
@Mapper
public interface MovieRepository {
    // 영화 정보 등록
    void insertMovie(MovieVo movie);
    
    // 영화 이미지 정보 등록
    void insertImages(List<ImgVo> images);
    
    // 모든 영화 목록 조회 (이미지 포함)
    List<MovieWithImageVo> getAllMoviesWithImages(); // 메소드 이름 변경
    
    // 영화 조회 (이미지 포함)
    MovieWithImageVo getMovieWithImages(@Param("movieId") Long movieId);
    
    // 영화 수정
    void updateMovieWithImages(MovieVo movie);
    
    // 영화와 관련된 이미지를 삭제하는 메소드
    void deleteImagesByMovieId(Long movieId);

    // 영화 삭제
    void deleteMovie(@Param("movieId") Long movieId);
}