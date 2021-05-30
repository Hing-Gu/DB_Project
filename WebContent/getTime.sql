create or replace function getTime(
   	course_time VARCHAR
 )
return VARCHAR
is
   course_start_time VARCHAR(10);
   begin
	select substr(course_time,12,5)
	into course_start_time
	from dual;

	commit;
	return course_start_time;
end;
/