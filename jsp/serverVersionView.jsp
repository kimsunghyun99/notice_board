<%@ page language = "java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<HTML>
    <head>
<style>
    .info {
        position : relative;
        top : 150px;
        width : 60%;
        margin : auto;
        padding-left: 30px;
        font-size:300%;
        border : solid 1px gray;

    }
</style>
    <title>JSP/Servlet 버전확인</title>
    <meta charset="UTF-8">
    </head>
    <BODY>
        <div>
            <div class = "info">
        <ul>
       <li> 서버버전 :  <%=application.getServerInfo() %> </li>
       <li> 서블릿 버전 : <%=application.getMajorVersion() %>.<%= application.getMinorVersion()%></li>
       <li> JSP 버전 : <%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion()%></li>
    </ul>
    </div>
</div>
    </BODY>
</HTML>