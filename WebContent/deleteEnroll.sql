SET ServerOutput On;
CREATE OR replace PROCEDURE DeleteEnroll
		(sStudentId IN enroll.e_s_id%TYPE, 
		sCourseId IN enroll.e_c_id%TYPE, 
		result OUT VARCHAR2)
IS
BEGIN
	result := '';
	 DBMS_OUTPUT.put_line('#');

	DBMS_OUTPUT.put_line(sStudentId || '님이 과목번호 ' || sCourseId || '수강 취소를 요청하였습니다.');

	DELETE
	FROM enroll
	WHERE e_s_id = sStudentId and e_c_id = sCourseId;

	COMMIT;
	result := '수강취소가 완료되었습니다.';

EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
		result := SQLCODE;
END;
/