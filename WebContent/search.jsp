<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ include file = "top.jsp" %>
<%
	if(session_id == null)
		response.sendRedirect("login.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"><title>수강신청 조회</title></head>
<body>

<% 
String course_id = "";
int course_id_no = 0;
String course_name = "";
String course_time = "";
String course_day = "";
int course_unit = 0;
int total_course = 0;
int total_unit = 0;
String course_addr = "";
Connection conn = null;
PreparedStatement pstmt = null;
CallableStatement cstmt = null;
ResultSet rs = null;
ResultSet sub_rs = null;
String sql;
String sub_sql;
String time_sql;
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "db1812572";
String passwd = "soo";
%>

<br>
<table width="80%" align="center" border="1">
<tr><th>과목번호</th><th>분반</th><th>과목명</th><th>시간</th><th>강의장소</th><th>학점</th></tr>

<%
try { 
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(dburl,user,passwd);
	sql = "select c_id,c_id_no from course where c_id in (select e_c_id from enroll where e_s_id = ?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,session_id);
	rs = pstmt.executeQuery();
	while(rs.next()){
		course_id = rs.getString("c_id");
		course_id_no = rs.getInt("c_id_no");
		
		sub_sql = "select c_name,c_time,c_addr,c_unit from course where c_id = ? and c_id_no = ?";
		pstmt = conn.prepareStatement(sub_sql);
		pstmt.setString(1,course_id);
		pstmt.setInt(2,course_id_no);
		sub_rs = pstmt.executeQuery();
		if(sub_rs.next()){
			course_name = sub_rs.getString("c_name");
			course_time = sub_rs.getString("c_time");
			course_addr = sub_rs.getString("c_addr");
			course_unit = sub_rs.getInt("c_unit");
			total_unit = total_unit + course_unit;
			total_course++;
		}
		System.out.println("dd = "+course_time);
		time_sql = "{? = call getDay(?)}";
		cstmt = conn.prepareCall(time_sql);
		System.out.println("cstmt = "+cstmt);
		cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
		cstmt.setString(2,course_time);
		cstmt.execute();
		course_day = cstmt.getString(1);
		System.out.println("result = "+course_day);
		
		cstmt.close();
%>

<tr>
	<td align="center"><%=course_id %></td>
	<td align="center"><%=course_id_no %></td>
	<td align="center"><%=course_name %></td>
	<td align="center"><%=course_day %></td>
	<td align="center"><%=course_addr %></td>
	<td align="center"><%=course_unit %></td>
	
<%	
	}
	rs.close();
	pstmt.close();
	conn.close();

}catch (SQLException ex){
	System.err.println("SQLException: " + ex.getMessage());
}
%>
</tr>
</table>
<br>
<br>
<div width = "75%" align = "center">
	<p>현재까지 <%=total_course %>과목, 총 <%=total_unit %>학점 수강신청 했습니다.</p>
</div>
</body>
</html>