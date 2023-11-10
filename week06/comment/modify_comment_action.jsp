<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("utf-8");
    
    int comment_key = Integer.parseInt(request.getParameter("comment_key"));
    String content = request.getParameter("content");

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");

    String sql = "UPDATE comment SET content=? WHERE comment_key=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, content);
    query.setInt(2,comment_key);

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
        window.close()
    </script>
</body>
</html>