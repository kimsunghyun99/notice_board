<%@ page language = "java" contentType = "text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset = "UTF-8">
    <title>게시물 등록</title>
    
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

        .WriteForm {
            width:60%;
            height: auto;
            margin: auto;
            padding: 20px;
            background-color: white;
            text-align : center;
            border: 4px solid gray;
            border-radius: 30px;
        }

        .items {
            width: 90%;
            border:none;
            border-bottom: 2px solid gray;
            padding:10px;
            outline : none;
            color: #636e72;
            height: 25px;
            background: none;
        }

        #content {
            width : 90%;
            height : 300px;
            box-sizing : border-box;
            border:solid gray;
            font-size: 16px;
            resize : both;
        }

        .btn_write {
            position: relative;
            margin-top:20px;
            margin-bottom: 10px;
            width:40%;
            height:40px;
            background: red;
            color:white;
            font-weight: bold;
            border : none;
            cursor : pointer;
            display : inline;

        }

        .btn_cancel {
            position: relative;
            margin-top:20px;
            margin-bottom: 10px;
            width:40%;
            height:40px;
            background: pink;
            background-size: 200%;
            color:white;
            font-weight: bold;
            border : none;
            cursor : pointer;
            display : inline;
            
        }

    </style>

        <script>
            function registerForm() {

                let writer = document.querySelector('#writer');
                let title = document.querySelector('#title');
                let content = document.querySelector('#content');


                // 필수값 등록시 값 입력 여부 확인
                if(writer.value === '' ) {   // window.document.WriteForm.writer.value -- > DOM : Document Object Model
                    alert('이름을 입력하세요!!!');
                    writer.focus();
                    return false;
                }

                if(title.value === '') {
                    alert('제목을 입력하세요');
                    title.focus();
                    return false;
                }
                if(content.value === '') {
                    alert('내용을 입력하세요!!!');
                    content.focus();
                    return false;

                }
                
                document.WriteForm.action = '/board/write';
                document.WriteForm.submit();


            }
        </script>

</head>

<body>

 <div class = "main">
    <img src="/images/logo.jpg" class="topBanner"><br>
    <h1>게시물 등록</h1>
    <br>
    <div id = "formZone"> 
        <form class = "WriteForm" name = "WriteForm" method="post">

            <input type = "text" id ="writer" class = "items" name = "writer" placeholder="작성자 이름을 입력하세요">
            <input type = "text" id ="title" class = "items" name = "title" placeholder="제목을 입력하세요">
            <br>   <br>
            <textarea id = "content"  cols="100" rows = "500" name="content" placeholder = "내용을 입력하세요"></textarea>
            <input type = "button" class = "btn_write" value="등록" onclick = "registerForm()">
            <input type = "button" class = "btn_cancel" value="취소" onclick = "history.back()">

        </form>

    </div>
    <br><br>
 </div>   

</body>


</html>