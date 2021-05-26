<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head><title>수강신청 사용자 정보 수정</title></head>
<body>
<%@ include file="top.jsp" %>
…
if (session_id==null) response.sendRedirect("login.jsp");
…
String mySQL = "select s_addr,s_pwd from student where s_id='" + session_id + "'" ;
…
<form method="post" action="update_verify.jsp">
…
</form></body></html>