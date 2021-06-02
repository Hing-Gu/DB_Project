create or replace procedure InsertEnroll(
      sStudentId IN VARCHAR2,
      sCourseId IN VARCHAR2,
      sNum IN NUMBER,
      result OUT VARCHAR2)
   is
   too_many_sumCourseUnit EXCEPTION;
   too_many_students EXCEPTION;
   duplicate_time EXCEPTION;
   nSumCourseUnit NUMBER;
   nCourseUnit NUMBER;
   nCnt NUMBER;
   nCourseMax NUMBER;
 
   begin
   result := ' ';
 
   DBMS_OUTPUT.put_line('#');
   DBMS_OUTPUT.put_line(sStudentId||'님이 과목번호 '||sCourseId||'의 수강 등록을 요청하였습니다.');
 
   select SUM(c_unit)
   into nSumCourseUnit
   from course where c_id in (select e_c_id from enroll where e_s_id = sStudentId);
 
   select c_unit
   into nCourseUnit
   from course
   where c_id = sCourseId;
 
   if (nSumCourseUnit + nCourseUnit > 18)
   then
   raise too_many_sumCourseUnit;
   end if;
 
   select c_max
   into nCourseMax
   from course
   where c_id = sCourseId;
 
   select c_enroll
   into nCnt
   from course
   where c_id = sCourseId;
 
   if(nCnt >= nCourseMax)
   then
   raise too_many_students;
   end if;
 
  select count(*)
  into nCnt
  from course
  where c_time = 
  (
    select c_time
    from course
    where c_id = sCourseId
    INTERSECT
    select c_time from course where c_id IN (select e_c_id from enroll where e_s_id = sStudentId));

 if (nCnt > 0)
 then
 raise duplicate_time;
 end if;

insert into enroll(e_s_id,e_c_id) values(sStudentId,sCourseId);
insert into course(c_enroll) values(sNum);

commit;
result := '수강신청 등록이 완료되었습니다.';

EXCEPTION
WHEN too_many_sumCourseUnit THEN
 result := '최대학점을 초과하였습니다.';

WHEN too_many_students THEN
 result := '수강신청 인원이 초과되어 등록이 불가능합니다.';

WHEN duplicate_time THEN
 result := '이미 등록된 과목 중 중복되는 시간이 존재합니다.'

WHEN OTHERS THEN
   ROLLBACK;
   result  := SQLCODE;
end;
/