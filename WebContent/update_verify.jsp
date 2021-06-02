<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head><title> 수강신청 사용자 정보 수정 </title></head>
<body>

<%
request.setCharacterEncoding("UTF-8");
Connection myConn = null;
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";

String user = "db1812572";
String passwd = "soo";
Class.forName(dbdriver);

PreparedStatement stmt = null;

String newId = request.getParameter("id");
String newPwd = request.getParameter("password");
String newConfirmPwd = request.getParameter("passwordConfirm");
String newMajor = request.getParameter("major");

//만약 패스워드와 패스워드 확인이 다르다면
if(!newPwd.equals(newConfirmPwd)){
	%><script> 
	alert("비밀번호와 비밀번호 확인이 다릅니다."); 
	location.href="update.jsp";  
	</script><%
}
else{
	try{
		myConn = DriverManager.getConnection(dburl, user, passwd);
		String SQL_query = "UPDATE students SET s_pwd=?, s_major=? WHERE s_id=?";
		stmt= myConn.prepareStatement(SQL_query);
		
		stmt.setString(1, newPwd);
		stmt.setString(2, newMajor);
		stmt.setString(3, newId);
		
		stmt.executeUpdate();
		%>
		
		<script>
			alert("수정이 완료되었습니다.");
			location.href="main.jsp";
			</script>
		<%
	}
	catch(SQLException ex){
		String sMessage="";
		if (ex.getErrorCode() == 20002) sMessage="암호는 4자리 이상이어야 합니다";
		else if (ex.getErrorCode() == 20003) sMessage="암호에 공란은 입력되지 않습니다.";
		else sMessage="잠시 후 다시 시도하십시오";
		out.println("<script>");
		out.println("alert('"+sMessage+"');");
		out.println("location.href='update.jsp';");
		out.println("</script>");
		out.flush();

	}
	finally{
		if(stmt!=null)try{stmt.close();}catch(SQLException sqle){}
	}
}


%>

</body></html>