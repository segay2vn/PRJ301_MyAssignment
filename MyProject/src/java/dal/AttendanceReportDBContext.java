package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AttendanceReport;
import model.Group;
import model.Instructor;
import model.Student;
import model.Subject;

public class AttendanceReportDBContext extends DBContext<AttendanceReport> {

    public ArrayList<AttendanceReport> generateAttendanceReport(int groupId) {
        ArrayList<AttendanceReport> attendanceReportList = new ArrayList<>();
        try {
            String sql = "WITH TotalSessions AS (\n"
                    + "                        SELECT i.iid, g.gid, COUNT(CASE WHEN se.isAtt = 1 THEN 1 ELSE NULL END) AS total_indexes, COUNT(se.sesid) AS total_sessions\n"
                    + "                        FROM Instructor i\n"
                    + "                        LEFT JOIN [Group] g ON i.iid = g.sup_iis\n"
                    + "                        LEFT JOIN Session se ON g.gid = se.gid\n"
                    + "                       GROUP BY i.iid, g.gid\n"
                    + "                    )\n"
                    + "                   \n"
                    + "                    SELECT s.stuid, s.stuname, \n"
                    + "                       COUNT(CASE WHEN a.status = 1 THEN 1 ELSE NULL END) AS attendance_count, \n"
                    + "                        ts.total_indexes AS total_indexes,\n"
                    + "                       ts.total_sessions AS total_sessions,\n"
                    + "                        i.iname AS instructor_name,\n"
                    + "                       sub.subname AS subject_name,\n"
                    + "                       g.gname AS group_name,\n"
                    + "                        -- Lấy danh sách các buổi học mà sinh viên vắng mặt\\n\"\n"
                    + "                       STRING_AGG(CASE WHEN a.status = 0 THEN CONVERT(VARCHAR(10), se.[index]) ELSE NULL END, ', ') WITHIN GROUP (ORDER BY se.[index]) AS absent_sessions,\n"
                    + "			      STRING_AGG(CASE WHEN a.status = 1 THEN CONVERT(VARCHAR(10), se.[index]) ELSE NULL END, ', ') WITHIN GROUP (ORDER BY se.[index]) AS present_sessions\n"
                    + "                    FROM Student s\n"
                    + "                    LEFT JOIN Attendance a ON s.stuid = a.stuid\n"
                    + "                    LEFT JOIN Session se ON a.sesid = se.sesid\n"
                    + "                    LEFT JOIN [Group] g ON se.gid = g.gid\n"
                    + "                    LEFT JOIN Instructor i ON g.sup_iis = i.iid\n"
                    + "                    LEFT JOIN Subject sub ON g.subid = sub.subid\n"
                    + "                    LEFT JOIN TotalSessions ts ON i.iid = ts.iid AND g.gid = ts.gid\n"
                    + "                    WHERE g.gid = ?\n"
                    + "                    GROUP BY s.stuid, s.stuname, ts.total_indexes, ts.total_sessions, i.iname, sub.subname, g.gname;";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, groupId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int studentId = rs.getInt("stuid");
                String studentName = rs.getString("stuname");
                String absentSession = rs.getString("absent_sessions");
                String presentSession = rs.getString("present_sessions");
                String subname = rs.getString("subject_name");
                String groupname = rs.getString("group_name");
                int attendanceCount = rs.getInt("attendance_count");
                float indexNum = rs.getInt("total_indexes");
                int totalSession = rs.getInt("total_sessions");
                float resultPercent = Math.round((float) (((indexNum - attendanceCount) / totalSession) * 100));
                int absentCount = (int) indexNum - attendanceCount;
                Student student = new Student();
                Group group = new Group();
                group.setName(groupname);
                Subject subject = new Subject();
                subject.setName(subname);
                student.setName(studentName);
                student.setId(studentId);
                Instructor instructor = new Instructor();
                instructor.setName(rs.getString("instructor_name"));
                AttendanceReport attendanceReport = new AttendanceReport(student, attendanceCount, absentCount, indexNum, totalSession, resultPercent, absentSession, presentSession, group, subject, instructor);
                attendanceReportList.add(attendanceReport);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AttendanceReportDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return attendanceReportList;
    }

    public ArrayList<AttendanceReport> getAttendanceReport(int id) {
        ArrayList<AttendanceReport> attendanceReportList1 = new ArrayList<>();
        try {
            String sql = "SELECT DISTINCT\n"
                    + "    sub.subid,\n"
                    + "    sub.subname,\n"
                    + "    g.gid,\n"
                    + "    g.gname\n"
                    + "FROM \n"
                    + "    [Session] ses \n"
                    + "INNER JOIN \n"
                    + "    [Group] g ON ses.gid = g.gid\n"
                    + "INNER JOIN \n"
                    + "    [Subject] sub ON g.subid = sub.subid\n"
                    + "INNER JOIN \n"
                    + "    Room r ON r.roomid = ses.rid\n"
                    + "INNER JOIN \n"
                    + "    TimeSlot t ON ses.tid = t.tid\n"
                    + "WHERE \n"
                    + "    ses.iid = ?;";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Group g = new Group();
                g.setId(rs.getInt("gid"));
                g.setName(rs.getString("gname"));
                Subject sub = new Subject();
                sub.setId(rs.getInt("subid"));
                sub.setName(rs.getString("subname"));
                g.setSubject(sub);
                AttendanceReport attendanceReport = new AttendanceReport(g);
                attendanceReportList1.add(attendanceReport);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SessionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return attendanceReportList1;
    }

    public ArrayList<AttendanceReport> getDateTime(int gid) {
        ArrayList<AttendanceReport> attendanceReportList2 = new ArrayList<>();
        try {
            String sql = "SELECT MIN(se.[date]) AS firstSessionDatetime, MAX(se.[date]) AS lastSessionDatetime\n"
                    + "FROM [Session] se\n"
                    + "INNER JOIN [Group] g ON se.gid = g.gid\n"
                    + "WHERE g.gid = ?\n"
                    + "GROUP BY g.gid;";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, gid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String firstDate = rs.getString("firstSessionDatetime");
                String lastDate = rs.getString("lastSessionDatetime");
                AttendanceReport attendanceReport = new AttendanceReport(firstDate, lastDate);
                attendanceReportList2.add(attendanceReport);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SessionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return attendanceReportList2;
    }

    @Override
    public void insert(AttendanceReport model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(AttendanceReport model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void remove(AttendanceReport model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public AttendanceReport get(AttendanceReport model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<AttendanceReport> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
