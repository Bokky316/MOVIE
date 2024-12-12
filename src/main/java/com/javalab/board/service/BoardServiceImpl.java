package com.javalab.board.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javalab.board.dto.Criteria;
import com.javalab.board.repository.BoardRepository;
import com.javalab.board.vo.BoardVo;

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
	// @Autowired : 스프링에서 지정한 타입의 빈을 찾아서 주입
	// BoardRepository 타입의 빈을 찾아서 주입해줌.
	// 필드, 생성자 이존성 주입시 필드를 final하는 이유는 불변성을 지키기 위함이다.
	private final BoardRepository repository;

	// 생성자 의존성이 좋은 점은 이 객체 생성시 타입을 체크해준다. 안정성 보장
	// public BoardServiceImpl(BoardRepository repository) {
	// this.repository = repository;
	// }

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
	// 게시물 내용 보기
	@Override
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
	    // 부모 게시물 조회
	    BoardVo parentBoard = repository.getBoard(reply.getReplyGroup());

	    if (parentBoard == null) {
	        throw new IllegalArgumentException("부모 게시물을 찾을 수 없습니다.");
	    }

	    // 기존 답글 순서 조정
	    reply.setReplyGroup(parentBoard.getReplyGroup());
	    reply.setReplyOrder(parentBoard.getReplyOrder() + 1);
	    reply.setReplyIndent(parentBoard.getReplyIndent() + 1);

	    repository.updateReplyOrder(reply);

	    // 새 답글 삽입
	    return repository.insertReply(reply);
	}
	@Override
	public void updateReplyOrder(BoardVo replyBoard) {
		// TODO Auto-generated method stub
		
	}


}
