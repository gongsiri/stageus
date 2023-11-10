<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("utf-8");

    Object id_value_ob = session.getAttribute("id_value");
    String id_value = String.valueOf(id_value_ob);
    String title_value = request.getParameter("title_value");
    String content_value = request.getParameter("content_value");
    int user_key = 0;

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");

    //로그인 세션(id)를 기준으로 유저 가져옴
    String user_sql = "SELECT * FROM user WHERE id = ?";
    PreparedStatement user_query = connect.prepareStatement(user_sql);
    user_query.setString(1,id_value);
    ResultSet user_result = user_query.executeQuery();
    while(user_result.next()){
        user_key = user_result.getInt("user_key"); //user_key 얻음
    }

    // posting 데이터베이스에 값 넣어줌
    String sql = "INSERT INTO posting (user_key,title,content) VALUES (?,?,?)";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setInt(1,user_key);
    query.setString(2, title_value);
    query.setString(3, content_value);

    query.executeUpdate();
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        alert("포스팅에 성공함")
        location.href="../../index.jsp"
    </script>
</body>