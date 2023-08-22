package team.tttt.pms.common.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import team.tttt.pms.common.vo.AtchFileVO;

public class FileUploadUtils {
	// param - 사용자명, 파일 return db 파일저장위치 -  \resources\img\profile 실패시 Failed
	// 파일을 저장하고 썸네일을 만들어준다.
	// 저장된 파일위치를 반환해준다.
		public static AtchFileVO uploadfile(String userNo, String realPath, String setPath, MultipartFile file, String tbNm) throws IOException {

			// uploadPath
			String uploadPath = realPath + setPath;

			// 파일 경로 폴더 만들기
			File f = new File(uploadPath);
			 if(!f.exists()) {
				 f.mkdirs();
			 }

			// 파일명 생성 (원생번호_{UUID8자리}.확장자)
			String uuid = UUID.randomUUID().toString().replace("-", ""); //-를 제거
			uuid = uuid.substring(0,8);//tempPw를 앞에서부터 8자리 잘라줌

			// 파일명
			String originalName = file.getOriginalFilename();

			// 확장자
			String extName = originalName.substring(originalName.lastIndexOf(".") + 1).toLowerCase();

			String savedName = originalName+"_"+uuid + "." + extName; // 파일 이름구성 - {originalName}_{uuid8자리}.확장자

			// 원본파일 복사
			File target = new File(uploadPath, savedName);
			FileCopyUtils.copy(file.getBytes(), target);

			// 파일 크기
			long fileSize = file.getSize();

			Map<String, String> extNameMap = new HashMap<String, String>();

			extNameMap.put("extName", extName);
			extNameMap.put("uploadPath", uploadPath);
			extNameMap.put("savedName", savedName);

			// 썸네일 만들기
			String thumbnailName= returnExtName(extNameMap);


			String thumb = setPath + thumbnailName;
			String filePath = setPath + savedName;
			// 자료 백업하기 (진짜 프로젝트 폴더에 복사)
			backupFile(uploadPath+savedName, setPath);
			backupFile(uploadPath+thumbnailName, setPath);

			String storagePath = "/resources/bbs/storage/";

			// 파일 VO
			AtchFileVO fileVO = new AtchFileVO();
			fileVO.setFileNm(originalName);
			fileVO.setFileExtn(extName);
			fileVO.setFilePath(storagePath + savedName);
			fileVO.setFileThumb(storagePath + thumbnailName);
			fileVO.setFileSize(fileSize);
			fileVO.setFileRgtr(userNo);
			fileVO.setFileTbNm(tbNm);

			// 저장 경로+파일이름 날려주기 (DB 저장, 외부URL 경로)

			// 리턴을 컨트롤러로 받아서 처리
			return fileVO;

		}

		private static String resizeThumbnail(String uploadPath, String fileName) throws IOException {
			BufferedImage soruceImg = ImageIO.read(new File(uploadPath, fileName)); // 이미지 파일 읽기
			BufferedImage destImg = Scalr.resize(soruceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100); // 리사이징

			String thumbnailName = uploadPath + "s_" + fileName;
			File newFile = new File(thumbnailName);

			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			ImageIO.write(destImg, formatName.toUpperCase(), newFile);


			return "s_" + fileName;
		}


		/**
		 * @Method설명 : 파일을 복사해주는 method
		 * @param fullPath 원본파일을 이름(확장자포함) 의 경로
		 * @param setPath 복사할 경로
		 */
		private static void backupFile(String fullPath, String setPath) throws IOException {

			// sts 위치경로로 개발환경이 다른지 판단.
			if(!System.getProperty("user.dir").equals("C:\\tttt\\01_ide\\1_sts")) { // sts실행위치 검증
				System.out.println("!!!!!TTTT팀원의 개발환경이 아닙니다. 백업기능이 작동하지 않습니다.!!!!!!");
				return;
			}

			String localPath = "C:\\tttt\\01_ide\\0_workspace\\ws_1\\CodeIsU\\src\\main\\webapp\\"; // 홈디렉토리 지정
			String savePath = localPath + setPath;		// 저장될 디렉토리

			File OriginalFile = new File(fullPath); 					// 원본파일 가져오기
			File target = new File(savePath, OriginalFile.getName());	// 복사할 위치와 파일이름 지정
			FileCopyUtils.copy(OriginalFile, target);					// 복사

			System.out.println("[파일백업완료] 위치 : " + savePath + " 파일이름 : " + OriginalFile.getName() );

		}


		private static String returnExtName(Map<String, String> extNameMap) throws IOException{

			String extName = extNameMap.get("extName");
			String uploadPath = extNameMap.get("uploadPath");
			String savedName = extNameMap.get("savedName");
			String thumbnailName="";
			if(extName.equals("png") || extName.equals("jpg") || extName.equals("jpeg") || extName.equals("gif")) {

				thumbnailName = resizeThumbnail(uploadPath, savedName);

			}else if(extName.equals("xlsx") || extName.equals("xls")
					|| extName.equals("xlsm")|| extName.equals("xltm")
					|| extName.equals("xlam")|| extName.equals("xlsb")
					|| extName.equals("xltx")){

				thumbnailName = "s_xlsx" + ".png";

			}else if(extName.equals("docx") || extName.equals("doc")){
				thumbnailName = "s_docx.png";

			}else if(extName.equals("htm") || extName.equals("html")){
				thumbnailName = "s_htm.png";
			}else if(extName.equals("pdf")){
				thumbnailName = "s_pdf.png";
			}else if(extName.equals("hwp")){
				thumbnailName = "s_hwp.png";
			}else if(extName.equals("zip")){
				thumbnailName = "s_zip.png";
			}else if(extName.equals("xml")){
				thumbnailName = "s_xml.png";

			}else if(extName.equals("ppt") || extName.equals("pptx")){
				thumbnailName = "s_ppt.png";
			}else {
				thumbnailName = "s_etc.png";
			}

			return thumbnailName;

		}
}
