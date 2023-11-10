<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("utf-8");
    Object id_value_ob = session.getAttribute("id_value");
    String id_value = String.valueOf(id_value_ob);
    String pw_value = request.getParameter("pw_value");
    String name_value = request.getParameter("name_value");
    String phone_value = request.getParameter("phone_value");
    String birth_value = request.getParameter("birth_value");

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");
    
    // 로그인 세션(아이디)를 통해 값 업데이트
    String sql = "UPDATE user SET pw=?, name=?, phone=?, birth=? WHERE id=?"; 
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, pw_value);
    query.setString(2, name_value);
    query.setString(3, phone_value);
    query.setString(4, birth_value);
    query.setString(5, id_value);
    query.executeUpdate();
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="my_info.css">
</head>
<body>
    <script>
        alert("수정되었습니다.")
        location.href="my_info.jsp"
    </script>
</body>
</html>