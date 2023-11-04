<%-- 
    Document   : att
    Created on : Oct 25, 2023, 2:39:56 PM
    Author     : pc
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            h1{
                text-align: center;
            }
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 0;
            }

            .container {
                margin: 20px;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .attendance-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            .attendance-table th, .attendance-table td {
                border: 1px solid #dddddd;
                padding: 10px;
                text-align: left;
            }

            .attendance-table th {
                background-color: #f2f2f2;
            }
            input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 12px 24px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 16px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }

            .center {
                text-align: center;
                margin-top: 20px;
            }
            .red-text {
                color: red;
            }
            .logo {
                width: 200px; /* Điều chỉnh kích thước ảnh */
                height: 200px;
                object-fit: cover; /* Giữ tỷ lệ khung hình khi thay đổi kích thước */

            }
            .hello {
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
                    <span class="hello">Hello: <i><%= session.getAttribute("username")%></i> </span>
                </ul>
            </nav>
        </header>
        <h1>Take Attendance</h1>
        <div class="container">
            <b>Group information</b>: <span class="red-text">${requestScope.ses.group.name}-${requestScope.ses.group.subject.name}</span></br>
            <b>Room</b>: <span class="red-text">${requestScope.ses.room.id}</span> </br>
            <b>Session no</b>: <span class="red-text">${requestScope.ses.index}</span>
            <form action="att" method="POST">
                <table class="attendance-table" border="1px">
                    <tr>
                        <th></th>
                        <th>Student ID</th>
                        <th>Name</th>
                        <th>Status</th>
                        <th>Description</th>
                        <th>Taking Time</th>
                        <th>Image</th>
                    </tr>
                    <c:forEach items="${requestScope.atts}" var="a" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>
                                HE${a.student.id}
                            </td>
                            <td>
                                ${a.student.name}
                                <input type="hidden" name="stuid" value="${a.student.id}"/>
                            </td>
                            <td>
                                <input type="radio"
                                       <c:if test="${!a.status}">
                                           checked="checked"
                                       </c:if>
                                       name="status${a.student.id}" value="absent" /> absent
                                <input type="radio"
                                       <c:if test="${a.status}">
                                           checked="checked"
                                       </c:if>
                                       name="status${a.student.id}" value="present" /> present
                            </td>
                            <td><input type="text" value="${a.description}" name="description${a.student.id}"/></td>
                            <td>${a.datetime}</td>
                            <td><img src="../img/default.jpg" alt="Cac" class="logo"/>
                            </td>
                        </tr>   
                    </c:forEach>

                </table>
                <div class="center">
                    <input type="hidden" value="${requestScope.ses.id}" name="sesid"/>
                    <input type="submit" value="Save"/>
                </div>
            </form>
        </div>
    </body>
</html>
