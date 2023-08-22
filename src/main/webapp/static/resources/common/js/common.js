/**
 * 이 파일 수정은 kt에게 요청
 */

function goToMenu(menu) {
    const menuMap = {
      "login": `${$t.cpath}/user/login`,
      "logout": `${$t.cpath}/user/logout`,

      "pms_main": `${$t.cpath}/pms/projects`,
      "pms_myprojects" : `${$t.cpath}/pms/myprojects`,
      "pms_dashboard" : `${$t.cpath}/pms/project/dashBoard`,
      "pms_tasklist" : `${$t.cpath}/pms/project/taskList`,
      "pms_gantt" : `${$t.cpath}/pms/project/gantt`,
      "pms_calander" : `${$t.cpath}/pms/project/calander`,
      "pms_taskhanban" : `${$t.cpath}/pms/project/kanban`,
      "pms_issue" : `${$t.cpath}/pms/project/issue`,
      "pms_storage" : `${$t.cpath}/pms/project/storage`,
      "pms_manage" : `${$t.cpath}/pms/manage`,

      "stu_stumain": `${$t.cpath}/stu/main`,
      "stu_h_cfroom": `${$t.cpath}/stu/hak/cfroom`,
      "stu_h_cert": `${$t.cpath}/stu/hak/cert`,
      "stu_h_attdan": `${$t.cpath}/stu/hak/attdan`,
      "stu_h_consult": `${$t.cpath}/stu/hak/consult`,
      "stu_h_timetable": `${$t.cpath}/stu/hak/timetable`,
      "stu_classroom": `${$t.cpath}/stu/classroom`,
      "stu_c_assign": `${$t.cpath}/stu/classroom/assign`,
      "stu_c_qstn": `${$t.cpath}/stu/classroom/qstn`,
      "stu_c_bbs": `${$t.cpath}/stu/classroom/bbs`,
      "stu_m_modify": `${$t.cpath}/stu/mypage/modify`,
      "stu_m_inout": `${$t.cpath}/stu/mypage/modify`,
      "stu_m_resume": `${$t.cpath}/stu/mypage/resume`,
      "stu_m_abandon": `${$t.cpath}/stu/mypage/abandon`,
      "stu_notice": `${$t.cpath}/stu/notice`,

      "emp_main": `${$t.cpath}/emp/main`,
      "emp_notice": `${$t.cpath}/emp/hntc/hntcBoard`,

      "emp_svlf": `${$t.cpath}/emp/svlf/svlfList`,    // 연수과정
      "emp_stulist": `${$t.cpath}/emp/stuman/stulist`,    // 학원생 등록
      "emp_attend": `${$t.cpath}/emp/stuman/attend`,    // 출결관리
      "emp_kalleave": `${$t.cpath}/emp/stuman/kalleave`,    // 조퇴/외출
      "emp_dscsnboard": `${$t.cpath}/emp/dscsn/dscsnBoard`,    // 상담관리

      "emp_sbjctList": `${$t.cpath}/emp/sbjct/sbjctList`,    // 수업관리
      "emp_schedule": `${$t.cpath}/emp/class/schedule`,    // 시간표
      "emp_cmcode": `${$t.cpath}/emp/cmcode`,    // 공통코드

      "emp_tchmanage": `${$t.cpath}/emp/tchmanage`,    // 강사관리

      "tch_main": `${$t.cpath}/tch/main`,    // 강사_메인
      "tch_stulist": `${$t.cpath}/tch/dam/stulist`,    // 강사_담당반 - 원생목록
      "tch_attend": `${$t.cpath}/tch/dam/attdan`,    // 강사_담당반 - 원생 출결
      "tch_proj": `${$t.cpath}/tch/dam/proj`,    // 강사_담당반 - 프로젝트
      "tch_class": `${$t.cpath}/tch/class`,    // 강사_수업
      "tch_schedule": `${$t.cpath}/tch/schedule`,    // 강사_시간표

      "1": `${$t.cpath}/stu/hak/`,
      "2": `${$t.cpath}/stu/hak/`,
      "#": "#"

    };

    window.location.href = menuMap[menu];
  }