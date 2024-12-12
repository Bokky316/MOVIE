package com.javalab.board.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.javalab.board.repository.MovieRepository;
import com.javalab.board.vo.ImgVo;
import com.javalab.board.vo.MovieVo;
import com.javalab.board.vo.MovieWithImageVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service // 빈 생성해서 올라감
@Slf4j // 롬복 사용
@RequiredArgsConstructor // 속성을 매개변수로 갖는 생성자 생성
public class MovieServiceImpl implements MovieService {
	// 의존성 주입
	private final MovieRepository movieRepository;
	
	@Override
	public void addMovie(MovieVo movie) {
		movieRepository.insertMovie(movie);
	}

	/*
	 * 영화 정보 저장, 관련된 이미지 업로드하여 저장 경로(파일시스템)에 저장한 후 그 정보를 DB에 저장
	 * UUID.randomUUID() : 랜덤한 UUID를 생성하는 메소드로 파일명 중복을 방지하기 위함.
	 * UUID : Universally Unique Identifier, 범용 고유 식별자
	 * 파라미터 movie : 저장할 영화 정보 보관 객체
	 * 파라미터 files : 영화의 이미지 파일 리스트
	 * 파라미터 filePath : 파일이 저장될 디렉토리 경로
	 * 반환값 : 영화정보 + 이미지 저장 성공 시 true, 실패시 false 
	 * @Transactional : 영화 정보 저장과 영화 이미지 저장을 하나의 작업단위로 묶어서 모두 성공 또는 모두 실패로 처리
	 * - 만약 실패시 예외가 발생하면 @Transactional 어노테이션이 같은 작업 단위로 묶인 작업을 모두 롤백처리한다.  
	 */
	@Override
	@Transactional
	public boolean saveMovieWithImages(MovieVo movie, List<MultipartFile> files, String filePath) {
		try {
			
			// 영화 정보를 데이터베이스에 저장
			addMovie(movie);
			
			// 저장된 영화의 ID를 가져옴
			Long movieId = movie.getMovieId();
			
			// 날짜 기반으로 파일 저장 경로를 생성
			String uploadFolderPath = getFolder(); // 날짜별 폴더 생성
			String uploadPath = filePath + File.separator + uploadFolderPath; // 전체 파일 경로 생성
			File uploadFilePath = new File(uploadPath); // 파일 경로 객체 생성
			
			// 파일 저장 경로가 존재하지 않으면 디렉토리를 생성
			if (!uploadFilePath.exists()) {
				uploadFilePath.mkdirs(); // 경로에 해당하는 디렉토리를 생성
			}
			
			// 업로드된 파일들을 처리하고 이미지 정보를 생성
			List<ImgVo> imageList = new ArrayList<>(); // 이미지 정보를 담을 리스트 생성
			for (int i = 0; i < files.size(); i++) { // 업로드된 파일 리스트를 순회
				MultipartFile file = files.get(i); // 현재 파일 가져오기
				
				// 파일이 비어있지 않은 경우 처리
				if (!file.isEmpty()) {
					String originalFileName = file.getOriginalFilename(); // 원본 파일명 가져오기
					String uniqueFileName = UUID.randomUUID() + "_" + originalFileName; // 고유한 파일명 생성
					File saveFile = new File(uploadFilePath, uniqueFileName); // 저장할 파일 객체 생성
					
					file.transferTo(saveFile); // 파일을 지정된 경로에 저장
					
					// 이미지 정보를 생성하여 리스트에 추가
					ImgVo img = new ImgVo();
					img.setMovieId(movieId); // 영화 ID 설정
					img.setImgPath(uploadFolderPath); // 이미지가 저장된 폴더 경로 설정
					img.setFileName(uniqueFileName); // 저장된 파일명 설정
					img.setIsMain(i == 0 ? 1 : 0); // 첫 번째 이미지를 메인 이미지로 설정
					imageList.add(img); // 리스트에 이미지 정보 추가
				}
			}
			
			// 이미지 리스트가 비어있지 않다면 데이터베이스에 이미지 정보 저장
			if (!imageList.isEmpty()) {
				insertImages(imageList); // 이미지 정보를 데이터베이스에 삽입
			}
			// 모든 작업이 성공적으로 완료된 경우 true 반환
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("파일 저장 실패", e); // 트랜잭션 롤백 되도록 런타임 예외 발생해줌!
		}
	}
	
