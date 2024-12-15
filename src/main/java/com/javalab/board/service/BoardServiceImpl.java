package com.javalab.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javalab.board.dto.Criteria;
import com.javalab.board.repository.BoardRepository;
import com.javalab.board.vo.BoardVo;
import com.javalab.board.vo.MovieWithImageVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * 게시판 서비스 클래스
 * 
 * @Service : 서비스 레이어에서 사용할 스프링 빈으로 등록
 */
@Service
@RequiredArgsConstructor // 생성자 자동으로 만들어준다.
@Slf4j
public class BoardServiceImpl implements BoardService {

	private final BoardRepository repository;

	/*
	 * 게시물 조회
	 */
	@Override
	public List<BoardVo> getBoardList() {
		List<BoardVo> boardList = repository.getBoardList();
		return boardList;
	}

	/*
	 * 페이징, 검색 기능이 추가된 메소드 호출
	 */
	@Override
	public List<BoardVo> getBoardListPaging(Criteria cri) {
		List<BoardVo> boardList = repository.getBoardListPaging(cri);
		return boardList;
	}

	// 게시물 내용 보기 및 조회수 증가
	@Override
	@Transactional // 트랜잭션 관리 추가
	public BoardVo getBoard(int boardNo) {
		// 조회수 증가
		repository.increaseHitNo(boardNo);
		// 게시물 조회
		BoardVo boardVo = repository.getBoard(boardNo);
		return boardVo;
	}

	// 게시물 저장
	@Override
	public int insertBoard(BoardVo boardVo) {
		return repository.insertBoard(boardVo);
	}

	// 게시물 수정
	@Override
	@Transactional // 트랜잭션 관리 추가
	public int updateBoard(BoardVo boardVo) {
		return repository.updateBoard(boardVo);
	}

	// 게시물 삭제
	@Override
	public int deleteBoard(int boardNo) {
		return repository.deleteBoard(boardNo);
	}

	/*
	 * 게시물 총 갯수 조회
	 */
	@Override
	public int getTotalBoardCount(Criteria cri) {
		return this.repository.getTotalBoardCount(cri);
	}

	/*
	 * 답글 작성
	 */
	@Override
	@Transactional
	public int insertReply(BoardVo reply) {
		/*
		 * // 부모 게시물 조회 BoardVo parentBoard =
		 * repository.getBoard(reply.getReplyGroup());
		 * 
		 * if (parentBoard == null) { throw new
		 * IllegalArgumentException("부모 게시물을 찾을 수 없습니다."); }
		 */

		// 1. 기존 답글의 순서 조정
		repository.updateReplyOrder(reply);

		// 2. 새로운 답글의 순서와 들여쓰기 계산
		reply.setReplyOrder(reply.getReplyOrder() + 1);
		reply.setReplyIndent(reply.getReplyIndent() + 1);

		// 3. 스포일러 처리
		reply.setSpoiler("Y".equalsIgnoreCase(reply.getSpoiler()) ? "Y" : "N");

		// 4. 새 답글 삽입
		return repository.insertReply(reply);
	}

	@Override
	public void updateReplyOrder(BoardVo replyBoard) {
		// TODO Auto-generated method stub

	}

	// 영화 목록 조회 메서드 추가
	public List<MovieWithImageVo> getMovieList() {
		return repository.getMovieList();
	}

	// 특정 영화 조회 메서드 추가
	public MovieWithImageVo getMovie(Long movieId) {
		return repository.getMovie(movieId);
	}

	/*
	 * 특정 회원의 게시글 목록 조회 메서드 추가
	 */
	@Override
	public List<BoardVo> getBoardsByMemberId(String memberId) {
		log.info("Fetching boards for member ID: {}", memberId);
		return repository.findBoardsByMemberId(memberId); // 레포지토리 호출하여 회원의 게시글 목록 반환
	}
}
