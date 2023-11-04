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
            form {
                display: flex;
                flex-direction: column;
                align-items: center; /* Căn giữa theo chiều ngang */
                justify-content: center; /* Căn giữa theo chiều dọc */
                text-align: center; /* Căn giữa nội dung theo chiều ngang */
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

            label {
                margin-bottom: 10px;
                display: block;
                font-weight: bold;
            }

            select {
                width: 200px;
                padding: 5px;
                font-size: 16px;
                margin-bottom: 10px;
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
                position: relative;
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
            .red-text {
                color: red;
            }
            .absentee-rate {
                margin-top: 25px;
                margin-right: 20px;
                position: absolute;
                top: 0;
                right: 0;
                display: flex;
                align-items: center;
            }

            .icon {
                font-size: 24px;
                margin: 0 10px;
            }

            .red {
                color: red;
            }

            .yellowgreen {
                color: yellowgreen;
            }

            .black {
                color: black;
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
        <h1>Attendance Report</h1>
        <form action="attreport" method="post">
            <label for="group">Select Group:</label>
            <select name="groupId">
                <c:forEach items="${attReport}" var="t1">
                    <option value="${t1.group.id}">${t1.group.name}-${t1.group.subject.name}</option>
                </c:forEach>
            </select><br>
            <input type="submit" value="View Report">
        </form>
        <div class="container">
            <b>Group information</b>: <span class="red-text">${requestScope.attendanceReports[0].group.name}-${requestScope.attendanceReports[1].subject.name}</span>: <span class="red-text"><b>${requestScope.attendanceReports[2].totalSession}</b> sessions</span></br>
            <b>Instructor</b>: <span class="red-text">${requestScope.attendanceReports[3].instructor.name}</span></br>
            <b>From</b>: <span class="red-text">${requestScope.attendanceReports1[0].firstDate}</span>  <b>To</b>: <span class="red-text">${requestScope.attendanceReports1[0].lastDate}</span></br>
            <div class="absentee-rate">
                <b>Absentee rate</b>:
                <span class="icon red">●</span><i>>20%</i>
                <span class="icon yellowgreen">●</span><i>20%</i>
                <span class="icon black">●</span><i><20%</i>
            </div>
            <table class="attendance-table" border="1">
                <thead>
                    <tr>
                        <th></th>
                        <th>Student ID</th>
                        <th>Name</th>
                        <th>Total attended sessions</th>
                        <th>Total present sessions</th>
                        <th>Specific present sessions</th>
                        <th>Total absent sessions</th>
                        <th>Specific absent sessions</th>
                        <th>Absentee rate (%)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requestScope.attendanceReports}" var="attendanceReport" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td> 
                            <td><b>HE${attendanceReport.studentName.id}</b></td>
                            <td>${attendanceReport.studentName.name}</td>
                            <td>${attendanceReport.indexNum} / <b>${attendanceReport.totalSession}</b></td>
                            <td><b>${attendanceReport.attendanceCount}</b></td>
                            <td><i>${attendanceReport.presentSession}</i></td>
                            <td><b>${attendanceReport.absentCount}</b></td>
                            <td><i>${attendanceReport.absentSession}</i></td>
                            <c:choose>
                                <c:when test="${attendanceReport.resultPercent > 20}">
                                    <td style="color: red;"><b>${attendanceReport.resultPercent}</b></td>
                                        </c:when>
                                        <c:when test="${attendanceReport.resultPercent == 20}">
                                    <td style="color: yellowgreen;"><b>${attendanceReport.resultPercent}</b></td>
                                        </c:when>
                                        <c:otherwise>
                                    <td><b>${attendanceReport.resultPercent}</b></td>
                                </c:otherwise>
                            </c:choose>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
