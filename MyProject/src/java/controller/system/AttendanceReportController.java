/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.system;

import dal.AttendanceReportDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.AttendanceReport;

/**
 *
 * @author pc
 */
public class AttendanceReportController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AttendanceReportController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AttendanceReportController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int iid = Integer.parseInt(request.getParameter("iid"));
        int subid = Integer.parseInt(request.getParameter("subid"));
        int gid = Integer.parseInt(request.getParameter("gid"));

        // Tạo một đối tượng AttendanceReportDBContext
        AttendanceReportDBContext dbContext = new AttendanceReportDBContext();

        // Gọi hàm generateAttendanceReport để lấy danh sách báo cáo
        ArrayList<AttendanceReport> attendanceReports = dbContext.generateAttendanceReport(iid, subid, gid);

        // Đặt danh sách báo cáo vào thuộc tính "attendanceReports" của yêu cầu để hiển thị trên trang JSP
        request.setAttribute("attendanceReports", attendanceReports);
        
        // Chuyển hướng đến trang JSP 
        request.getRequestDispatcher("../view/instructor/attReport.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        int attnum = Integer.parseInt(request.getParameter("attnum"));
//        int prenum = Integer.parseInt(request.getParameter("prenum"));
//        int totalnum = Integer.parseInt(request.getParameter("totalnum"));
//        float result = (((attnum-prenum)/totalnum)*100);
//        request.setAttribute("result", result);
//        request.getRequestDispatcher("../view/instructor/attReport.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
