<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head><title>수강신청 사용자 정보 수정</title></head>
<body>
<%@ include file="top.jsp" %>
<%
	Connection myConn = null;
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "db1715914";
	String passwd = "oracle";
	Class.forName(dbdriver);
	ResultSet rs = null;
	Statement stmt = null;
	String user_major ="";
	String user_pwd = "";
	
%>
<%
	//로그인이 안 되어있으면 login 창으로 이동
	if (session_id==null){ %>
		<script> 
		alert("로그인 후 정보 업데이트가 가능합니다."); 
		location.href="login.jsp";
	</script>
	<%
	}
	else{
		try{
			//로그인이 되어있다면 쿼리문 수행
			//s_major, s_name, s_pwd 변경위해 받아옴
			myConn=DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement();
			String mySQL = "select s_major,s_pwd, s_enroll_unit from students where s_id='" + session_id + "'";
			rs=stmt.executeQuery(mySQL);
		}catch(SQLException e){
			out.println(e);
			e.printStackTrace();
		}finally{
			if(rs != null){
				if (rs.next()) {
					//바뀌기 전 사용자 정보들 쿼리로 받아온 것
					user_major = rs.getString("s_major");
					user_pwd = rs.getString("s_pwd");
					%>
					<script> 
						alert("user_major : "+user_major); 
						alert("user_pwd : "+user_pwd);  
						
					</script>  
<%
				}
				else {
%>
					<script> 
						alert("세션이 종료되었습니다. 다시 로그인 해주세요."); 
						location.href="login.jsp";  
					</script>  
<%
				}
		}
	}
	}
%>

<form method="post" action="update_verify.jsp?id=<%=session_id%>">
<table align="center" id="update_table">
			<tr>
			  <td id="update_td">아이디</td>
			  <td colspan="3"><input id="update_id_in" type="text" name="id" size="50" style="text-align: center;" value="<%=session_id%>" disabled></td>
			</tr>
			<tr>
			  <td id="update_td">전공</td>
			  <td><input id="update_mj_in" type="major" name="major" size="10" value=<%=user_major%>></td>
			</tr>
			
			<tr>
			  <td id="update_td">비밀번호</td>
			  <td><input id="update_pw_in" type="password" name="password" size="10" value=<%=user_pwd%>></td>
			  <td id="update_td">비밀번호 확인</td>
			  <td><input id="update_pw_in" type="password" name="passwordConfirm" size="10" ></td>
			</tr>
			
			
			  <td colspan="4" align="center">
			  <input id="update_btn" type="submit" value="수정 완료">
			  <input id="update_btn" type="reset" value="초기화">
			</tr>
			</table>
</form></body></html>