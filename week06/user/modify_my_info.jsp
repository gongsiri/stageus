<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%
    Object id_value_ob = session.getAttribute("id_value");
    String id_value = String.valueOf(id_value_ob);
    String origin_id_value ="";
    String origin_pw_value ="";
    String origin_email_value ="";
    String origin_name_value ="";
    String origin_phone_value ="";
    String origin_birth_value ="";

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");

    String sql = "SELECT * FROM user WHERE id=?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, id_value);
    ResultSet result = query.executeQuery();
    while(result.next()){
        origin_id_value = result.getString("id");
        origin_pw_value = result.getString("pw");
        origin_email_value = result.getString("email");
        origin_name_value = result.getString("name");
        origin_phone_value = result.getString("phone");
        origin_birth_value = result.getString("birth").replace("-",""); //하이픈 제거하고 출력
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="modify_my_info.css">
</head>
<body>
    <header>
        <input type="button" id="logo" value="GONGSIL 게시판" onclick="location.href='../../index.jsp'">
    </header>
    <input type="button" value="뒤로가기" id="back" onclick="history.back()">
    <main>
        <form action="modify_my_info_action.jsp" onsubmit="return check()">
            <div class="top_div">
                <div class="id_div">
                    <div id="id" name="id_value"></div>
                </div>

                <div class="pw_div">
                    <input type="password" id="pw" onchange="pw_check()" name="pw_value">
                    <div class="check_text" id="pw_check_text">다시 입력하십시오</div>
                    <input type="button" id="pw_see">
                </div>

                <div class="pw_check_div">
                    <input type="password" placeholder="비밀번호 확인" id="pw_same_check" onchange="pw_same()">
                    <div class="check_text" id="pw_check_check_text">일치하지 않습니다</div>
                </div>

                <div class="email_div">
                    <div id="email" name="email_value"></div>
                </div>
            </div>

            <div class="bottom_div">
                <div class="name_div">
                    <input type="text" id="name" onchange="name_check()" name="name_value">
                    <div class="check_text" id="name_check_text">다시 입력하십시오</div>
                </div>

                <div class="birth_div">
                    <input type="text" id="birth" onchange="birth_check()" name="birth_value">
                    <div class="check_text" id="birth_check_text">다시 입력하십시오</div>
                </div>

                <div class="phone_div">
                    <input type="text" id="phone" onchange="phone_check()"  name="phone_value">
                    <div class="check_text" id="phone_check_text">다시 입력하십시오</div>
                </div>
            </div>
            <div id="button_div">
                <input type="submit" value="수정하기" id="modify_btn">
                <input type="button" value="취소하기" id="cancel_btn" onclick="location.href='my_info.jsp'">
            </div>
        </form>
    </main>
    <script>
        document.getElementById("id").innerHTML='<%=origin_id_value%>'
        document.getElementById("pw").value='<%=origin_pw_value%>'
        document.getElementById("email").innerHTML='<%=origin_email_value%>'
        document.getElementById("name").value='<%=origin_name_value%>'
        document.getElementById("birth").value='<%=origin_birth_value%>'
        document.getElementById("phone").value='<%=origin_phone_value%>'

        function check(){
            var pw = document.getElementById("pw").value
            var pw_same_check = document.getElementById("pw_same_check").value
            var name = document.getElementById("name").value
            var birth = document.getElementById("birth").value
            var phone = document.getElementById("phone").value

            var count = 0
            for(var i=0;i<5;i++){
                if(document.getElementsByClassName("check_text")[i].style.display=="block"){
                    count++
                }
            }
            if(pw!='<%=origin_pw_value%>'){
                if(pw_same_check===""){
                    alert("비밀번호 확인을 진행해주세요")
                    return false
                }
            }
            if(count!=0){ //조건에 맞게 입력하지 않았을 때
                alert("제대로 입력해주세요")
                return false
            }
            if(name===""||birth===""||phone===""){
                alert("모든 입력칸을 입력해 주십시오")
                return false
            }
            if(document.getElementById("id_duplication_check_btn").style.display!="none"){
                alert("아이디 중복확인을 진행해주십시오")
                return false
            }
            if(document.getElementById("email_duplication_check_btn").style.display!="none"){
                alert("이메일 중복확인을 진행해주십시오")
                return false
            }

        }

        function pw_check(){
            var pw = document.getElementById("pw").value
            var pw_pattern = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,30}$/
            if(!pw_pattern.test(pw)){
                document.getElementById("pw_check_text").style.display="block"
            }
            else{
                document.getElementById("pw_check_text").style.display="none"
            }
        }

        function pw_same(){
            var pw = document.getElementById("pw").value
            var pw_same_check = document.getElementById("pw_same_check").value
            if(pw!=pw_same_check){
                document.getElementById("pw_check_check_text").style.display="block"
            }
            else if(pw==pw_same_check){
                document.getElementById("pw_check_check_text").style.display="none"
            }
        }

        function name_check(){
            var name = document.getElementById("name").value
            var name_pattern = /^[가-힣]{2,5}$/
            if(!name_pattern.test(name)){
                document.getElementById("name_check_text").style.display="block"
            }
            else{
                document.getElementById("name_check_text").style.display="none"
            }
        }

        function birth_check(){
            var birth = document.getElementById("birth").value
            var birth_pattern = /^(19|20)[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/
            if(!birth_pattern.test(birth)){
                document.getElementById("birth_check_text").style.display="block"
            }
            else{
                document.getElementById("birth_check_text").style.display="none"
            }
        }

        function phone_check(){
            var phone = document.getElementById("phone").value
            var phone_pattern = /^01[0179][0-9]{7,8}$/
            if(!phone_pattern.test(phone)){
                document.getElementById("phone_check_text").style.display="block"
            }
            else{
                document.getElementById("phone_check_text").style.display="none"
            }
        }
    </script>
</body>
</html>