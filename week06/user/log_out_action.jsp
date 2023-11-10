<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%
    session.removeAttribute("id_value");
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <script>
        alert("로그아웃 됐습니다!")
        location.href="../../index.jsp"
    </script>
</body>