<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    String email_value = request.getParameter("email_value");
    int check = 0;

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");

    String sql = "SELECT * FROM user WHERE email=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, email_value);
    ResultSet result = query.executeQuery();
    while(result.next()){
        check=1;
    }
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        if(<%=check%>==1){
            alert("<%=email_value%>"+"는 사용할 수 없습니다.")
            window.close();
        }
        else{
            if(confirm("<%=email_value%>"+"는 사용할 수 있습니다.\n" +"사용하시겠습니까?")){
                window.opener.document.getElementById("email_duplication_check_btn").style.display="none"
                window.opener.document.getElementById("email").readOnly = true;
                window.close();
            }
            else{
                window.close();
            }
        }
    </script>
</body>