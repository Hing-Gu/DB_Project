<%@ page language="java" contentType="text/html;
charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> <meta charset="UTF-8"> <title>수강신청 시스템 로그인
</title> </head>
<body>
<style>
input{
	width:200px;
}</style>
<table width="75%" align="center" bgcolor="#AFEEEE" >
<tr> <td><div align="center">아이디와 패스워드를 입력하세요
</div></td></table>
<table width="75%" align="center" >
<form method="post" action="login_verify.jsp">
<tr>
<td><div align="right">아이디</div></td>
<td><div align="center">
<input type="text" name="userID" align="left">
</div></td>
</tr>
<tr>
<td><div align="right">패스워드</div></td>
<td><div align="center">
<input type="password" name="userPassword" align="left">
</div></td></tr>
<tr>
<td colspan=2><div align="center">
<INPUT TYPE="SUBMIT" NAME="Submit" VALUE="로그인">
<INPUT
TYPE="RESET" VALUE="취소">
</div></td></tr>
</form>
</table>
</body>
</html>