	/*
	 * 날짜 별로 폴더를 생성 메소드 
	 */
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // java.util.Date
		Date date = new Date();
		String str = sdf.format(date); // 날짜를 문자열로 변환
		return str.replace("-", File.separator); // 구분자("-")를 파일 시스템에 맞게 변경, 윈도우즈에서는 e.g) 2021\\07\\01 -> 폴더 경로로 폴더 생성 
	}
	
	/**
	 * 모든 영화 정보를 조회하는 메소드
	 * @return 영화 리스트
	 */
	@Override
	public List<MovieWithImageVo> getAllMovies() {
		return movieRepository.getAllMoviesWithImages();
	}

	/**
	 * 특정 영화 정보를 조회하는 메소드
	 * @param movieId 조회할 영화 ID
	 * @retrun 영화 정보
	 */
	@Override
	public MovieWithImageVo getMovieWithImages(Long movieId) {
		MovieWithImageVo movieWithImageVo = movieRepository.getMovieWithImages(movieId);
		log.info("서비스 movieWithImageVo : " + movieWithImageVo);
		return movieWithImageVo;
	}

	/**
	 * 이미지 정보를 DB에 저장
	 */
	@Override
	public void insertImages(List<ImgVo> images) {
		movieRepository.insertImages(images);
	}
	
	
	
	/**
     * 영화 정보를 수정하고 관련된 이미지를 업데이트하는 메소드.
     * @param movie 수정할 영화 정보 (MovieVo 객체)
     * @param files 수정할 이미지 파일 리스트
     * @param filePath 파일이 저장될 디렉토리 경로
     * @return 성공 시 true, 실패 시 false
     */
	@Override
	@Transactional
	public boolean updateMovieWithImages(MovieVo movie, List<MultipartFile> files, List<Long> existingImageIds, String filePath) {
	    try {
	        // 영화 정보를 업데이트
	        movieRepository.updateMovieWithImages(movie);
	        
	        // 기존 이미지 삭제 처리
            if (existingImageIds != null && !existingImageIds.isEmpty()) {
                for (Long imageId : existingImageIds) {
                    deleteImageById(imageId); // 기존 이미지 삭제
                }
            }

	        // 이미지 처리 로직은 saveMovieWithImages와 유사하게 구현 가능
	        Long movieId = movie.getMovieId();
	        String uploadFolderPath = getFolder();
	        String uploadPath = filePath + File.separator + uploadFolderPath;
	        File uploadFilePath = new File(uploadPath);

	        if (!uploadFilePath.exists()) {
	            uploadFilePath.mkdirs();
	        }

	        List<ImgVo> imageList = new ArrayList<>();
	        for (int i = 0; i < files.size(); i++) {
	            MultipartFile file = files.get(i);
	            if (!file.isEmpty()) {
	                String originalFileName = file.getOriginalFilename();
	                String uniqueFileName = UUID.randomUUID() + "_" + originalFileName;
	                File saveFile = new File(uploadFilePath, uniqueFileName);
	                file.transferTo(saveFile);

	                ImgVo img = new ImgVo();
	                img.setMovieId(movieId);
	                img.setImgPath(uploadFolderPath);
	                img.setFileName(uniqueFileName);
	                img.setIsMain(i == 0 ? 1 : 0); // 첫 번째 이미지를 메인 이미지로 설정
	                imageList.add(img);
	            }
	        }

	        if (!imageList.isEmpty()) {
	            insertImages(imageList); // 새로운 이미지 정보를 데이터베이스에 삽입
	        }
	        
	        return true; // 모든 작업이 성공적으로 완료된 경우 true 반환
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new RuntimeException("영화 수정 실패", e); // 트랜잭션 롤백을 위해 런타임 예외 발생
	    }
	}

	// 기존 이미지 삭제 메서드 추가
	private void deleteImageById(Long imageId) {
	    movieRepository.deleteImageById(imageId); // 수정: 특정 이미지 ID로 삭제
	}


    /**
     * 영화를 삭제하는 메소드.
     * @param movieId 삭제할 영화 ID
     * @return 성공 시 true, 실패 시 false
     */
    @Override
    @Transactional
    public boolean deleteMovie(Long movieId) {
        try {
        	// 먼저 관련된 이미지 삭제
        	movieRepository.deleteImagesByMovieId(movieId);
        	// 그 다음 영화 삭제
            movieRepository.deleteMovie(movieId); // 영화 삭제 로직 실행
            
            
            return true; // 성공적으로 삭제된 경우 true 반환
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("영화 삭제 실패", e); // 트랜잭션 롤백을 위해 런타임 예외 발생
        }
    }

    /**
     * 제목으로 영화 검색하는 메서드 추가.
     * @param title 검색할 영화 제목.
     * @return 검색 결과 리스트.
     */
    @Override
    public List<MovieWithImageVo> searchMoviesByTitle(String title) {
        return movieRepository.searchMoviesByTitle(title); 
    }
}
