<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");

    //게시물들을 담을 arraylist
    ArrayList<String> title_list = new ArrayList<String>();
    ArrayList<Integer> view_count_list = new ArrayList<Integer>();
    ArrayList<Integer> recommend_list = new ArrayList<Integer>();
    ArrayList<Integer> posting_key_list = new ArrayList<Integer>();
    ArrayList<String> writer_list = new ArrayList<String>();
    ArrayList<String> date_list = new ArrayList<String>();

    String title="";
    Integer view_count = 0;
    Integer posting_key =0;
    Integer user_key =0;
    String writer="";
    String date="";

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");
    
    //모든 게시물을 가져옴
    String sql = "SELECT * FROM posting";
    PreparedStatement query = connect.prepareStatement(sql);
    ResultSet result = query.executeQuery();
    
    while(result.next()){
        title = result.getString("title");
        view_count = result.getInt("view_count");
        posting_key = result.getInt("posting_key");
        user_key = result.getInt("user_key");
        date = result.getString("date");

        //게시물에서 가져온 user_key를 토대로 id를 가져옴(작성자)
        String usersql = "SELECT * FROM user WHERE user_key = ?";
        PreparedStatement userQuery = connect.prepareStatement(usersql);
        userQuery.setInt(1, user_key);
        ResultSet userResult = userQuery.executeQuery();
    
        while(userResult.next()) {
            writer = userResult.getString("id");
        }

        title_list.add(title);
        view_count_list.add(view_count);
        posting_key_list.add(posting_key);
        date_list.add(date);
        writer_list.add(writer);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="week06/main.css">
</head>
<body>
    <header>
        <input type="button" id="logo" value="GONGSIL 게시판">
        <input type="button" id="log_in" value="로그인" onclick="location.href='/week06/user/log_in.html'">  
        <input type="button" id="my_info" value="내 정보 보기" onclick="location.href='/week06/user/my_info.jsp'">
        <input type="button" id="log_out" value="로그아웃" onclick="location.href='/week06/user/log_out_action.jsp'">
    </header>
    <main>
        <table>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>작성 날짜</th>
            </tr>
            <%
                //모든 게시물을 담은 list의 크기만큼 반복해서 게시물들을 차례대로 출력해줌
                for (int i=0; i< posting_key_list.size(); i++){
            %>
            <tr class="posting_tr">
                <td class="posting_num"><%= posting_key_list.get(i) %></td>
                <td class="posting_title"><a href="/week06/posting/read_posting.jsp?posting_key=<%=posting_key_list.get(i)%>"><%=title_list.get(i)%></a></td>
                <td class="posting_writer"><%= writer_list.get(i) %></td>
                <td class="posting_view"><%= view_count_list.get(i) %></td>
                <td class="posting_date"><%= date_list.get(i) %></td>
            </tr>
            <%
                }
            %>
        </table>

        <div id="posting_div">
            <input type="button" id="posting" value="글쓰기" onclick="check()">
        </div>
    </main>
    <script>
        var title_list = <%=title_list%> // 이렇게 갖고올 수 있음 (반복문 돌릴 수 있음)
        // 로그인한 사람 가져옴
        var log_in_person = '<%=session.getAttribute("id_value")%>'
        
        //로그인 안 되어 있으면 글 못 쓰게 제한
        function check(){
            if (log_in_person == "null"){    
                alert("로그인이 필요한 서비스입니다.")
            }
            else{
                location.href = "/week06/posting/write_posting.html"
            }
        }
        
        //로그인 되어 있으면 로그아웃, 내 정보 보기 버튼 / 로그인 안 되어 있으면 로그인 버튼
        window.onload = function(){
            console.log(log_in_person)
            if(log_in_person == "null"){
                document.getElementById("log_in").style.display="block"
                document.getElementById("log_out").style.display="none"
                document.getElementById("my_info").style.display="none"
            }
            else{
                document.getElementById("log_out").style.display="block"
                document.getElementById("my_info").style.display="block"
                document.getElementById("log_in").style.display="none"
            }
        }
    </script>
</body>
</html>