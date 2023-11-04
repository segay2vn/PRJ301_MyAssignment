/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.system;

import controller.BasedRequiredAuthenticationController;
import dal.AttendanceReportDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.AttendanceReport;
import model.User;

/**
 *
 * @author pc
 */
public class AttendanceReportController extends BasedRequiredAuthenticationController {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        AttendanceReportDBContext dbContext = new AttendanceReportDBContext();
        HttpSession session = request.getSession();
        int id = (int) session.getAttribute("uid");
        ArrayList<AttendanceReport> attReport = dbContext.getAttendanceReport(id);
        request.setAttribute("attReport", attReport);
        request.getRequestDispatcher("../view/instructor/attReport.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        int gid = Integer.parseInt(request.getParameter("groupId"));

        AttendanceReportDBContext dbContext = new AttendanceReportDBContext();

        ArrayList<AttendanceReport> attendanceReports = dbContext.generateAttendanceReport(gid);
        ArrayList<AttendanceReport> attendanceReports1 = dbContext.getDateTime(gid);

        request.setAttribute("attendanceReports", attendanceReports);
        request.setAttribute("attendanceReports1", attendanceReports1);

        request.getRequestDispatcher("../view/instructor/attReport.jsp").forward(request, response);
    }

}
