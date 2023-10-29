package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AttendanceReport;
import model.Student;

public class AttendanceReportDBContext extends DBContext<AttendanceReport> {

    public ArrayList<AttendanceReport> generateAttendanceReport(int instructorId, int subjectId, int groupId) {
        ArrayList<AttendanceReport> attendanceReportList = new ArrayList<>();
        try {
            String sql = "WITH TotalSessions AS (\n"
                    + "    SELECT i.iid, COUNT(se.sesid) AS total_sessions\n"
                    + "    FROM Instructor i\n"
                    + "    LEFT JOIN [Group] g ON i.iid = g.sup_iis\n"
                    + "    LEFT JOIN Session se ON g.gid = se.gid\n"
                    + "    GROUP BY i.iid\n"
                    + ")\n"
                    + "SELECT s.stuid, s.stuname, \n"
                    + "       COUNT(CASE WHEN a.status = 1 THEN 1 ELSE NULL END) AS attendance_count, \n"
                    + "       MAX([index]) AS total_indexes,\n"
                    + "       ts.total_sessions AS total_sessions,\n"
                    + "	   i.iname AS instructor_name,\n"
                    + "       sub.subname AS subject_name,\n"
                    + "       g.gname AS group_name\n"
                    + "FROM Student s\n"
                    + "LEFT JOIN Attendance a ON s.stuid = a.stuid\n"
                    + "LEFT JOIN Session se ON a.sesid = se.sesid\n"
                    + "LEFT JOIN [Group] g ON se.gid = g.gid\n"
                    + "LEFT JOIN Instructor i ON g.sup_iis = i.iid\n"
                    + "LEFT JOIN Subject sub ON g.subid = sub.subid\n"
                    + "LEFT JOIN TotalSessions ts ON i.iid = ts.iid\n"
                    + "WHERE i.iid = ? AND sub.subid = ? AND g.gid = ?  \n"
                    + "GROUP BY s.stuid, s.stuname, ts.total_sessions, i.iname, sub.subname, g.gname ;";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, instructorId);
            stm.setInt(2, subjectId);
            stm.setInt(3, groupId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                //int studentId = rs.getInt("stuid");
                String studentName = rs.getString("stuname");
                String iname = rs.getString("instructor_name");
                String subname = rs.getString("subject_name");
                String groupname = rs.getString("group_name");
                int attendanceCount = rs.getInt("attendance_count");
                float indexNum = rs.getInt("total_indexes");
                int totalSession = rs.getInt("total_sessions");
                float resultPercent = Math.round((float) (((indexNum - attendanceCount) / totalSession) * 100));
                Student student = new Student();
                //student.setId(studentId);
                student.setName(studentName);
                AttendanceReport attendanceReport = new AttendanceReport(student, attendanceCount, Math.round(indexNum), totalSession, resultPercent, iname, subname, groupname);
                attendanceReportList.add(attendanceReport);
            }

        } catch (SQLException ex) {
            Logger.getLogger(AttendanceReportDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return attendanceReportList;
    }

    @Override
    public void insert(AttendanceReport model) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void update(AttendanceReport model) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void remove(AttendanceReport model) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public AttendanceReport get(AttendanceReport model) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public ArrayList<AttendanceReport> list() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

}
