<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<html><head><title>수강신청 삭제</title></head>
<body>
<%@ include file="top.jsp" %>
<% if(session_id == null) response.sendRedirect("login.jsp"); %>

<table width="75%" align="center" border>
<br>
<tr><th>과목번호</th><th>분반</th><th>과목명</th><th>시간</th><th>강의장소</th><th>학점</th><th>삭제</th></tr>
<%
Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;
String mySQL = "";
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "db1715914";
String passwd = "oracle";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

try{
	Class.forName(dbdriver);
	myConn=DriverManager.getConnection(dburl,user,passwd);
	stmt=myConn.createStatement();
}catch(SQLException ex){
	System.err.println("SQLException: " + ex.getMessage());
}
mySQL = "select c_id,c_id_no,c_name,c_time,c_addr,c_unit from course where c_id in (select e_c_id from enroll where e_s_id='"+session_id+"')";
myResultSet = stmt.executeQuery(mySQL);

if(myResultSet != null){
	while(myResultSet.next()){
		String c_id = myResultSet.getString("c_id");
		int c_id_no = myResultSet.getInt("c_id_no");
		String c_name = myResultSet.getString("c_name");
		String c_time = myResultSet.getString("c_time");
		String c_addr = myResultSet.getString("c_addr");
		int c_unit = myResultSet.getInt("c_unit");
%>
<tr>
 <td align="center"><%= c_id %></td>
 <td align = "center"><%= c_id_no %></td>
 <td align="center"><%= c_name %></td>
 <td align = "center"><%= c_time %></td>
 <td align = "center"><%= c_addr %></td>
 <td align = "center"><%= c_unit %></td>
 <td align="center"><a href ="delete_verify.jsp?c_id=<%= c_id %>">삭제</a></td>		
</tr>
<%		
	}
}
stmt.close();
myConn.close();
%>
</table>
</body>
</html>
