package com.javalab.board.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.javalab.board.dto.Criteria;
import com.javalab.board.dto.PageDto;
import com.javalab.board.service.MovieService;
import com.javalab.board.service.MovieServiceImpl;
import com.javalab.board.vo.BoardVo;
import com.javalab.board.vo.MemberVo;
import com.javalab.board.vo.MovieVo;
import com.javalab.board.vo.MovieWithImageVo;
import com.javalab.board.vo.MovieVo;

import lombok.extern.slf4j.Slf4j;

/**
 * 영화 정보 등록 컨트롤러
 *
 */
@Controller
@RequestMapping("/movie")
@Slf4j
public class MovieController {

	// 의존성 주입
	private final MovieService movieService;

	public MovieController(MovieService movieService) {
		this.movieService = movieService;
	}

	/*
	 * file.properties 파일에 정의된 파일 저장 경로값 읽어오기 - /config/file.properties 파일에 저장한 값을
	 * 읽어온다.
	 */
	@Value("${file.path}") // import org.springframework.beans.factory.annotation.Value;
	private String filePath; // 읽어온 값이 저장되는 변수

	/*
	 * 영화 등록 폼
	 */
	@GetMapping("/create")
	public String createForm() {
		return "movie/movieCreate";
	}

	/*
	 * 영화 등록 처리
	 */
	@PostMapping("/create")
	public String handleUpload(MovieVo movieVo, @RequestParam("files") ArrayList<MultipartFile> files, Model model) {
		log.info("movieVo 화면에서 받은 값 : {}", movieVo);
		log.info("filepath 화면에서 받은 값 : {}", filePath);

		// 서비스 레이어로 파일 업로드 및 영화/이미지 등록 위임
		boolean isUploaded = movieService.saveMovieWithImages(movieVo, files, filePath);

		if (!isUploaded) {
			return "uploadFailure";
		}
		return "redirect:/movie/list";
	}

	/*
	 * 영화 목록 조회
	 */
	@GetMapping("/list")
    public String getListPaging(Criteria cri, Model model){
       log.info("selectMovieList 메소드 Criteria : " + cri);
       // 게시물 목록 조회
       List<MovieWithImageVo> movieList = movieService.getMovieListPaging(cri);
       
       model.addAttribute("movieList", movieList);
       // 게시물 건수 조회
       int total = movieService.getTotalMovieCount(cri); 
       // 페이징관련 정보와 게시물 정보를 PageDto에 포장
       // 페이지 하단에 표시될 페이지그룹과 관련된 정보 생성
       PageDto dto = new PageDto(cri, total);
       
       model.addAttribute("pageMaker", dto); 
       
       return "/movie/movieList";   // jsp 페이지
    } 


	/*
	 * 영화 내용 보기
	 * 
	 * @PathVariable : URL 경로에 있는 값을 파라미터로 받을 때 사용 - {movieId} : URL 경로에 있는 movieId의
	 * 값을 파라미터로 받음 - {PathVariable("movieId") : URL 경로에 있는 movieId값을 받아서 Long
	 * movieId에 할당
	 */
	@GetMapping("/detail/{movieId}")
	public String movieDetail(@PathVariable("movieId") Long movieId, Model model) {
		// 영화 조회
		MovieWithImageVo movieWithImages = movieService.getMovieWithImages(movieId);

		log.info("detail movie : " + movieWithImages);

		model.addAttribute("movie", movieWithImages);
		return "/movie/movieDetail";
	}

