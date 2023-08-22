package team.tttt.pms.common.utils;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


@SuppressWarnings("deprecation")
public class ExcelUtils {

	@SuppressWarnings({ "incomplete-switch", "unused" })
	public static List<Map<String, String>> readExcel(String filePath) {

		// 파일을 읽어와 WorkBook 생성
		Workbook wb = excelFileTypeCheck(filePath);

		List<Map<String, String>> result = new ArrayList<Map<String,String>>();
		Map<String, String> map = null;

		// VO(DTO)의 필드명을 가져옵니다. (순서를 맞춤)
		String[] mapKeyName = {"svlfNo", "stuNo", "userNm", "userGender", "userBrdt", "userPhoneno"};

		/* 	1번째 시트만 있으므로 1번째 시트만 가져옴 */
		Sheet sheet = wb.getSheetAt(0);

		/* sheet에서 유효한 행의 개수를 가져온다.*/
		int numOfRows = sheet.getLastRowNum() + 1;

		/* 엑셀 파일의 numOfRows가 1이 반환될 경우 예외처리 */
		if(numOfRows <= 1) {
			map = new HashMap<String, String>();
			map.put("Error", "numOfRows 1이 반환되는 오류 발생");
			result.add(map);
			return result;
		}

		/* 각 Row만큼 반복을 한다. 2행부터 시작 */
		for(int rowIndex = 1; rowIndex < numOfRows; rowIndex++) {
			Row row = sheet.getRow(rowIndex);

			// sheet.getRow(rowIndex).getCell(2) : cell(2) (= 3번쨰 컬럼값)이 null인 경우에는 if문을 빠져나가도록 설정
			if (sheet.getRow(rowIndex).getCell(2) != null && row != null) {
				int numOfCells = row.getLastCellNum();
				map = new HashMap<>();

				for (int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
					Cell cell = row.getCell(cellIndex);
					if (cell == null) {
						continue;
					} else {
						switch (cell.getCellTypeEnum()) {
						case NUMERIC:
							if (HSSFDateUtil.isCellDateFormatted(cell)) {
								SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
								cell.setCellValue(formatter.format(cell.getDateCellValue()));
							} else {
								if ((cell.getNumericCellValue() + "").contains(".0")) {
									cell.setCellValue((int) cell.getNumericCellValue() + "");
								} else {
									cell.setCellValue((float) cell.getNumericCellValue() + "");
								}
							}
							break;
						case STRING:
							cell.setCellType(CellType.STRING);
							cell.setCellValue(cell.getStringCellValue().toString());
							break;
						case FORMULA:
							cell.setCellType(CellType.STRING);
							String temp_value = cell.getStringCellValue();
							if (temp_value.indexOf(".") > 0) {
								Double value = Double.parseDouble(String.format("%.1f", Double.parseDouble(cell.getStringCellValue())));
								cell.setCellValue(value);
							} else {
								cell.setCellValue(cell.getStringCellValue());
							}
							break;
						}
					}

					String cellName = mapKeyName[cellIndex];
					map.put(cellName, getValue(cell, wb));
				}

				result.add(map);
			} else {
				break;
			}
		} /* 행의 개수가 끝날 떄까지 */
		return result;
	}





    public static Workbook excelFileTypeCheck(String filePath) {

        /*
         * FileInputStream은 파일의 경로에 있는 파일을
         * 읽어서 Byte로 가져온다.
         */
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(filePath);
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e.getMessage(), e);
        }

        Workbook wb = null;

        /*
         * 파일의 확장자를 체크해서 .XLS 라면 HSSFWorkbook에
         * .XLSX라면 XSSFWorkbook에 각각 초기화 한다.
         */
        if(filePath.toUpperCase().endsWith(".XLS")) {
            try {
                wb = new HSSFWorkbook(fis);
            } catch (IOException e) {
                throw new RuntimeException(e.getMessage(), e);
            }
         }
         else if(filePath.toUpperCase().endsWith(".XLSX")) {
            try {
                wb = new XSSFWorkbook(fis);
            } catch (IOException e) {
                throw new RuntimeException(e.getMessage(), e);
            }
         }
         if(fis != null) {
            try {
                  fis.close();
            } catch (IOException e) {
                 System.out.println("예외상황발생");
            }
         }
         return wb;
    }

    public static String getValue(Cell cell, Workbook wb) {
        String value = "";

        if (cell == null) {
            value = "";
        } else {
            FormulaEvaluator evaluator = wb.getCreationHelper().createFormulaEvaluator();
            switch (cell.getCellTypeEnum()) {
                case FORMULA:
                    if (evaluator.evaluateFormulaCell(cell) == CellType.NUMERIC) {
                        value = String.valueOf(cell.getNumericCellValue()); // 계산된 수식의 값을 가져옴
                    } else if (evaluator.evaluateFormulaCell(cell) == CellType.STRING) {
                        value = cell.getStringCellValue(); // 계산된 수식의 문자값을 가져옴
                    }
                    break;
                case NUMERIC:
                    if (org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell)) {
                        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                        value = formatter.format(cell.getDateCellValue());
                    } else {
                        if (String.valueOf(cell.getNumericCellValue()).contains(".0")) {
                            value = String.valueOf((int) cell.getNumericCellValue());
                        } else {
                            value = String.valueOf(cell.getNumericCellValue());
                        }
                    }
                    break;
                case STRING:
                    value = cell.getStringCellValue();
                    break;
                case BOOLEAN:
                    value = String.valueOf(cell.getBooleanCellValue());
                    break;
                case BLANK:
                    value = "";
                    break;
                case ERROR:
                    value = String.valueOf(cell.getErrorCellValue());
                    break;

                default:
                    value = cell.getStringCellValue();
            }
        }
        return value;
    }
}
