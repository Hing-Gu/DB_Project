create or replace procedure InsertEnroll(
  2     sStudentId IN VARCHAR2,
  3     sCourseId IN VARCHAR2,
  4     result OUT VARCHAR2)
  5  is
  6  too_many_sumCourseUnit EXCEPTION;
  7  too_many_students EXCEPTION;
  8  duplicate_time EXCEPTION;
  9
 10  nSumCourseUnit NUMBER;
 11  nCourseUnit NUMBER;
 12  nCnt NUMBER;
 13  nCourseMax NUMBER;
 14
 15  begin
 16  result := '';
 17  DBMS_OUTPUT.put_line('#');
 18  DBMS_OUTPUT.put_line(sStudentId || '님이 과목번호 '||sCourseId||'의 수강 등록을 요청하였습니다.');
 19
 20  select SUM(c_unit)
 21  into nSumCourseUnit
 22  from course where c_id in (select e_c_id from enroll where e_s_id = sStudentId);
 23
 24  select c_unit
 25  into nCourseUnit
 26  from course
 27  where c_id = sCourseId;
 28
 29  if(nSumCourseUnit + nCourseUnit > 18)
 30  then
 31  raise too_many_sumCourseUnit;
 32  end if;
 33
 34  select c_max
 35  into nCourseMax
 36  from course
 37  where c_id = sCourseId;
 38
 39  select c_enroll
 40  into nCnt
 41  from course
 42  where c_id = sCourseId;
 43
 44  if(nCnt >= nCourseMax)
 45  then
 46  raise too_many_students;
 47  end if;
 48
 49  select count(*)
 50  into nCnt
 51  from
 52  (
 53     select c_time
 54     from course
 55     where c_id = sCourseId
 56     INTERSECT
 57     select c_time from course where c_id IN (select e_c_id from enroll where e_s_id = sStudentId));
 58
 59  if(nCnt > 0)
 60  then
 61  raise duplicate_time;
 62  end if;
 63
 64  insert into enroll values(sStudentId,sCourseId);
 65
 66  commit;
 67  result := '수강신청 등록이 완료되었습니다.';
 68
 69  EXCEPTION
 70  WHEN too_many_sumCourseUnit THEN
 71  result := '최대학점을 초과하였습니다.';
 72  WHEN too_many_students THEN
 73  result := '수강신청 인원이 초과되어 등록이 불가능합니다.';
 74  WHEN duplicate_time THEN
 75  result := '이미 등록된 과목 중 중복되는 시간이 존재합니다.';
 76  WHEN OTHERS THEN
 77     ROLLBACK;
 78     result := SQLCODE;
 79  end;
 80  /