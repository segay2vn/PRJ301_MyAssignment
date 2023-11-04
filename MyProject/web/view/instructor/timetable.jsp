<%-- 
    Document   : timetable
    Created on : Oct 21, 2023, 10:41:23 PM
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
            footer {
                background-color: #333;
                color: white;
                text-align: center;
                padding: 10px 0;
                position: fixed;
                bottom: 0;
                width: 100%;
            }
            h1{
                text-align: center;
            }
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }

            .container {
                width: 80%;
                margin: 0 auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            form {
                margin-bottom: 20px;
            }

            input[type="date"] {
                padding: 10px;
                margin: 5px 0;
                width: calc(50% - 22px);
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


            table {
                width: 100%;
                border-collapse: collapse;
            }

            table, th, td {
                border: 1px solid #ddd;
            }

            th, td {
                padding: 12px;
                text-align: left;
            }

            th {
                background-color: #f2f2f2;
            }

            a {
                text-decoration: none;
                color: #007bff;
            }

            a:hover {
                text-decoration: underline;
            }
            .header-row {
                background-color: ghostwhite;
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
        <h1>Weekly timetable </h1>

        <table border="1px">
            <tr class="header-row">
                <td>
                    <form action="timetable" method="GET">
                        <input type="hidden" name="id" value="${param.id}"/>
                        <b>From</b> <input type="date" value="${requestScope.from}" name="from"/> </br>
                        <b>To</b> <input type="date" value="${requestScope.to}" name="to"/> 
                        <input type="submit" value="View"/>
                    </form>
                </td>
                <c:forEach items="${requestScope.dates}" var="d">
                    <td>
                        <i>${d}</i>
                    </td>
                </c:forEach>
            </tr>
            <c:forEach items="${requestScope.slots}" var="s" varStatus="loop">
                <tr>
                    <td>slot ${s.id}: ${s.description}</td>
                    <c:forEach items="${requestScope.dates}" var="d">
                        <td>
                            <c:forEach items="${requestScope.sessions}" var="k">
                                <c:if test="${k.date eq d and k.slot.id eq s.id}">
                                    <a href="att?id=${k.id}">
                                        ${k.group.name}-${k.group.subject.name}
                                    </a> </br>
                                    at ${k.room.id} </br>
                                    <c:if test="${k.isAtt}">
                                        (attended)
                                    </c:if>
                                    <c:if test="${!k.isAtt}">
                                        (not yet)
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </td>
                    </c:forEach>
                </tr>
            </c:forEach>

        </table>
        <footer>
            <div>
                FPT University - since 2006
            </div>
        </footer>
    </body>
</html>
