<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String id_value = request.getParameter("id_value");
    String pw_value = request.getParameter("pw_value");
    int check = 0; // pw와 id 같은지

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");
    
    // 입력한 id를 기준으로 유저들 가져옴
    String sql = "SELECT * FROM user WHERE id= ?"; // 여기에 pw도 추가 where에
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, id_value);
    ResultSet result = query.executeQuery();

    //만약 입력한 pw 값과 입력한 id의 저장된 pw값이 같으면 check = 1
    //이때 session을 설정해줌(id를 기준으로 했음)
    while(result.next()){
        if(result.getString("pw").equals(pw_value)){
            check=1;
            session.setAttribute("id_value",id_value);
        }
    }
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        if(<%=check%>==0){ // pw와 id가 다르면
            alert("로그인에 실패했습니다.")
            history.back()
        }
        else{
            location.href="../../index.jsp"
        }
    </script>
</body>