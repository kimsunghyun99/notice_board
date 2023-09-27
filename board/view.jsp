<%@ page language = "java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 내용 보기</title>

    <style>
        body { font-family: "나눔고딕", "맑은고딕";}
        h1 { font-family: "HY견고딕";}
        a:link { color : black} 
        a:visited { color : black}
        a:hover { color: red }
        a {text-decoration: none; cursor:hand;}
        .main {
            text-align: center;
        }
        .topBanner {
            margin-top : 10px;
            margin-bottom : 10px;
            max-width: 500px;
            height: auto;
            display : block;
            margin: auto;

        }
        
        .boardView {
            width: 60%;
            height:auto;
            margin:auto;
            padding: 20px, 20px;
            background-color: white;
            border:solid 4px gray;
            border-radius:20px;
        }

        .items {
            width:90%;
            height: 25px;
            outline: none;
            color : #636e72;
            font-size: 16px;
            background:none;
            border-bottom: 2px solid #adadad;
            margin: 30px;
            padding: 10px;
            text-align: left;

        }
        .textArea {
            width:90%;
            height: 350px;
            overflow:auto;
            margin: 22px;
            padding: 10px;
            box-sizing: border-box;
            border: 2px solid #adadad;
            text-align : left;
            font-size: 16px;
            resize : both;
        }

        .bottom_menu {
        margin-top : 20px;
                     }
    .bottom_menu > a:link, .bottom_menu > a:visited {
        background-color: #FFA500;
        color:maroon;
        padding: 15px 25px;
        text-align: center;
        display : inline-block;
        text-decoration:none;
    }

    .bottom_menu > a:hover, .bottom_menu > a:active {
        background-color: #1E90FF;
        text-decoration: none;
    }

    </style>

    <%

    // int seqno = Integer.parseInt(request.getParameter("seqno"));
    String seqno = request.getParameter("seqno");

    %>

</head>

<script>
function boardDelete() {
alert("삭제");
       if(confirm("정말 삭제 하시겠습니까?")==true)  document.location.href ='/board/delete?seqno=<%=seqno%>';
}


</script>



<body>
    
    <%
    
    String uri ="jdbc:oracle:thin:@localhost:1521:xe";
    String userid = "springdev";
    String userpw = "1234";
    String query = "select seqno,title,writer,to_char(regdate, 'YYYY-MM-DD HH24:MI:SS') as regdate,content from tbl_board where seqno= " + seqno; 
    String query_hitno = "update tbl_board set hitno = ( select nvl(hitno,0) from tbl_board where seqno = " + seqno + ") + 1 where seqno = " +seqno;

    String query_prev =  "select nvl(max(seqno),0) as prev_seqno from tbl_board where seqno <" + seqno;
    String query_next =  "select nvl(min(seqno),0) as next_seqno from tbl_board where seqno >" + seqno;


    System.out.println("게시물 상태 보기 SQL = " + query);
    System.out.println("게시물 조회수 증가 SQL = " + query_hitno);

    String writer = "";
    String title = "";
    String regdate = "";
    String content = "";
    
    int prev_seqno = 0;
    int next_seqno = 0;

    
    
    
    // Response에 브라우저에 한글 출력을 utf-8로 인코딩해서 출력
    response.setCharacterEncoding("utf-8");

    Connection con ;
    Statement stmt;
    Statement stmt_hitno ;
    Statement stmt_prev;
    Statement stmt_next;
    ResultSet rs ;
    ResultSet rs_prev ;
    ResultSet rs_next ;


    try {
        Class.forName("oracle.jdbc.driver.OracleDriver"); 
        con = DriverManager.getConnection(uri, userid, userpw);
        stmt = con.createStatement();
        stmt_hitno = con.createStatement();
        stmt_prev = con.createStatement();
        stmt_next = con.createStatement();
        rs = stmt.executeQuery(query);
        rs_prev = stmt_prev.executeQuery(query_prev);
        rs_next = stmt_next.executeQuery(query_next);
        stmt_hitno.executeUpdate(query_hitno);


        // 게시물 상세 보기 값 가져오기
        if(rs.next()) {
            writer = rs.getString("writer");
            title = rs.getString("title");
            regdate = rs.getString("regdate");
            content  = rs.getString("content");
        }


        //이전 다음 게시물 값 번호 가져오기
        if(rs_prev.next()) prev_seqno = rs_prev.getInt("prev_seqno");
        if(rs_next.next()) next_seqno = rs_next.getInt("next_seqno");

        if(rs != null) rs.close();
        if(rs_prev != null) rs.close();
        if(rs_next != null) rs.close();
        if(stmt != null) stmt.close();
        if(stmt_hitno != null) stmt_hitno.close();
        if(stmt_prev != null) stmt_prev.close();
        if(stmt_next != null) stmt_next.close();


        if(con != null) con.close();
        if(stmt_hitno != null) stmt_hitno.close();
                    
                }catch(Exception e) {
                    e.printStackTrace();
                }

 
    

%>

<div class ="main">

    <img src="/images/logo.jpg" class="topBanner"><br>
    <h1 style="text-align: center;">게시물 내용 보기</h1>
    <br>

    <div class = "boardView">

        <div class ="items">글쓴이 : <%=writer %> </div>
        <div class ="items">제목 : <%=title %> </div>
        <div class ="items">날짜 : <%=regdate %> </div>
        <div class ="textArea"><pre>내용 : <%=content %></pre> </div>


        </div>

        <div class = "bottom_menu">
            <% if(prev_seqno != 0) {  %>
                <a href = "/board/view.jsp?seqno=<%=prev_seqno%>"> 이전▼</a> &nbsp;&nbsp;
            <% } %>
            <a href = "/board/list.jsp">목록가기</a> &nbsp;&nbsp;
            <% if(next_seqno != 0) {  %>
            <a href = "/board/view.jsp?seqno=<%=next_seqno%>">다음▲</a> &nbsp;&nbsp;
            <% } %>

            <a href = "/board/write.jsp">글 작성</a> &nbsp;&nbsp;
            <a href = "/board/modify.jsp?seqno=<%=seqno%>">글 수정</a> &nbsp;&nbsp;
            <a href = "javascript:boardDelete()">글 삭제</a>
            
        </div>
        <br><br>

    </div>

</body>



</html>