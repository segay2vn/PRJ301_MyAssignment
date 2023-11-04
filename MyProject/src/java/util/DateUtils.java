/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 *
 * @author pc
 */
public class DateUtils {
        public static List<Date> getDatesOfCurrentWeek() {
        List<Date> dates = new ArrayList<>();
        Calendar cal = Calendar.getInstance();  // gets the current date and time
        
        // Set the calendar to the start of today
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);

        // Determine the offset from the first day of the week (in this case, we consider Monday as the first day)
        int offset = cal.get(Calendar.DAY_OF_WEEK) - Calendar.MONDAY;
        // If it's negative, we are in a week which is 'split' by the month end (e.g., Sunday is in the new month)
        if (offset < 0) {
            offset += 7;
        }

        // Rewind the calendar to last Monday. It's the start of the week
        cal.add(Calendar.DATE, -offset);

        // Loop to construct the list of dates
        for (int i = 0; i < 7; i++) {  // 7 days in a week
            Date sqlDate = new Date(cal.getTimeInMillis()); // convert to java.sql.Date
            dates.add(sqlDate);
            cal.add(Calendar.DATE, 1);  // move to the next day
        }

        return dates;
    }
        public static List<Date> getSQLDatesBetween(String start, String end) throws ParseException {
        List<Date> dates = new ArrayList<>();

        // Define a simple date format, e.g., "2023-01-01"
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        // Parse the start and end dates
        java.util.Date parsedStartDate = dateFormat.parse(start);
        java.util.Date parsedEndDate = dateFormat.parse(end);

        // Set the calendar to start date
        Calendar cal = Calendar.getInstance();
        cal.setTime(parsedStartDate);

        // Loop through the dates and add them to the list
        while (!cal.getTime().after(parsedEndDate)) {
            dates.add(new Date(cal.getTime().getTime())); // Add the SQL date to the list
            cal.add(Calendar.DATE, 1); // Go to the next day
        }

        return dates;
    }
        
}
