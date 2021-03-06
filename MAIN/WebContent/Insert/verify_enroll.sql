CREATE OR REPLACE PROCEDURE SelectTimeTable(sStudentId IN VARCHAR2,
		nYear      IN NUMBER,
		nSemester  IN NUMBER)					
IS
	sId COURSE.C_ID%TYPE;
	sName COURSE.C_NAME%TYPE;
	nIdNo COURSE.C_ID_NO%TYPE;
	nUnit COURSE.C_UNIT%TYPE;

	nSTime TEACH.T_TIME%TYPE;
	sWhere TEACH.T_CLASSROOM%TYPE;
	nTotUnit NUMBER := 0;
 
CURSOR cur (sStudentId VARCHAR2, nYear NUMBER, nSemester NUMBER) IS
	SELECT e.c_id, c.c_name, e.c_id_no, c.c_unit, t.t_time, t.t_classroom
	FROM enroll e, course c, teach t
	WHERE e.s_id = sStudentId and e.e_year = nYear and e.e_semester=nSemester and
		  t.t_year = nYear  and t.t_semester = nSemester and
		  e.c_id = c.c_id and e.c_id_no=c.c_id_no and
		  c.c_id=t.c_id and c.c_id_no = t.c_id_no
	ORDER BY 5;

BEGIN
	OPEN cur(sStudentId, nYear, nSemester); 

	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(TO_CHAR(nYear) || '년도 ' || TO_CHAR(nSemester) || '학기의 ' || sStudentId || '님의 수강신청 시간표입니다.');                         
  
LOOP
	FETCH cur INTO sId, sName, nIdNo, nUnit, nSTime, sWhere;
	EXIT  WHEN cur%NOTFOUND;

	DBMS_OUTPUT.put_line('교시:'  || TO_CHAR(nSTime) || ', 과목번호:'  || sID || 
			  ', 과목명:'|| sName || ', 분반:' || TO_CHAR(nIdNo) ||
			  ', 학점:'  || TO_CHAR(nUnit) ||	 ', 장소:'  || sWhere);

	nTotUnit := nTotUnit + nUnit;
END LOOP;

	DBMS_OUTPUT.put_line('총 ' || TO_CHAR(cur%ROWCOUNT) || ' 과목과 총 ' || TO_CHAR(nTotUnit) || '학점을 신청하였습니다.');

	CLOSE cur;
END;
/