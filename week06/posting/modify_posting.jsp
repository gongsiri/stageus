<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    String origin_title_value ="";
    String origin_content_value ="";
    int posting_key =Integer.parseInt(request.getParameter("posting_key"));

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");

    // 전달받은 posting_key 기준으로 게시물 가져옴
    String sql = "SELECT * FROM posting WHERE posting_key=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setInt(1, posting_key);
    ResultSet result = query.executeQuery();
    while(result.next()){
        origin_title_value = result.getString("title");
        origin_content_value = result.getString("content");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="modify_posting.css">
</head>
<body>
    <header>
        <input type="button" id="logo" value="GONGSIL 게시판"  onClick="location.href='../../index.jsp'">
    </header>
    <input type="button" value="뒤로가기" id="back" onclick="history.back()">
    <main>
        <div id="write_posting">    
            <h1>게시글 수정</h1>
        </div>
        <form action="modify_posting_action.jsp" onsubmit="return check()">
            <article>
                
                <input type="hidden" name="posting_key" id ="posting_key"></div>
                <input type="text" id="title" name="title">
                <textarea row="10" cols="20" id="context" name="content"></textarea>
            </article>
            <div id="submit_div">
                <input type="submit" id="submit" value="등록">
            </div>
        </form>
    </main>
    <script>
        document.getElementById("posting_key").value = <%=posting_key%>
        document.getElementById("title").value = '<%=origin_title_value%>'
        document.getElementById("context").innerHTML = '<%=origin_content_value%>'

        function check(){
            if(document.getElementById("title").value.trim()===""){
                alert("제목을 입력해주세요")
                return false
            }
            if(document.getElementById("context").value.trim()===""){
                alert("내용을 입력해주세요")
                return false
            }
        }
    </script>
</body>
</html>