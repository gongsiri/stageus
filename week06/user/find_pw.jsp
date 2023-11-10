<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    String id_value = request.getParameter("id_value");
    String email_value = request.getParameter("email_value");
    String pw_value="";
    int check=0; // 가입 여부

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");

    String sql = "SELECT * FROM user WHERE id= ? AND email= ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, id_value);
    query.setString(2, email_value);
    ResultSet result = query.executeQuery();
    while(result.next()){
         pw_value = result.getString("pw");
         check=1;
    }  
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="find_pw_action.css">
    <script>
        if(<%=check%>==0){
            alert("입력한 정보로 가입된 계정은 없습니다.")
            history.back()
        }
    </script>
</head>
<body>
    <header>
        <input type="button" id="logo" value="GONGSIL 게시판"  onClick="location.href='../index.jsp'">
    </header>
    <input type="button" value="뒤로가기" id="back" onclick="history.back()">
    <main>
            <h1>비밀번호 찾기 결과</h1>
            <h3 id="result">입력한 정보로 조회된 비밀번호는 <%=pw_value%> 입니다.</h3>
            <div id="button_div">
                <input type="button" value="로그인" id="log_in" onclick="location.href='log_in.html'">
                <input type="button" value="다시 찾기" id="refind" onclick="location.href='find_pw.html'">
            </div>
    </main>
</body>