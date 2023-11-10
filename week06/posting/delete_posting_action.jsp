<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("utf-8");
    int posting_key = Integer.parseInt(request.getParameter("posting_key"));

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");

    String sql = "DELETE FROM posting WHERE posting_key= ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setInt(1, posting_key);

    query.executeUpdate();
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        alert("게시물을 삭제했습니다.")
        location.href="../../index.jsp"
    </script>
</body>