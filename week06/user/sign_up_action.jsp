<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
    request.setCharacterEncoding("utf-8");

    String id_value = request.getParameter("id_value");
    String pw_value = request.getParameter("pw_value");
    String email_value = request.getParameter("email_value");
    String name_value = request.getParameter("name_value");
    String birth_value = request.getParameter("birth_value");
    String phone_value = request.getParameter("phone_value");

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");

    String sql = "INSERT INTO user (id,pw,phone,name,email,birth) VALUES (?,?,?,?,?,?)";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, id_value);
    query.setString(2, pw_value);
    query.setString(3, phone_value);
    query.setString(4, name_value);
    query.setString(5, email_value);
    query.setString(6, birth_value);
    
    query.executeUpdate();
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        alert("회원가입에 성공했습니다.")
        location.href="../../index.jsp"
    </script>
</body>