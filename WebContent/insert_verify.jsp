<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html><head><title>¼ö°­½ÅÃ» ÀÔ·Â</title></head>
<body>

<%
 String s_id = (String)session.getAttribute("user");
 String c_id = request.getParameter("c_id");
%>

<%
Connection myConn = null;
String result = null;
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "db1715914";
String passwd = "oracle";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

try{
   Class.forName(dbdriver);
   myConn = DriverManager.getConnection(dburl,user,passwd);
}catch(SQLException ex){
   System.err.println("SQLException: " + ex.getMessage());
}
CallableStatement cstmt = myConn.prepareCall("{call InsertEnroll(?,?,?)}");

cstmt.setString(1,s_id);
cstmt.setString(2,c_id);
cstmt.registerOutParameter(3,java.sql.Types.VARCHAR);
try{
	cstmt.execute();
	result = cstmt.getString(3);

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