<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<html><head><title>수강신청 입력</title></head>
<body>
<%@ include file="top.jsp" %>
<% if(session_id == null) response.sendRedirect("login.jsp"); %>

<table width="75%" align="center" border>
<br>
<tr><th>과목번호</th><th>분반</th><th>과목명</th><th>강의시간</th><th>학점</th><th>수강신청</th></tr>
<%
Connection myConn = null;
Statement stmt = null;
ResultSet myResultSet = null;
String mySQL = "";
String sql;
CallableStatement cstmt = null;
String course_day = "";
String course_time = "";
String tmp = "";
int course_end_hh;
int course_end_mi;
String course_start_time;
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "db1812572";
String passwd = "soo";
String dbdriver = "oracle.jdbc.driver.OracleDriver";

try{
	Class.forName(dbdriver);
	myConn=DriverManager.getConnection(dburl,user,passwd);
	stmt=myConn.createStatement();

mySQL = "select c_id,c_id_no,c_name,c_time,c_unit from course where c_id not in (select e_c_id from enroll where e_s_id='"+session_id+"')";
myResultSet = stmt.executeQuery(mySQL);

if(myResultSet != null){
	while(myResultSet.next()){
		String v_c_id = myResultSet.getString("c_id");
		int c_id_no = myResultSet.getInt("c_id_no");
		String c_name = myResultSet.getString("c_name");
		String c_time = myResultSet.getString("c_time");
		int c_unit = myResultSet.getInt("c_unit");
		
		sql = "{? = call getDay(?)}";
		cstmt = myConn.prepareCall(sql);
		cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
		cstmt.setString(2,c_time);
		cstmt.execute();
		course_day = cstmt.getString(1);
		
		cstmt.close();
		
		sql = "{? = call getTime(?)}";
		cstmt = myConn.prepareCall(sql);
		cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
		cstmt.setString(2,c_time);
		cstmt.execute();
		course_start_time = cstmt.getString(1);;
		
		cstmt.close();		
		
	 	tmp = course_start_time.substring(0,2);	
	 	course_end_hh = Integer.parseInt(tmp) + 1;
	 	tmp = course_start_time.substring(3);	
	 	course_end_mi = Integer.parseInt(tmp) + 15;
%>
<tr>
 <td align="center"><%= v_c_id %></td>
 <td align = "center"><%= c_id_no %></td>
 <td align="center"><%= c_name %></td>
 <td align="center"><%= course_day %> <%=course_start_time %> - <%= course_end_hh %>:<%= course_end_mi %></td>
 <td align = "center"><%= c_unit %></td>
 <td align="center"><a href ="insert_verify.jsp?c_id=<%= v_c_id %>&c_id_no=<%= c_id_no %>">신청</a></td>		
</tr>
<%		
	}
}
cstmt.close();
stmt.close();
myConn.close();
}catch (NumberFormatException e){

}catch(SQLException ex){
	System.err.println("SQLException: " + ex.getMessage());
}
%>
</table>
</body>
</html>
