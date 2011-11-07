package test.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class DateUtils {
	  public static final String DATE_FORMAT = "dd-MM HH:mm:ss";
	  public static final String FILENAME_FORMAT = "dd-MM HH.mm.ss";

	  public static String now(boolean fileName) {
	    Calendar cal = Calendar.getInstance();
	    SimpleDateFormat sdf = (fileName) ? 
	    		new SimpleDateFormat(FILENAME_FORMAT) :
	    		new SimpleDateFormat(DATE_FORMAT); 
	    return sdf.format(cal.getTime());
	  }
}
