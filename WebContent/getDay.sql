create or replace function getDay(
  course_time VARCHAR
  )
  return VARCHAR
  is
     course_day VARCHAR(10);
  begin
     select replace(replace(replace(to_char(to_date(course_time,'yyyy-mm-dd hh24:mi:ss'),'d'),'2','월수'),'3','화목'),'6','금')
     into course_day
     from dual;
     commit;
     return course_day;
  end;
  /
