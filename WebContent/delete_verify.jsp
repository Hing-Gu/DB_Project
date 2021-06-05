<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<html><head><title> 수강신청 취소 </title></head>
<body>

<%
	Connection myConn = null;    String	result = null;	
	String dburl  = "jdbc:oracle:thin:@localhost:1521:xe";
	String user="db1715914";   String passwd="oracle";

	String dbdriver = "oracle.jdbc.driver.OracleDriver";    
	
	try {
		Class.forName(dbdriver);
	    myConn =  DriverManager.getConnection (dburl, user, passwd);
	} catch(SQLException ex) {
    	 System.err.println("SQLException: " + ex.getMessage());
	}
	
	String session_id= (String)session.getAttribute("user");
		String s_id = (String)session.getAttribute("user");
		String v_c_id = request.getParameter("c_id");	
		CallableStatement cstmt = myConn.prepareCall("{call DeleteEnroll(?,?,?)}");
		cstmt.setString(1, s_id);
		cstmt.setString(2, v_c_id);
		cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);	
		try  {  	
			cstmt.execute();
			result = cstmt.getString(3);
			if (result.equals("수강취소가 완료되었습니다.")){
				String sql = "{call delete_c_enroll(?)}";
				CallableStatement cstmt1 = myConn.prepareCall(sql);
				cstmt1.setString(1,v_c_id);
				cstmt1.execute();
			}
%>
	<script>	
		alert("<%= result %>"); 
		location.href="delete.jsp";
	</script>
<%		
		} catch(SQLException ex) {		
			 System.err.println("SQLException: " + ex.getMessage());
		}  
		finally {
		    if (cstmt != null) 
	            try { myConn.commit(); cstmt.close();  myConn.close(); }
	 	      catch(SQLException ex) { }
	     }
 
%>
</form></body></html>