	/**
	 * 외부 경로에 저장된 이미지를 제공하는 메소드
	 * 
	 * ResponseEntity를 사용함으로써 응답 정보(헤더, 상태 코드 등)를 더 세밀하게 제어할 수 있다.
	 * 
	 * @param year, @param month, @param day, @param filename
	 * 
	 *              이 메소드를 통해서 이미지가 화면에 출력되는 순서 1. 화면에서 <img src=
	 *              "/movie/upload/2024/07/19/a1d20f23-41e3-40d6-a07d-3eeeb36195cb_bird.jpg">
	 *              와 같이 요청 2. 컨트롤러가 요청을 받아서 전달된 경로 변수들을 파싱하여 파라미터에 값을 세팅한다. 3. 해당
	 *              파일의 MIME 타입을 조회함 :
	 *              Files.probeContentType(resource.getFile().toPath()) - 보통 이미지이면
	 *              MIME 타입이 image/로 시작함. 4. 스프링은 이 MIME 타입을 HTTP 응답의 Content-Type
	 *              헤더로 설정한다. 5. @ResponseBody를 통해서 웹브라우저의 본문에 바로 제공 6. 브라우저는 이
	 *              Content-Type 헤더를 보고 해당 파일을 어떻게 처리할지 결정. "image/"로 시작하는 MIME 타입을
	 *              받으면, 브라우저는 그 내용을 이미지로 해석하고 표시함. 7. filename:.+ : 확장자를 포함한 파일명을
	 *              받기 위해 정규 표현식을 사용함
	 */
	@GetMapping("/upload/{year}/{month}/{day}/{filename:.+}")
	@ResponseBody // 메소드의 반환값이 직접 응답 본문으로 사용되어야 함을 나타냄.
	public ResponseEntity<Resource> serveFile(@PathVariable("year") String year, @PathVariable("month") String month,
			@PathVariable("day") String day, @PathVariable("filename") String filename) {
		try {
			String imgPath = year + File.separator + month + File.separator + day;
			// ex) c:\\filetest\\upload\\년\\월\\일\\파일명
			String imagePath = filePath + File.separator + imgPath + File.separator + filename;
			log.info("imagePath : " + imagePath);

			// 해당 경로의 이미지를 핸들링할 수 있는 객체 생성
			FileSystemResource resource = new FileSystemResource(imagePath);

			if (!resource.exists()) {
				return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			}

			HttpHeaders headers = new HttpHeaders();
			// Files.probeContentType을 사용하여 파일의 MIME 타입을 결정. 이 MIME 타입을 응답 헤더의
			// Content-Type으로 설정함.
			// 웹브라우저가 해당 MIME 타입을 인식해서 웹브라우저에 해당 이미지를 렌더링한다.
			// MIME 타입이 브라우저에서 직접 표시되지 않는 경우 파일을 다운로드 합니다.
			headers.add(HttpHeaders.CONTENT_TYPE, Files.probeContentType(resource.getFile().toPath()));

			// 브라우저는 받은 응답의 Content-Type 헤더를 확인하고, 이를 이미지로 인식하게되며 응답 본문의 데이터를 이미지로 디코딩하여 화면에
			// 표시한다.
			return new ResponseEntity<>(resource, headers, HttpStatus.OK);
		} catch (IOException e) {
			log.error("Error while serving image file: " + filename, e);
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/*
	 * 영화 수정 폼 보기 메소드 - 영화Id를 받아서 해당 게시물의 정보를 조회해서 수정 폼으로 이동
	 */
	@GetMapping("/update")
	public String updateMovieForm(@RequestParam("movieId") Long movieId, @ModelAttribute("movie") MovieVo movieVo,
			Model model, HttpSession session, RedirectAttributes redirectAttributes) {

		// 세션에서 로그인 사용자 정보 가져오기
//		MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");

		// 로그인 사용자가 없을 경우[인터셉터에서 처리]
		// 로그인 사용자가 없을 경우[인터셉터에서 처리]
		// if (loginUser == null) {
		// redirectAttributes.addFlashAttribute("errorMessage", "로그인 후 이용해주세요.");
		// return "redirect:/login"; // 로그인 페이지로 리다이렉트
		// }

		// 영화 조회
		MovieWithImageVo existingMovie = movieService.getMovieWithImages(movieId);

//		// 게시물이 없거나 작성자와 로그인한 사용자가 다를 경우
//		 if (existingMovie == null || !existingMovie.getMemberId().equals(loginUser.getMemberId())) {
//	           redirectAttributes.addFlashAttribute("errorMessage", "수정 권한이 없습니다.");
//	           return "redirect:/movie/view?movieId=" + movieId; // 영화 상세 보기로 이동
//	       }
		if (existingMovie == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "수정할 영화가 존재하지 않습니다.");
			return "redirect:/movie/list";
		}

		// 수정폼에 보여줄 게시물 조회 최초로 수정폼을 열었을경우
//		 if (movieVo.getName() == null) { // 기존 입력값이 없으면 DB에서 조회 : 게시물이 최초로 열린다는 뜻
//			 movieVo = existingMovie;  // 수정할 게시물 정보를 기존 게시물로 설정
//			 model.addAttribute("movie", movieVo); // 모델에 저장
//		    }

		// 모델에 영화 정보 저장
		model.addAttribute("movie", existingMovie);
		// 수정폼(화면)으로 이동
		return "movie/movieUpdate";

	}

	/*
	 * 영화 수정 처리
	 * 
	 * @PostMapping("/update") public String updateMovie(@ModelAttribute MovieVo
	 * movieVo,
	 * 
	 * @RequestParam("files") ArrayList<MultipartFile> files, RedirectAttributes
	 * redirectAttributes) { try { // 영화 정보 업데이트 및 새 이미지 저장 boolean isUpdated =
	 * movieService.updateMovieWithImages(movieVo, files, null, filePath); if
	 * (isUpdated) { redirectAttributes.addFlashAttribute("successMessage",
	 * "영화가 성공적으로 수정되었습니다."); return "redirect:/movie/detail/" +
	 * movieVo.getMovieId(); } else {
	 * redirectAttributes.addFlashAttribute("errorMessage", "영화 수정에 실패했습니다.");
	 * return "redirect:/movie/update?movieId=" + movieVo.getMovieId(); } } catch
	 * (Exception e) { log.error("영화 수정 중 오류 발생", e);
	 * redirectAttributes.addFlashAttribute("errorMessage", "영화 수정 중 오류가 발생했습니다.");
	 * return "redirect:/movie/update?movieId=" + movieVo.getMovieId(); } }
	 */
	
	/**
     * 영화 수정 처리 (POST 방식)
     */
    @PostMapping("/update")
    public String updateMovie(@RequestParam("movieId") Long movieId,
                                @RequestParam("name") String name,
                                @RequestParam("description") String description,
                                @RequestParam(value = "movieDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date movieDate,
                                @RequestParam(value = "genre", required = false) String genre,
                                @RequestParam(value = "runningTime", required = false) String runningTime,
                                @RequestParam(value = "rating", required = false) String rating,
                                @RequestParam(value = "ageRating", required = false) String ageRating,
                                @RequestParam(value = "director", required = false) String director,
                                @RequestParam(value = "cast", required = false) String cast,
                                @RequestParam(value = "files", required = false) List<MultipartFile> newFiles,
                                @RequestParam(value = "existingImageIds", required = false) List<Long> existingImageIds,
                                Model model) {

        // 영화 정보 설정
        MovieVo updatedMovie = new MovieVo();
        updatedMovie.setMovieId(movieId);
        updatedMovie.setName(name);
        updatedMovie.setDescription(description);
        updatedMovie.setMovieDate(movieDate);
        updatedMovie.setGenre(genre);
        updatedMovie.setRunningTime(runningTime);
        updatedMovie.setRating(rating);
        updatedMovie.setAgeRating(ageRating);
        updatedMovie.setDirector(director);
        updatedMovie.setCast(cast);

        // 영화 정보 업데이트 및 새 파일 처리
        boolean isUpdated = movieService.updateMovieWithImages(updatedMovie, newFiles, existingImageIds, filePath);
        
        if (isUpdated) {
            return "redirect:/movie/list"; // 성공적으로 수정 후 목록 페이지로 리다이렉트
        } else {
            model.addAttribute("errorMessage", "영화 수정 중 오류가 발생했습니다.");
            return "movie/movieUpdate"; // 오류 발생 시 수정 폼으로 다시 이동
        }
    }

	/*
	 * 영화 삭제 메소드
	 */
	@PostMapping("/delete")
	public String deleteMovie(@RequestParam("movieId") Long movieId, RedirectAttributes redirectAttributes) {
		try {
			boolean isDeleted = movieService.deleteMovie(movieId);
			if (isDeleted) {
				redirectAttributes.addFlashAttribute("successMessage", "영화가 성공적으로 삭제되었습니다.");
			} else {
				redirectAttributes.addFlashAttribute("errorMessage", "영화 삭제에 실패했습니다.");
			}
		} catch (Exception e) {
			log.error("영화 삭제 중 오류 발생", e);
			redirectAttributes.addFlashAttribute("errorMessage", "영화 삭제 중 오류가 발생했습니다.");
		}
		return "redirect:/movie/list";
	}
	
	/*
	 * 랜덤 영화 3개 선택 (또는 가능한 만큼)
	 */
	@GetMapping("/random")
	public List<MovieWithImageVo> getRandomMovies() {
	    List<MovieWithImageVo> allMovies = movieService.getAllMovies();
	    
	    if (!allMovies.isEmpty()) {
	        Collections.shuffle(allMovies);
	        return allMovies.stream().limit(Math.min(3, allMovies.size())).collect(Collectors.toList());
	    }
	    
	    return Collections.emptyList(); // 영화가 없을 경우에만 빈 리스트 반환
	}
}
