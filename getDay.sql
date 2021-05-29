create or replace function getDay(
  2     course_time VARCHAR
  3  )
  4  return VARCHAR
  5  is
  6     course_day VARCHAR(10);
  7  begin
  8     select replace(replace(replace(to_char(to_date(course_time,'yyyy-mm-dd hh24:mi:ss'),'d'),'2','월수'),'3','화목'),'6','금')
  9     into course_day
 10     from dual;
 11
 12     commit;
 13     return course_day;
 14  end;
 15  /