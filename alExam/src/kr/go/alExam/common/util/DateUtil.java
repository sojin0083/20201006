package kr.go.alExam.common.util;

import java.text.ParsePosition;
//DecimalFormat,DateFormat 사용을 위해
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 날짜관련 utility class
 *
 * @author G.S.T
 * @version 1.0
 * @since 2002.05.02
 *
 * @see -
 */
 public class DateUtil {
    static SimpleDateFormat format = null;
    static SimpleDateFormat currentTimeDf = null;
    static SimpleDateFormat df = null;
    static SimpleDateFormat tf = null;
    static SimpleDateFormat sf = null;
    static SimpleDateFormat nf = null;

    static {
        try {
            format = new SimpleDateFormat("MM/dd/yyyy");
            currentTimeDf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            df = new SimpleDateFormat("yyyyMMddHH:mm:ss");
            tf = new SimpleDateFormat("yyyy.MM.dd");
            sf = new SimpleDateFormat("yyyyMMddHHmmss"); 
            nf = new SimpleDateFormat("yyyyMMdd"); 
        }
        catch(Exception ex) {ex.printStackTrace();}
    }

    /**
     * <pre>
     * Constructor
     * </pre>
     */
    public DateUtil() {
    }

    /**
     * <pre>
     * 현재시각을 리턴
     * 2000-06-22 13:04:45 형태로 표시
     * </pre>
     *
     * @return String
     */
    public String getCurrentTime()
    {
        return currentTimeDf.format(new Date());
    }

    /**
     * <pre>
     * 현재일을 2자리로 리턴
     * </pre>
     *
     * @return String
     */
    public String getDay()
    {
        Calendar cal = Calendar.getInstance();

        String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

        if(cal.get(Calendar.DAY_OF_MONTH) < 10) day = "0" + String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
        else day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

        return day;
    }

    /**
     * <pre>
     * 날짜가 유효한 날짜인지를 검사
     * "02/30/2000" 형태로 검사
     * </pre>
     *
     * @param date -
     *
     * @return boolean
     */
    public boolean isDate(String date)
    {
        format.setLenient(false);
        return format.parse(date,new ParsePosition(0)) == null ? false : true;
    }

    /**
     * <pre>
     * return days between two date strings with user defined format.
     * </pre>
     *
     * @param from -
     * @param to -
     * @param format -
     *
     * @return int 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 일자 리턴
     *         -999: 형식이 잘못 되었거나 존재하지 않는 날짜 또는 기간의 역전
     */
    public int getDaysBetween(String from, String to, String format)
    {
        java.text.SimpleDateFormat formatter =
        new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
        java.util.Date d1 = null;
        java.util.Date d2 = null;
        try {
            d1 = formatter.parse(from);
            d2 = formatter.parse(to);
        } catch(java.text.ParseException e) {
            return -999;
        }
        if ( !formatter.format(d1).equals(from) ) return -999;
        if ( !formatter.format(d2).equals(to) ) return -999;

        long duration = d2.getTime() - d1.getTime();

        if ( duration < 0 ) return -999;
        return (int)( duration/(1000 * 60 * 60 * 24) );
        // seconds in 1 day
    }

    /**
     * <pre>
     * 해당월의 일자수를 리턴
     * </pre>
     *
     * @param year -
     * @param month -
     *
     * @return int
     */
    public int getDayCount(int year, int month)
    {
        int day[] = {31,28,31,30,31,30,31,31,30,31,30,31};

        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
            day[1] = 29;
        }
        return day[month-1];
    }

    /**
     * <pre>
     * 현재월을 2자리로 리턴
     * </pre>
     *
     * @return String
     */
    public String getMonth()
    {
        Calendar cal = Calendar.getInstance();

        String month = String.valueOf(cal.get(Calendar.MONTH)+1);

        if((cal.get(Calendar.MONTH)+1) < 10) month = "0" + String.valueOf((cal.get(Calendar.MONTH)+1));
        else month = String.valueOf((cal.get(Calendar.MONTH)+1));

        return month;
    }

    /**
     * <pre>
     * 시스템 날짜를 리턴
     * 20000621182030형태로 리턴 (2000년6월21일 오후 6시 20분 30초)
     * </pre>
     *
     * @return String
     */
    static public String getSysDate()   
    {
  		return sf.format(new Date());
    }
   static public String getSysDatetf()
   {
     return tf.format(new Date());
    }
   static public String getSysDatenf()
   {
	   return nf.format(new Date());
   }
   
   
   /**
    * <pre>
    * 시스템 날짜에 +, - 값을 함
    * int num = +, - 할 날짜
    * 20000621182030형태로 리턴 (2000년6월21일 오후 6시 20분 30초)
    * </pre>
    *
    * @return String
    */
   public String getNextDate(int num)   
   {
       Calendar cal = Calendar.getInstance();
       cal.add(Calendar.DATE, num);
       
       String nextDate = ""+sf.format(cal.getTime());          
       return nextDate;
   }
   
   
   
   /**
    * <pre>
    * 시스템 시간에 +, - 값을 함
    * int num = +, - 할 날짜
    * 20000621182030형태로 리턴 (2000년6월21일 오후 6시 20분 30초)
    * </pre>
    *
    * @return String
    */
   public String getNextTime(int num)   
   {
       Calendar cal = Calendar.getInstance();
       cal.add(Calendar.HOUR, num);
       
       String nextDate = ""+sf.format(cal.getTime());          
       return nextDate;
   }   
   

    /**
     * <pre>
     * 요일에 대한 int를 리턴
     * 0=일요일,1=월요일,2=화요일,3=수요일,4=목요일,5=금요일,6=토요일
     * </pre>
     *
     * @param year -
     * @param month -
     * @param day -
     *
     * @return int
     */
    public int getWeekDay(int year,int month,int day)
    {
        Calendar cal = Calendar.getInstance();
        cal.set(year,month-1,day);

        return cal.get(Calendar.DAY_OF_WEEK) - 1;
    }
    
    /**
     * 해당 Date의 요일 구하기 
     * @param year
     * @param month
     * @param day
     * @return String
     */
    public String getWeekDayName(int year,int month,int day){
    	String[] arrStr = {"일","월","화","수","목","금","토"};
    	return arrStr[getWeekDay(year,month,day)];
    }

    /**
     * <pre>
     * 현재년도를 4자리로 리턴
     * </pre>
     *
     * @return String
     */
    public String getYear()
    {
        Calendar cal = Calendar.getInstance();

        return String.valueOf(cal.get(Calendar.YEAR));
    }

    public static void main(String[] args) {
     	DateUtil du = new DateUtil();
         boolean flag =  du.isDate("11/41/2000");
		 if(flag){
         	System.out.print("ok");
         }else{
         	System.out.print("no");
         }
     }
    
    //  2019.05.07 유준영 만나이 계산 추가
    /**
    * 만나이 계산
    * @param ssn : 생년월일 (예: "19990508" or "1999-05-08")
    * @return int 만나이
    */

    public int calculateManAge(String ssn){

    	ssn = ssn.replaceAll("-", ""); //'-' 제거
    	if(ssn.length() < 8){ //8자리 보다 작으면 
    	return 0;
    	}

    	String today = ""; //오늘 날짜
    	int manAge = 0; //만 나이

    	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");

    	today = formatter.format(new Date()); //시스템 날짜를 가져와서 yyyyMMdd 형태로 변환

    	//today yyyyMMdd
    	int todayYear = Integer.parseInt( today.substring(0, 4) );
    	int todayMonth = Integer.parseInt( today.substring(4, 6) );
    	int todayDay = Integer.parseInt( today.substring(6, 8) );

    	int ssnYear = Integer.parseInt( ssn.substring(0, 4) );
    	int ssnMonth = Integer.parseInt( ssn.substring(4, 6) );
    	int ssnDay = Integer.parseInt( ssn.substring(6, 8) );


    	manAge = todayYear - ssnYear;

    	if( todayMonth < ssnMonth ){ //생년월일 "월"이 지났는지 체크
    		manAge--;
    	}else if( todayMonth == ssnMonth ){ //생년월일 "일"이 지났는지 체크
	    	if( todayDay < ssnDay ){
	    		manAge--; //생일 안지났으면 (만나이 - 1)
	    	}
    	}

    	return manAge;
    }
    //  2019.05.07 유준영 만나이 계산 추가 끝


}
