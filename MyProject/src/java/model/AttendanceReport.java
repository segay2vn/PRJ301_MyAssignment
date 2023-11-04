/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class AttendanceReport implements IBaseModel {

    private Student studentName;
    private Group group;
    private Subject subject;
    private Instructor instructor;

    private String firstDate;
    private String lastDate;
    private int attendanceCount;
    private float indexNum;
    private int totalSession;
    private int absentCount;
    private String absentSession;
    private String presentSession;

    public Instructor getInstructor() {
        return instructor;
    }

    public void setInstructor(Instructor instructor) {
        this.instructor = instructor;
    }

    public AttendanceReport(String firstDate, String lastDate) {
        this.firstDate = firstDate;
        this.lastDate = lastDate;
    }

    public String getFirstDate() {
        return firstDate;
    }

    public void setFirstDate(String firstDate) {
        this.firstDate = firstDate;
    }

    public String getLastDate() {
        return lastDate;
    }

    public void setLastDate(String lastDate) {
        this.lastDate = lastDate;
    }

    public AttendanceReport(Group group) {
        this.group = group;
    }

    public AttendanceReport(Subject subject) {
        this.subject = subject;
    }

    public Group getGroup() {
        return group;
    }

    public void setGroup(Group group) {
        this.group = group;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public String getPresentSession() {
        return presentSession;
    }

    public void setPresentSession(String presentSession) {
        this.presentSession = presentSession;
    }

    public float getResultPercent() {
        return resultPercent;
    }

    public void setResultPercent(float resultPercent) {
        this.resultPercent = resultPercent;
    }
    private float resultPercent;

    public String getAbsentSession() {
        return absentSession;
    }

    public void setAbsentSession(String absentSession) {
        this.absentSession = absentSession;
    }

    public int getTotalSession() {
        return totalSession;
    }

    public void setTotalSession(int totalSession) {
        this.totalSession = totalSession;
    }

    public float getIndexNum() {
        return indexNum;
    }

    public void setIndexNum(float indexNum) {
        this.indexNum = indexNum;
    }

    public AttendanceReport(Student studentName, int attendanceCount, int absentCount, float indexNum, int totalSession, float resultPercent, String absentSession, String presentSession, Group group, Subject subject, Instructor instructor ) {
        this.studentName = studentName;
        this.attendanceCount = attendanceCount;
        this.absentCount = absentCount;
        this.indexNum = indexNum;
        this.totalSession = totalSession;
        this.resultPercent = resultPercent;
        this.absentSession = absentSession;
        this.group = group;
        this.subject = subject;
        this.presentSession = presentSession;
        this.instructor = instructor;
    }

    public int getAbsentCount() {
        return absentCount;
    }

    public void setAbsentCount(int absentCount) {
        this.absentCount = absentCount;
    }

    public Student getStudentName() {
        return studentName;
    }

    public void setStudentName(Student studentName) {
        this.studentName = studentName;
    }

    public int getAttendanceCount() {
        return attendanceCount;
    }

    public void setAttendanceCount(int attendanceCount) {
        this.attendanceCount = attendanceCount;
    }
}
