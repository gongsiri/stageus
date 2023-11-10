<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    int comment_key = Integer.parseInt(request.getParameter("comment_key"));
    String content = "";

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");

    // comment_key를 기준으로 댓글 가져옴
    String sql = "SELECT * FROM comment WHERE comment_key=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setInt(1, comment_key);
    ResultSet result = query.executeQuery();
    while(result.next()){
        content = result.getString("content"); // 댓글 내용 가져옴
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <main>
        <form action="modify_comment_action.jsp" onsubmit="return check()">
            <input type="hidden" name="comment_key" id="comment_key_hidden">
            <input type="text" id="content_text" name="content">
            <input type="submit" value="수정">
        </form>
    </main>
    <script>
        window.onload = function(){
            document.getElementById("content_text").value ='<%=content%>'
            document.getElementById("comment_key_hidden").value=<%=comment_key%>
        }

        function check(){
            if(document.getElementById("content_text").value.trim()===""){
                alert("값을 입력하시오")
                return false
            }
        }
    </script>
</body>