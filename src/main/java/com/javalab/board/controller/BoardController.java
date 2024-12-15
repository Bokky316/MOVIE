package com.javalab.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javalab.board.dto.Criteria;
import com.javalab.board.dto.PageDto;
import com.javalab.board.service.BoardService;
import com.javalab.board.vo.BoardVo;
import com.javalab.board.vo.MemberVo;
import com.javalab.board.vo.MovieWithImageVo;

import javax.servlet.http.HttpSession;
import java.util.List;

import lombok.extern.slf4j.Slf4j;

/**
 * 게시물 컨트롤러 사용자의 요청을 처리하고 응답을 반환하는 클래스
 */
@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {

    private final BoardService service;

    @Autowired
    public BoardController(BoardService service) {
        this.service = service;
    }

    /**
     * 게시물 목록 보기 (페이징 및 검색 포함)
     * 
     * @param cri   화면에서 전달된 페이지 정보와 검색 조건
     * @param model 뷰로 전달할 데이터를 저장하는 객체
     * @return 게시물 목록 페이지
     */
    @GetMapping("/list")
    public String getListPaging(Criteria cri, @RequestParam(required = false) Long movieId, Model model) {
        if (movieId != null) {
            cri.setMovieId(movieId);
        }
        List<BoardVo> boardList = service.getBoardListPaging(cri);
        model.addAttribute("boardList", boardList);

        int total = service.getTotalBoardCount(cri);
        PageDto pageDto = new PageDto(cri, total);
        model.addAttribute("pageMaker", pageDto);

        List<MovieWithImageVo> movieList = service.getMovieList();
        model.addAttribute("movieList", movieList);

        return "board/boardList";
    }

    /**
     * 게시물 상세 보기
     * 
     * @param boardNo 게시물 번호
     * @param model   뷰로 전달할 데이터를 저장하는 객체
     * @return 게시물 상세 페이지
     */
    @GetMapping("/view")
    public String viewBoard(@RequestParam int boardNo, Model model) {
        BoardVo board = service.getBoard(boardNo);
        log.info("Viewing board: {}", board);
        model.addAttribute("board", board);
        return "board/boardView";
    }

    /**
     * 특정 회원의 게시물 목록 보기
     * 
     * @param memberId 회원 ID
     * @param model    뷰로 전달할 데이터를 저장하는 객체
     * @return 회원 게시물 목록 페이지
     */
    @GetMapping("/member/boards")
    public String viewBoardsByMember(@RequestParam String memberId, Model model) {
        try {
            List<BoardVo> boardList = service.getBoardsByMemberId(memberId); // 서비스 호출하여 회원의 게시글 목록 조회
            model.addAttribute("boardList", boardList); // 모델에 게시물 목록 추가
            model.addAttribute("memberId", memberId); // 모델에 회원 ID 추가
            
            return "board/memberBoardList"; // JSP 파일 경로 (회원 게시물 목록)
        } catch (Exception e) {
            log.error("Error while retrieving boards for member: {}", memberId, e);
            model.addAttribute("errorMessage", "게시물 조회 중 오류가 발생했습니다.");
            return "error"; // 에러 페이지로 리다이렉트 (적절한 JSP 파일 경로)
        }
    }

    /**
     * 영화 목록 보기
     * 
     * @param model 뷰로 전달할 데이터를 저장하는 객체
     * @return 영화 목록 페이지
     */
    @GetMapping("")
    public String getMovies(Model model) {
        List<MovieWithImageVo> movieList = service.getMovieList();
        model.addAttribute("movieList", movieList);
        return "board/movieList"; // JSP 파일 경로
    }

    /**
     * 특정 영화 상세 보기
     * 
     * @param movieId 영화 ID
     * @param model   뷰로 전달할 데이터를 저장하는 객체
     * @return 영화 상세 페이지
     */
    @GetMapping("/{movieId}")
    public String getMovie(@PathVariable Long movieId, Model model) {
        MovieWithImageVo movie = service.getMovie(movieId);
        model.addAttribute("movie", movie);
        return "board/movieDetail"; // JSP 파일 경로
    }


    /**
     * 게시물 등록 폼 보기
     * 
     * @param model 뷰로 전달할 데이터를 저장하는 객체
     * @return 게시물 등록 폼 페이지
     */
    @GetMapping("/insert")
    public String insertBoardForm(Model model) {
        if (!model.containsAttribute("board")) {
            model.addAttribute("board", new BoardVo());
        }

        List<MovieWithImageVo> movieList = service.getMovieList();
        model.addAttribute("movieList", movieList);

        return "board/boardInsert";
    }

    /**
     * 게시물 등록 처리
     * 
     * @param boardVo            게시물 데이터
     * @param redirectAttributes 리다이렉트 시 메시지 전달
     * @return 게시물 목록 페이지로 리다이렉트
     */
    @PostMapping("/insert")
    public String insertBoard(@ModelAttribute BoardVo boardVo,
            @RequestParam(value = "spoiler", required = false) String spoiler, @RequestParam("movieId") Long movieId,
            RedirectAttributes redirectAttributes) {
        try {
            log.info("Received spoiler value from form: {}", spoiler);

            // 스포일러 값 설정
            boardVo.setSpoiler("Y".equals(spoiler) ? "Y" : "N");
            log.info("Spoiler set in BoardVo: {}", boardVo.getSpoiler());

            // 영화 정보 가져오기
            MovieWithImageVo movie = service.getMovie(movieId);
            boardVo.setMovieWithImage(movie);
            log.info("Movie set in BoardVo: {}", movie);

            // 게시물 저장
            log.info("Saving board: {}", boardVo);
            service.insertBoard(boardVo);

            // 성공 메시지 추가
            redirectAttributes.addFlashAttribute("successMessage", "게시물이 등록되었습니다.");
            return "redirect:/board/list";
        } catch (Exception e) {
            log.error("Error while inserting board", e); // 오류 로그
            redirectAttributes.addFlashAttribute("errorMessage", "게시물 등록 중 오류가 발생했습니다.");
            redirectAttributes.addFlashAttribute("board", boardVo); // 실패 시 게시물 데이터 전달
            return "redirect:/board/insert";
        }
    }

    /**
     * 게시물 수정 폼 보기
     * 
     * @param boardNo            수정할 게시물 번호
     * @param model              뷰로 전달할 데이터를 저장하는 객체
     * @param session            현재 사용자 세션
     * @param redirectAttributes 리다이렉트 시 메시지 전달
     * @return 게시물 수정 폼 페이지
     */
    @GetMapping("/update")
    public String updateBoardForm(@RequestParam("boardNo") int boardNo, Model model, HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");
        BoardVo existingBoard = service.getBoard(boardNo);

        // 게시물이 없거나 수정 권한이 없는 경우
        if (existingBoard == null || !existingBoard.getMemberId().equals(loginUser.getMemberId())) {
            redirectAttributes.addFlashAttribute("errorMessage", "수정 권한이 없습니다.");
            return "redirect:/board/view?boardNo=" + boardNo;
        }

        model.addAttribute("board", existingBoard);

        // 영화 목록 추가
        List<MovieWithImageVo> movieList = service.getMovieList();
        model.addAttribute("movieList", movieList);

        return "board/boardUpdate"; // JSP 파일 경로
    }

    /**
     * 게시물 수정 처리
     * 
     * @param boardVo            수정할 게시물 데이터
     * @param redirectAttributes 리다이렉트 시 메시지 전달
     * @return 수정 후 게시물 상세 보기 페이지로 리다이렉트
     */
    @PostMapping("/update")
    public String updateBoard(@ModelAttribute BoardVo boardVo,
                              @RequestParam(value = "rating", required = false) Float rating, 
                              @RequestParam("movieId") Long movieId,
                              RedirectAttributes redirectAttributes) {
        try {
            log.info("Received movieId: {}", movieId); // 영화 ID 로그 추가

            // 업데이트할 데이터 설정
            boardVo.setRating(rating);

            // 영화 정보 설정
            if (movieId != null) {
                MovieWithImageVo movie = service.getMovie(movieId);
                if (movie != null) {
                    boardVo.setMovieWithImage(movie);
                } else {
                    log.warn("영화 ID {}에 대한 정보가 없습니다.", movieId);
                    boardVo.setMovieWithImage(new MovieWithImageVo()); // 기본값 설정
                }
            }

            // 서비스 호출하여 업데이트 수행
            service.updateBoard(boardVo);
            redirectAttributes.addFlashAttribute("successMessage", "게시물이 수정되었습니다.");

            return "redirect:/board/view?boardNo=" + boardVo.getBoardNo();
        } catch (Exception e) {
            log.error("Error while updating board", e);
            redirectAttributes.addFlashAttribute("errorMessage", "게시물 수정 중 오류가 발생했습니다.");

            // 수정 폼으로 리다이렉트하면서 기존 데이터 유지
            redirectAttributes.addFlashAttribute("board", boardVo);
            return "redirect:/board/update?boardNo=" + boardVo.getBoardNo();
        }
    }

	/**
	 * 게시물 삭제 처리
	 * 
	 * @param boardNo 삭제할 게시물 번호
	 * @return 게시물 목록 페이지로 리다이렉트
	 */
	@PostMapping("/delete")
	public String deleteBoard(@RequestParam int boardNo, RedirectAttributes redirectAttributes) {
		try {
			BoardVo board = service.getBoard(boardNo);

			// 게시글 삭제
			service.deleteBoard(boardNo);
			redirectAttributes.addFlashAttribute("successMessage", "게시물이 삭제되었습니다.");
			return "redirect:/board/list";
		} catch (Exception e) {
			log.error("Error while deleting board", e);
			redirectAttributes.addFlashAttribute("errorMessage", "게시물 삭제 중 오류가 발생했습니다.");
			return "redirect:/board/list";
		}
	}

	/**
	 * 답글 등록 폼 보기
	 * 
	 * @param parentBoardNo 부모 게시물 번호
	 * @param model         뷰로 전달할 데이터를 저장하는 객체
	 * @return 답글 작성 폼 페이지
	 */
	@GetMapping("/reply")
	public String replyBoardForm(@RequestParam("parentBoardNo") int parentBoardNo, Model model) {
		BoardVo parentBoard = service.getBoard(parentBoardNo);
		log.error("parentBoard :", parentBoard);
		if (parentBoard == null) {
			model.addAttribute("errorMessage", "존재하지 않는 게시물입니다.");
			return "redirect:/board/list";
		}
		model.addAttribute("parentBoard", parentBoard);
		return "board/boardReply";
	}

	/**
	 * 답글 등록 처리
	 * 
	 * @param replyBoard         답글 데이터
	 * @param redirectAttributes 리다이렉트 시 메시지 전달
	 * @return 게시물 목록 페이지로 리다이렉트
	 */
	@PostMapping("/reply")
    public String replyBoard(@ModelAttribute("replyBoard") BoardVo replyBoard, RedirectAttributes redirectAttributes) {
        try {
           
           log.info("replyBoard : " + replyBoard);
           
            // 답글 등록 처리
            int result = service.insertReply(replyBoard);
            if (result > 0) {
                redirectAttributes.addFlashAttribute("successMessage", "답글이 정상적으로 등록되었습니다!");
                return "redirect:/board/list";
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "답글 등록 중 문제가 발생했습니다.");
                return "redirect:/board/reply?parentBoardNo=" + replyBoard.getReplyGroup();
            }
        } catch (Exception e) {
            log.error("답글 등록 중 오류 발생", e);
            redirectAttributes.addFlashAttribute("errorMessage", "답글 등록 중 오류가 발생했습니다.");
            return "redirect:/board/reply?parentBoardNo=" + replyBoard.getReplyGroup();
        }
    }
} 