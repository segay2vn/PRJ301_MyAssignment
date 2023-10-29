<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Attendance Report</title>
        <style>
            header {
                background-color: rgb(226, 162, 42);
                color: white;
                padding: 10px 0;
                text-align: center;
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
            .red-text {
                color: red;
            }
        </style>
    </head>
    <body>
        <header>
            <h1>FPT University Academic Portal</h1>
            <nav>
                <ul>
                    <li><a href="http://localhost:9999/MyProject/view/home.jsp">Home</a></li>
                    <li><a href="http://localhost:9999/MyProject/instructor/timetable?id=1">Weekly Timetable</a></li>
                    <li><a href="http://localhost:9999/MyProject/instructor/attreport?iid=1&subid=1&gid=1">Attendance report</a></li>
                    <li><a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ">Help</a></li>
                </ul>
            </nav>
        </header>
        <h1>Attendance Report</h1>
        <div class="container">
            Group information: <span class="red-text" ></span>
            <table class="attendance-table" border="1">
                <thead>
                    <tr>
                        <th>Student Name</th>
                        <th>Number of present sessions</th>
                        <th>Number of sessions attended</th>
                        <th>Absentee rate (%)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requestScope.attendanceReports}" var="attendanceReport">
                        <tr>
                            <td>${attendanceReport.studentName.name}</td>
                            <td>${attendanceReport.attendanceCount}</td>
                            <td>${attendanceReport.indexNum}/${attendanceReport.totalSession}</td>
                            <c:choose>
                                <c:when test="${attendanceReport.resultPercent > 20}">
                                    <td style="color: red;">${attendanceReport.resultPercent}</td>
                                </c:when>
                                <c:when test="${attendanceReport.resultPercent == 20}">
                                    <td style="color: yellowgreen;">${attendanceReport.resultPercent}</td>
                                </c:when>
                                <c:otherwise>
                                    <td>${attendanceReport.resultPercent}</td>
                                </c:otherwise>
                            </c:choose>
 
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
