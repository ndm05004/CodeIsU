package team.tttt.pms.common.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CmCdVO {

    private int cdVl;
    private String cdTypeId;
    private String cdNm;
    private String cdExpln;
    private String cdCUseYn;

    private String cdTypeNm;
}
