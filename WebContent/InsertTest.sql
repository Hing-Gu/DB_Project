SET ServerOutput On;

DECLARE
result VARCHAR(50) := '';

BEGIN

DBMS_OUTPUT.enable;

DBMS_OUTPUT.put_line('**********Insert �� ���� ó�� �׽�Ʈ**********');

InsertEnroll('1400015','M800',result);
DBMS_OUTPUT.put_line('���: '||result);

InsertEnroll('1400015','C400',result);
DBMS_OUTPUT.put_line('���: '||result);

InsertEnroll('1400015','M600',result);
DBMS_OUTPUT.put_line('���: '||result);

InsertEnroll('1400015','M700',result);
DBMS_OUTPUT.put_line('���: '||result);

DBMS_OUTPUT.put_line('**********CURSOR�� �̿��� SELECT�׽�Ʈ**********');

SelectTimeTable('1400015');

delete from enroll where e_s_id = '1400015' and e_c_id = 'M600';

END;
/