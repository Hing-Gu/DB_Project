CREATE OR Replace PROCEDURE DeleteEnroll (sStudentId IN VARCHAR2, 
		sCourseId IN VARCHAR2, 
		result	OUT VARCHAR2)
IS
BEGIN
	result := '';

	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(sStudentId || '���� �����ȣ ' || sCourseId || '���� ��Ҹ� ��û�Ͽ����ϴ�.');

	DELETE
	FROM enroll
	WHERE s_id = sStudentId and c_id = sCourseId;

	COMMIT;
	result := '������Ұ� �Ϸ�Ǿ����ϴ�.';

EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
		result := SQLCODE;
END;
/