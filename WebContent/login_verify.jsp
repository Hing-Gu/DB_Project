<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
String userID=request.getParameter("userID");
String userPassword=request.getParameter("userPassword");

Connection myConn = null;
String dbdriver = "oracle.jdbc.driver.OracleDriver";
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";

String user = "db1812572";
String passwd = "soo";
Class.forName(dbdriver);
myConn=DriverManager.getConnection(dburl, user, passwd);

String mySQL="select s_id from students where s_id='" + userID + "'and s_pwd='" + userPassword + "'";

Statement stmt = myConn.createStatement();

ResultSet rs = stmt.executeQuery(mySQL);
Boolean isLogin = false;

if(rs!=null){
   if(rs.next()){
      isLogin = true;
      String id = rs.getString("s_id");
      session.setAttribute("user", id);
   }
}

// DB에 내가 적은 정보가 있다면
if(isLogin) {
    // 첫 페이지로 돌려보낸다
   %>
    <script>
    document.location.href='./main.jsp'
    </script>


<%
   } else {%>
    <script>
    document.location.href='./login.jsp'
    </script>


<%
   }
stmt.close();
myConn.close();
%>
