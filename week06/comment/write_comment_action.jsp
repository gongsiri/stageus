<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    request.setCharacterEncoding("utf-8");

    Object id_value_ob = session.getAttribute("id_value");
    String id_value = String.valueOf(id_value_ob);
    String content_value = request.getParameter("content_value");
    int user_key = 0;
    int posting_key = Integer.parseInt(request.getParameter("posting_key"));

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");
    
    // 로그인 세션(id)를 기준으로 유저 가져옴
    String user_sql = "SELECT * FROM user WHERE id = ?";
    PreparedStatement user_query = connect.prepareStatement(user_sql);
    user_query.setString(1,id_value);
    ResultSet user_result = user_query.executeQuery();
    while(user_result.next()){
        user_key = user_result.getInt("user_key"); // user_key 가져옴
    }

    // 댓글 데이터베이스에 입력해줌
    String sql = "INSERT INTO comment (user_key, posting_key,content) VALUES (?,?,?)";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setInt(1,user_key);
    query.setInt(2,posting_key);
    query.setString(3,content_value);

    query.executeUpdate();
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        alert("댓글 작성 완료")
        location.href="/week06/posting/read_posting.jsp?posting_key=<%=posting_key%>"
    </script>
</body>