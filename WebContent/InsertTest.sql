SET ServerOutput On;
/

DECLARE
result VARCHAR(50) := '';

BEGIN

DBMS_OUTPUT.enable;

DBMS_OUTPUT.put_line('**********Insert 및 에러 처리 테스트**********');

InsertEnroll('1400015','M800',result);
DBMS_OUTPUT.put_line('결과: '||result);

InsertEnroll('1400015','C400',result);
DBMS_OUTPUT.put_line('결과: '||result);

InsertEnroll('1400015','M600',result);
DBMS_OUTPUT.put_line('결과: '||result);

InsertEnroll('1400015','M300',result);
DBMS_OUTPUT.put_line('결과: '||result);

DBMS_OUTPUT.put_line('**********CURSOR를 이용한 SELECT테스트**********');

SelectTimeTable('1400015');

delete from enroll where e_s_id = '1400015' and e_c_id = 'M600';

END;
/