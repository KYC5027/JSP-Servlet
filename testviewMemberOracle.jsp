<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%!
  	Connection conn=null;
//쿼리문 이용을 위한 인터페이스
 	Statement stmt=null;
	// 쿼리 결과를 받기 위한 인터페이스
	ResultSet rs=null;
	
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "scott";
	String password = "tiger";
	String sql ="select empno, ename, job, mgr, hiredate, sal, comm, deptno from emp";
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table width="auto" border="1">
	<tr>
	<td>사원번호</td>
	<td>사원명</td>
	<td>직급</td>
	<td>상관번호</td>
	<td>입사일자</td>
	<td>급여</td>
	<td>커미션</td>
	<td>부서번호</td>
		</tr>	
		<%
			try{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection(url, user, password);
//				createStatement() 메소드 호출해서 쿼리 이용하는 Statement 객체 생성				
				stmt = conn.createStatement();
//				executeQuery 메소드로 select 쿼리 실행
//				쿼리 결과는 ResultSet 으로 담는다.
				rs = stmt.executeQuery(sql);
				
//				next() : 쿼리 결과가 있으면 참
				while(rs.next()){
					%>
					<tr>
						<td><%= rs.getInt("empno") %></td>
						<td><%= rs.getString("ename") %></td>
						<td><%= rs.getString("job") %></td>
						<td><%= rs.getString("mgr") %></td>
						<td><%= rs.getString("hiredate") %></td>
						<td><%= rs.getInt("sal") %></td>
						<td><%= rs.getString("comm") %></td>
						<td><%= rs.getInt("deptno") %></td>
					</tr>
					<%
				}
			}catch(SQLException ex){
				out.print("데이터 베이스 연결이 실패했습니다.");
				out.print(ex.getMessage());	
			}finally{
				try{
					if(rs != null){ rs.close();}
					if(stmt != null){ stmt.close();}
					if(conn != null){ conn.close();}
				}catch(SQLException se){
					se.printStackTrace();
				}
			}
		%>
	</table>
</body>
</html>