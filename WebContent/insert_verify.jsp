<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html><head><title>쩌철째짯쩍��쨩 ��쨌�</title></head>
<body>

<%
 String s_id = (String)session.getAttribute("user");
 String v_c_id = request.getParameter("c_id");
%>

<%
Connection myConn = null;
String result = null;
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "db1812572";
String passwd = "soo";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

try{
   Class.forName(dbdriver);
   myConn = DriverManager.getConnection(dburl,user,passwd);
}catch(SQLException ex){
   System.err.println("SQLException: " + ex.getMessage());
}
CallableStatement cstmt = myConn.prepareCall("{call InsertEnroll(?,?,?)}");

cstmt.setString(1,s_id);
cstmt.setString(2,v_c_id);
cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
try{
	cstmt.execute();
	result = cstmt.getString(3);
	System.out.println("result" +result);
	if (result.equals("수강신청 등록이 완료되었습니다.")){
		String sql = "{call add_c_enroll(?)}";
		CallableStatement cstmt1 = myConn.prepareCall(sql);
		cstmt1.setString(1,v_c_id);
		cstmt1.execute();
	}	

%>

<script>
 alert("<%=result%>");
 location.href="insert.jsp";
</script>
<%
}catch(SQLException ex){
   System.err.println("SQLExcetion: " + ex.getMessage());
}
finally{
   if(cstmt != null)
      try{
         myConn.commit();
         cstmt.close();
         myConn.close();
      }catch(SQLException ex){}
}
%>

</body>
</html>