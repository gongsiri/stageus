<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("utf-8");
    String title_value = request.getParameter("title");
    String content_value = request.getParameter("content");
    int posting_key = Integer.parseInt(request.getParameter("posting_key"));

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");

    String sql = "UPDATE posting SET title=?, content=? WHERE posting_key=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, title_value);
    query.setString(2, content_value);
    query.setInt(3, posting_key);

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
        location.href="../../index.jsp"
    </script>
</body>
</html>