package com.javalab.board.controller;

import java.io.File;
import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.javalab.board.dto.Criteria;
import com.javalab.board.dto.PageDto;
import com.javalab.board.service.BoardService;
import com.javalab.board.vo.BoardVo;
import com.javalab.board.vo.MemberVo;
import lombok.extern.slf4j.Slf4j;

/**
 * 게시물 컨트롤러
 * 사용자의 요청을 처리하고 응답을 반환하는 클래스
 */

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {
	
	@Value("${file.upload.2024}")
	private String uploadDir;
	
    private final BoardService service;

    // 생성자를 통한 의존성 주입
    public BoardController(BoardService service) {
        this.service = service;
    }

    /**
     * 게시물 목록 보기 (페이징 및 검색 포함)
     * @param cri 화면에서 전달된 페이지 정보와 검색 조건
     * @param model 뷰로 전달할 데이터를 저장하는 객체
     * @return 게시물 목록 페이지
     */
    @GetMapping("/list")
    public String getListPaging(Criteria cri, Model model) {
        log.info("Fetching board list with criteria: {}", cri);

        // 게시물 목록 조회 및 모델에 추가
        List<BoardVo> boardList = service.getBoardListPaging(cri);
        model.addAttribute("boardList", boardList);

        // 총 게시물 수 조회 및 페이지 정보 생성
        int total = service.getTotalBoardCount(cri);
        PageDto pageDto = new PageDto(cri, total);
        model.addAttribute("pageMaker", pageDto);

        return "board/boardList";
    }

    /**
     * 게시물 상세 보기
     * @param boardNo 게시물 번호
     * @param model 뷰로 전달할 데이터를 저장하는 객체
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
     * 게시물 등록 폼 보기
     * @param model 뷰로 전달할 데이터를 저장하는 객체
     * @return 게시물 등록 폼 페이지
     */
    @GetMapping("/insert")
    public String insertBoardForm(Model model) {
        if (!model.containsAttribute("board")) {
            model.addAttribute("board", new BoardVo());
        }
        return "board/boardInsert";
    }

    /**
     * 게시물 등록 처리
     * @param boardVo 게시물 데이터
     * @param redirectAttributes 리다이렉트 시 메시지 전달
     * @return 게시물 목록 페이지로 리다이렉트
     */
    @PostMapping("/insert")
    public String insertBoard(@ModelAttribute BoardVo boardVo,
            @RequestParam("image") MultipartFile image,
            @RequestParam(value = "spoiler", required = false) String spoiler,
            RedirectAttributes redirectAttributes) {
        try {
        	// 스포일러 처리
            log.info("Received spoiler value from form: {}", spoiler);
            boardVo.setSpoiler("Y".equals(spoiler) ? "Y" : "N");
            log.info("Spoiler set in BoardVo: {}", boardVo.getSpoiler());

            // 이미지 파일 저장
            if (!image.isEmpty()) {
                File directory = new File(uploadDir);
                if (!directory.exists()) {
                    directory.mkdirs();
                }

                String imagePath = uploadDir + File.separator + image.getOriginalFilename();
                image.transferTo(new File(imagePath));
                boardVo.setImagePath(imagePath); // 이미지 경로 설정
                log.info("Image path set in BoardVo: {}", boardVo.getImagePath());
            }

            // 게시글 저장
            log.info("Saving board: {}", boardVo);
            service.insertBoard(boardVo);
            redirectAttributes.addFlashAttribute("successMessage", "게시물이 등록되었습니다.");
            return "redirect:/board/list";
        } catch (Exception e) {
            log.error("Error while inserting board", e);
            redirectAttributes.addFlashAttribute("errorMessage", "게시물 등록 중 오류가 발생했습니다.");
            redirectAttributes.addFlashAttribute("board", boardVo);
            return "redirect:/board/insert";
        }
    }
    /**
     * 게시물 수정 폼 보기
     * @param boardNo 수정할 게시물 번호
     * @param model 뷰로 전달할 데이터를 저장하는 객체
     * @param session 현재 사용자 세션
     * @param redirectAttributes 리다이렉트 시 메시지 전달
     * @return 게시물 수정 폼 페이지
     */
    @GetMapping("/update")
    public String updateBoardForm(@RequestParam("boardNo") int boardNo, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");
        BoardVo existingBoard = service.getBoard(boardNo);

        if (existingBoard == null || !existingBoard.getMemberId().equals(loginUser.getMemberId())) {
            redirectAttributes.addFlashAttribute("errorMessage", "수정 권한이 없습니다.");
            return "redirect:/board/view?boardNo=" + boardNo;
        }

        model.addAttribute("board", existingBoard);
        return "board/boardUpdate";
    }

    /**
     * 게시물 수정 처리
     * @param boardVo 수정할 게시물 데이터
     * @param redirectAttributes 리다이렉트 시 메시지 전달
     * @return 수정 후 게시물 상세 보기 페이지로 리다이렉트
     */
//    @PostMapping("/update")
//    public String updateBoard(BoardVo boardVo, RedirectAttributes redirectAttributes) {
//        try {
//            int rowsAffected = service.updateBoard(boardVo);
//            if (rowsAffected > 0) {
//                redirectAttributes.addFlashAttribute("successMessage", "게시물이 수정되었습니다.");
//                return "redirect:/board/view?boardNo=" + boardVo.getBoardNo();
//            } else {
//                redirectAttributes.addFlashAttribute("errorMessage", "수정하려는 게시물이 존재하지 않습니다.");
//                return "redirect:/board/list";
//            }
//        } catch (Exception e) {
//            log.error("Error while updating board", e);
//            redirectAttributes.addFlashAttribute("errorMessage", "게시물 수정 중 오류가 발생했습니다.");
//            redirectAttributes.addFlashAttribute("board", boardVo);
//            return "redirect:/board/update?boardNo=" + boardVo.getBoardNo();
//        }
//    }
    @PostMapping("/update")
    public String updateBoard(@ModelAttribute BoardVo boardVo,
                              @RequestParam("image") MultipartFile image,
                              RedirectAttributes redirectAttributes) {
        try {
            // 새 사진 업로드 처리
            if (!image.isEmpty()) {
                // 업로드 디렉토리 존재 확인 및 생성
                File directory = new File(uploadDir);
                if (!directory.exists()) {
                    directory.mkdirs();
                }

                String imagePath = uploadDir + File.separator + image.getOriginalFilename();
                image.transferTo(new File(imagePath));
                boardVo.setImagePath(imagePath);
            }

            // 게시글 수정
            service.updateBoard(boardVo);
            redirectAttributes.addFlashAttribute("successMessage", "게시물이 수정되었습니다.");
            return "redirect:/board/view?boardNo=" + boardVo.getBoardNo();
        } catch (Exception e) {
            log.error("Error while updating board", e);
            redirectAttributes.addFlashAttribute("errorMessage", "게시물 수정 중 오류가 발생했습니다.");
            return "redirect:/board/update?boardNo=" + boardVo.getBoardNo();
        }
    }
    

    /**
     * 게시물 삭제 처리
     * @param boardNo 삭제할 게시물 번호
     * @return 게시물 목록 페이지로 리다이렉트
     */
//    @PostMapping("/delete")
//    public String deleteBoard(@RequestParam int boardNo) {
//        service.deleteBoard(boardNo);
//        return "redirect:/board/list";
//    }
    @PostMapping("/delete")
    public String deleteBoard(@RequestParam int boardNo, RedirectAttributes redirectAttributes) {
        try {
            BoardVo board = service.getBoard(boardNo);

            // 이미지 삭제
            if (board.getImagePath() != null) {
                File imageFile = new File(board.getImagePath());
                if (imageFile.exists()) {
                    imageFile.delete();
                }
            }

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
     * @param parentBoardNo 부모 게시물 번호
     * @param model 뷰로 전달할 데이터를 저장하는 객체
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
     * @param replyBoard 답글 데이터
     * @param redirectAttributes 리다이렉트 시 메시지 전달
     * @return 게시물 목록 페이지로 리다이렉트
     */
    @PostMapping("/reply")
    public String replyBoard(BoardVo replyBoard, RedirectAttributes redirectAttributes) {
        try {
            service.insertReply(replyBoard);
            redirectAttributes.addFlashAttribute("successMessage", "답글이 등록되었습니다.");
            return "redirect:/board/list";
        } catch (Exception e) {
            log.error("Error while inserting reply", e);
            redirectAttributes.addFlashAttribute("errorMessage", "답글 등록 중 오류가 발생했습니다.");
            return "redirect:/board/reply?parentBoardNo=" + replyBoard.getReplyGroup();
        }
    }
}
