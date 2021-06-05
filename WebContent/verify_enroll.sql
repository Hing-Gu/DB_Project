SET ServerOutput On;
create or replace procedure SelectTimeTable(
	sStudentId IN VARCHAR2)
is
	v_student students%ROWTYPE;
	cId course.c_id%TYPE;
	cName course.c_name%TYPE;
	cUnit course.c_unit%TYPE;
	cTime course.c_time%TYPE;
	cAddr course.c_addr%TYPE;

	cTotalUnit NUMBER := 0;

CURSOR cur(sStudentId VARCHAR2) IS
	select c_id, c_name, c_unit, c_time, c_addr
	from course
	where c_id in (select e_c_id from enroll where e_s_id = sStudentId); 
	

begin
	open cur (sStudentId);
	
	select s_major
	into v_student.s_major
	from students
	where s_id = sStudentId;

	DBMS_OUTPUT.put_line('#');
	DBMS_OUTPUT.put_line(sStudentId||'���� ������û �ð�ǥ�Դϴ�.');


LOOP
	FETCH cur INTO cId, cName, cUnit, cTime, cAddr;
	EXIT WHEN cur%NOTFOUND;

	DBMS_OUTPUT.put_line('�����ȣ: '||cId||', �����: '||cName||', ����: '||to_char(cUnit)||', ���: '||cAddr);
		
	cTotalUnit := cTotalUnit + cUnit;
END LOOP;

	DBMS_OUTPUT.put_line('�� '|| TO_CHAR(cur%ROWCOUNT)||' ����� �� '||TO_CHAR(cTotalUnit)||'������ ��û�Ͽ����ϴ�.');
	CLOSE cur;
END;
/


	