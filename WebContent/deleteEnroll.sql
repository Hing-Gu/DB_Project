SET ServerOutput On;
CREATE OR replace PROCEDURE DeleteEnroll
		(sStudentId IN enroll.e_s_id%TYPE, 
		sCourseId IN enroll.e_c_id%TYPE, 
		result OUT VARCHAR2)
IS
BEGIN
	result := '';
	 DBMS_OUTPUT.put_line('#');

	DBMS_OUTPUT.put_line(sStudentId || '���� �����ȣ ' || sCourseId || '���� ��Ҹ� ��û�Ͽ����ϴ�.');

	DELETE
	FROM enroll
	WHERE e_s_id = sStudentId and e_c_id = sCourseId;

	COMMIT;
	result := '������Ұ� �Ϸ�Ǿ����ϴ�.';

EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
		result := SQLCODE;
END;
/