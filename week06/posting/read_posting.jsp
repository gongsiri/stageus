<%@ page language="java" contentType="text/html" pageEncoding="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("utf-8");
    ArrayList<Integer> comment_user_key_list = new ArrayList<Integer>();
    ArrayList<String> comment_writer_list = new ArrayList<String>();
    ArrayList<String> comment_content_list = new ArrayList<String>();
    ArrayList<String> comment_date_list = new ArrayList<String>();
    ArrayList<Integer> comment_key_list = new ArrayList<Integer>();
    int posting_key =Integer.parseInt(request.getParameter("posting_key"));
    String title="";
    String writer="";
    String date="";
    int view_count=0;
    int comment = 0;
    String content="";
    int user_key=0;
    int comment_user_key = 0;
    String comment_writer="";
    String comment_content = "";
    String comment_date ="";
    int comment_key=0;
    int comment_count =0;

    Class.forName("com.mysql.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mysql://localhost/week06","gongsil","1005");

    //넘겨받은 posting_key를 기준으로 게시물 가져옴
    String sql = "SELECT * FROM posting WHERE posting_key = ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setInt(1,posting_key);
    ResultSet result = query.executeQuery();
    while(result.next()){
        title = result.getString("title");
        date = result.getString("date");
        content = result.getString("content");
        user_key = result.getInt("user_key");
        view_count = result.getInt("view_count");
    }

    // 위에서 알아낸 user_key(즉 게시물 작성자 key)를 기준으로 유저 가져옴
    String user_sql = "SELECT * FROM user WHERE user_key = ?";
    PreparedStatement user_query = connect.prepareStatement(user_sql);
    user_query.setInt(1, user_key);
    ResultSet user_result = user_query.executeQuery();
    while(user_result.next()) {
        writer = user_result.getString("id"); //작성자 id 알아냄
    }

    //posting_key를 기준으로 조회수를 ++ 해줌
    String view_sql = "UPDATE posting SET view_count =(view_count+1) WHERE posting_key = ?";
    PreparedStatement view_query = connect.prepareStatement(view_sql);
    view_query.setInt(1,posting_key);
    view_query.executeUpdate();

    //posting_key를 기준으로 그 게시물에 달린 댓글 가져옴
    String comment_sql = "SELECT * FROM comment WHERE posting_key=?";
    PreparedStatement comment_query = connect.prepareStatement(comment_sql);
    comment_query.setInt(1,posting_key);
    ResultSet comment_result = comment_query.executeQuery();
    while (comment_result.next()) {
        comment_user_key = comment_result.getInt("user_key");
        comment_content = comment_result.getString("content");
        comment_date = comment_result.getString("date");
        comment_key=comment_result.getInt("comment_key");

        //댓글 작성자 user_key를 기준으로 댓글 작성자 id 가져옴
        String comment_user_sql = "SELECT * FROM user WHERE user_key=?";
        PreparedStatement comment_user_query = connect.prepareStatement(comment_user_sql);
        comment_user_query.setInt(1,comment_user_key);
        ResultSet comment_user_result = comment_user_query.executeQuery();
        while(comment_user_result.next()){
            comment_writer = comment_user_result.getString("id");
        }

        comment_user_key_list.add(comment_user_key);
        comment_writer_list.add(comment_writer);
        comment_content_list.add(comment_content);
        comment_date_list.add(comment_date);
        comment_key_list.add(comment_key);
    }
    
    // posting_key를 기준으로 그 게시물에 달린 댓글의 수를 comment_count라는 이름으로 가져옴
    String comment_count_sql ="SELECT COUNT(*) AS comment_count FROM comment WHERE posting_key=?";
    PreparedStatement comment_count_query = connect.prepareStatement(comment_count_sql);
    comment_count_query.setInt(1,posting_key);
    ResultSet comment_count_result = comment_count_query.executeQuery();
    while(comment_count_result.next()) {
        comment_count = comment_count_result.getInt("comment_count");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="read_posting.css">
</head>
<body>
    <header>
        <input type="button" id="logo" value="GONGSIL 게시판" onClick="location.href='../../index.jsp'">
    </header>
    <input type="button" value="뒤로가기" id="back" onclick="history.back()">
    <main>
        <div id="posting_title_div">
            <h1 id="posting_title"></h1>
        </div>
        <div id="posting_writer_div">
            작성자 :
            <div id="posting_writer"></div>
        </div>
        <div id="posting_date_div">
            <div id="posting_date"></div>
        </div>
        <div id="posting_view_count_div">
            조회
            <div id="posting_view_count"></div>
        </div>
        <div id="comment_top_div">
            댓글
            <div id="comment_top"></div>
        </div>
        <div id="posting_md_div">
            <input type="button" id="posting_modify" value="수정" onclick="location.href='modify_posting.jsp?posting_key=<%=posting_key%>'"> <!--posting_key를 get형식으로 넘겨줌-->
            <input type="button" id="posting_delete" value="삭제" onclick="location.href='delete_posting_action.jsp?posting_key=<%=posting_key%>'">     
        </div>

        <div id="border_line"></div>
        <article id="content_article"></article>
        <div id="border_line"></div>

        <div id="comment_bottom_div">
            댓글
            <div id="comment_bottom"></div>
        <div id="comment_div">
            <%
                // 댓글 수만큼
                for (int i=0; i< comment_key_list.size(); i++){
            %>
            <div id="comment">
                <div class="comment_wirter"><%= comment_writer_list.get(i)%></div>
                <div class="comment_date"><%= comment_date_list.get(i)%></div>
                <div class="comment_content"><%= comment_content_list.get(i)%></div>
                <%
                    // 댓글 작성자와 로그인된 사용자가 같을 때만 수정 삭제 버튼이 보이게
                    if(String.valueOf(session.getAttribute("id_value")).equals(comment_writer_list.get(i))){
                %>
                <input type="button" value="수정" class="comment_modify" onclick="window.open('/week06/comment/modify_comment.jsp?comment_key=<%=comment_key_list.get(i)%>','width=400','height=350')">
                <input type="button" value="삭제" class="comment_delete" onclick="location.href='/week06/comment/delete_comment.jsp?posting_key=<%=posting_key%>&comment_key=<%=comment_key_list.get(i)%>'">
                <%
                    }
                %>
            </div>
             <%
                }
             %>
        </div>
        <div id="comment_write">
            <form action="/week06/comment/write_comment_action.jsp">
                <input type="hidden" name="posting_key" id="posting_key_hidden">
                <input type="text" id="comment_write_txt" name="content_value">
                <input type="submit" id="comment_write_btn" value="댓글쓰기">
            </form>
        </div>
    </main>
    <script>
        window.onload = function(){
            document.getElementById("posting_title").innerHTML = '<%=title%>'
            document.getElementById("posting_writer").innerHTML = '<%=writer%>'
            document.getElementById("posting_date").innerHTML = '<%=date%>'
            document.getElementById("posting_view_count").innerHTML = <%=view_count%>
            document.getElementById("comment_top").innerHTML = <%=comment_count%>
            document.getElementById("content_article").innerHTML = '<%=content%>'
            document.getElementById("comment_bottom").innerHTML=<%=comment_count%>
            document.getElementById("posting_key_hidden").value = <%=posting_key%>

            var log_in_person = '<%=session.getAttribute("id_value")%>'

            if(log_in_person == "null"){
                document.getElementById("comment_write_txt").style.display="none"
                document.getElementById("comment_write_btn").style.display="none"
            }
            if(log_in_person == '<%=writer%>'){
                document.getElementById("posting_modify").style.display="block"
                document.getElementById("posting_delete").style.display="block"
            }
            else if(log_in_person == "null" || log_in_person!='<%=writer%>'){
                document.getElementById("posting_modify").style.display="none"
                document.getElementById("posting_delete").style.display="none"
            }
        }
    </script>
</body>
</html>