<%-- 
    Document   : home
    Created on : Oct 15, 2023, 11:47:59 PM
    Author     : pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            header {
                background-color: rgb(226, 162, 42);
                color: white;
                padding: 10px 0;
                text-align: center;
                position: relative;
            }
            nav ul {
                list-style-type: none;
                padding: 0;
            }

            nav ul li {
                display: inline;
                margin-right: 20px;
            }

            nav ul li a {
                color: white;
                text-decoration: none;
                font-weight: bold;
            }

            nav ul li a:hover {
                text-decoration: underline;
            }
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }
            .logo {
                display: block;
                margin: 0 auto;
                max-width: 100%;
                width: 100%;
                height: auto;
                margin-top: 5px;
            }
            footer {
                background-color: #333;
                color: white;
                text-align: center;
                padding: 10px 0;
                position: fixed;
                bottom: 0;
                width: 100%;
            }
            .container {
                width: 80%;
                margin: 0 auto;
            }
            span {
                position: absolute;
                top: 75%; /* Đưa span lên giữa theo chiều dọc */
                right: 100px; /* Cách lề phải 20px */
                transform: translateY(-50%);
            }

        </style>
    </head>
    <body>
        <header>
            <h1>FPT University Academic Portal</h1>
            <nav>
                <ul>
                    <li><a href="http://localhost:9999/MyProject/view/home.jsp">Home</a></li>
                    <li><a href="../instructor/timetable?id=<%= session.getAttribute("uid")%>">Weekly Timetable</a></li>
                    <li><a href="../instructor/attreport?id=<%= session.getAttribute("uid")%>">Attendance report</a></li>
                    <li><a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ">Help</a></li>
                    <li><a href="../logout"><i>Logout</i></a></li>
                    <span>Hello: <i><%= session.getAttribute("username")%></i> </span>
                </ul>

            </nav>
        </header>
        <img src="../img/DH-FPT-4359-1612093890.jpg" alt="School Logo" class="logo"/>
        <footer>
            <div class="container">
                FPT University - since 2006
            </div>
        </footer>
    </body>
</html>
