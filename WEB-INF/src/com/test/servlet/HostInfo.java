package com.test.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.servlet.annotation.WebServlet;

@WebServlet("/servlet/hostinfo")

public class HostInfo extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset = UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<head>");
        out.println("<title>클라이언트 주소를 읽는 서블릿 예제</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h1> 클라이언트 주소를 읽는 서블릿 예제 </h1> ");
        out.println("<h2>Client IP : " + request.getRemoteAddr() + "</h2>");
        out.println("<h2>Client Host : " + request.getRemoteHost() + "</h2>");
        out.println("<h2>Request URI : " + request.getRequestURI() + "</h2>");
        out.println("<body>");
        out.println("</html>");

    }

    

}