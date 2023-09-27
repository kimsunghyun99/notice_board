package com.test.board;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.sql.*;
import java.io.IOException;

@WebServlet("/board/write")
public class write extends HttpServlet  {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        doPost(request,response);
    }
    
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        request.setCharacterEncoding("utf-8");
        String uri ="jdbc:oracle:thin:@localhost:1521:xe";
        String userid = "springdev";
        String userpw = "1234";

        Connection con = null;
        Statement stmt = null;
       

        String writer = request.getParameter("writer");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        String query = "insert into tbl_board (seqno,userid,writer,title,content,regdate) values "
        +  "(tbl_board_seq.nextval,'김성현', '" + writer + "','" + title + "','" + content + "',sysdate)";
        System.out.println("게시물 등록 SQL " + query);

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver"); 
            con = DriverManager.getConnection(uri, userid, userpw);
            stmt = con.createStatement();
            stmt.executeUpdate(query);

            if(stmt != null) stmt.close();
            if(con != null) con.close();

            response.sendRedirect("/board/list.jsp");


        } catch(Exception e) {
            e.printStackTrace();
        }
    }


}
