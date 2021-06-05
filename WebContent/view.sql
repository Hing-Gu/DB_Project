SET ServerOutput On;
create or replace view dbstudent (s_id, s_major, e_c_id)
as
select s.s_id, s.s_major, e.e_c_id
from students s, enroll e
where s.s_id = e.e_s_id and e_c_id = 'M300'

DBMS_OUTPUT.put_line(SQL%ROWCOUNT);
with read only;