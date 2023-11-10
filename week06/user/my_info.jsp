<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    //session.getAttribute는 Object 자료형이기에 String으로 형변환 해줌
    Object id_value_ob = session.getAttribute("id_value");
    String id_value = String.valueOf(id_value_ob);
    String id = "";
    String email = "";
    String name = "";
    String phone = "";
    String birth = "";
    String date = "";

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");
    
    //로그인 세션으로부터 받아온 id값으로 정보들 가져옴
    String sql = "SELECT * FROM user WHERE id= ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, id_value);
    ResultSet result = query.executeQuery();
    while(result.next()){
        id = result.getString("id");
        email = result.getString("email");
        name = result.getString("name");
        phone = result.getString("phone");
        birth = result.getString("birth");
        date = result.getString("date");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="my_info.css">
</head>
<body>
    <header>
        <input type="button" id="logo" value="GONGSIL 게시판" onclick="location.href='../../index.jsp'">
    </header>
    <input type="button" value="뒤로가기" id="back" onclick="history.back()">
    <main>
        <table>
            <tr>
                <th>아이디</th>
                <td id="id"></td>
            </tr>
            <tr>
                <th>이메일</th>
                <td id="email"></td>
            </tr>
            <tr>
                <th>이름</th>
                <td id="name"></td>
            </tr>
            <tr>
                <th>연락처</th>
                <td id="phone"></td>
            </tr>
            <tr>
                <th>생년월일</th>
                <td id="birth"></td>
            </tr>
            <tr>
                <th>가입일</th>
                <td id="date"></td>
            </tr>
        </table>
        <div id="info_md_div">
            <input type="button" id="info_modify" value="수정" onclick="location.href='modify_my_info.jsp'">
            <input type="button" id="info_delete" value="탈퇴" onclick="location.href='delete_my_info_action.jsp'">
        </div>
    </main>
    <script>
        document.getElementById("id").innerHTML='<%=id%>'
        document.getElementById("email").innerHTML='<%=email%>'
        document.getElementById("name").innerHTML='<%=name%>'
        document.getElementById("phone").innerHTML='<%=phone%>'
        document.getElementById("birth").innerHTML='<%=birth%>'
        document.getElementById("date").innerHTML='<%=date%>'
    </script>
</body>
</html>