create or replace function getDay(
  course_time VARCHAR
  )
  return VARCHAR
  is
     course_day VARCHAR(10);
  begin
     select replace(replace(replace(to_char(to_date(course_time,'yyyy-mm-dd hh24:mi:ss'),'d'),'2','����'),'3','ȭ��'),'6','��')
     into course_day
     from dual;
     commit;
     return course_day;
  end;
  /
