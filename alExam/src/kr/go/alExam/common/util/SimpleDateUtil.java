package kr.go.alExam.common.util;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;
/**
 * String 관련 date class
 *
 * @author G.S.T
 * @version 1.0
 * @since 2002.12
 *
 * @see -
 */
public class SimpleDateUtil {

  private static SimpleDateFormat msdf = new SimpleDateFormat();
  public final static String DATEFORMAT[] = {"yyyy-MM-dd HH:mm:ss",//0
                                              "yyyyMMddHH:mm:ss", //1
                                              "yyyy.MM.dd", //2
                                              "yyyy/MM/dd", //3
                                              "yyyy-MM-dd", //4
                                              "MM/dd/yyyy", //5
                                              "yyyyMMdd"}; //6


  private String msday ;
  private Date mdate;
 /**
  *<pre>
  *  생성자로써 날짜 형식의 스트링을 입력 받아서 초기화 한다.
  * </pre>
  */
  public SimpleDateUtil(String sday) {
    this.msday = sday;
  }
  /**
   * 입력 받은 값이 날짜 형식을 가지는지 검사 하여 boolean 타입으로 return 한다.
   */
  public boolean isDate(){
    boolean flag = false;
    int num = 0;
    Date d = null;
    msdf.setLenient(false);

    for(int i = 0 ; i < DATEFORMAT.length ; i++){
      msdf.applyPattern(DATEFORMAT[i]);
      d = msdf.parse(msday,new ParsePosition(0));
      if( d != null ){
        mdate = d;
        ++num;
      }
    }
    if(num >0) flag = true;
    return flag ;
  }
 /**
  *<pre>
  *  입력 받은 값을 원하는 포멧으로 변경 후 return 한다.
  *  입력한 값이 날짜 형식이지 불분명 하면 isDate()를 호출 후 true 면 실행한다.
  * </pre>
  */
  public String convertFormat(int formatNO){

    String str = "";
    if(isDate()) {
      msdf.applyPattern(DATEFORMAT[formatNO]);
      str =  msdf.format(mdate);
    }
    return str;
  }
  /**
   *<pre>
   * 시스템 날짜를 가져온다
   * 기본 포멧 "yyyy.MM.dd" 형식으로 가져온다.
   * </pre>
   */
  public static String getSysDate(){
    msdf.applyPattern(DATEFORMAT[2]);
    return msdf.format(new Date());
  }
  /**
   *<pre>
   * 시스템 날짜를 원하는 포멧으로 가져온다.
   * 포멧 지정은 int 형으로
   * "yyyy-MM-dd HH:mm:ss",//0
   * "yyyyMMddHH:mm:ss", //1
   * "yyyy.MM.dd", //2
   * "yyyy/MM/dd", //3
   * "yyyy-MM-dd", //4
   * "MM/dd/yyyy" //5
   *
   * </pre>
   */
  public static String getSysDate(int formatNO){
    msdf.applyPattern(DATEFORMAT[formatNO]);
    return msdf.format(new Date());
  }
  /**
   *<pre>
   * 시스템 날짜를 원하는 포멧으로 가져온다.
   * 포멧 지정은 String 형으로
   * "yyyy-MM-dd HH:mm:ss" 형식으로 한다.
   *
   * </pre>
   */
  public static String getSysDate(String format){
    try{
      msdf.applyPattern(format);
    }catch(Exception e){
      msdf.applyPattern(DATEFORMAT[0]);
    }
    return msdf.format(new Date());
  }
/*
  //Test Main method
  public static void main(String[] args) {
    //System.out.println(SimpleDateUtil.DATEFORMAT.toString());
    for(int i=0 ; i < SimpleDateUtil.DATEFORMAT.length ; i++){
      System.out.println(SimpleDateUtil.getSysDate(i));
    }
    System.out.println(SimpleDateUtil.getSysDate());
    System.out.println(SimpleDateUtil.getSysDate(5));
    System.out.println(SimpleDateUtil.getSysDate("yyyy년MM월dd일"));
    System.out.println(SimpleDateUtil.getSysDate("EEEE MMM dd a hh:mm:ss z yyyy"));


    SimpleDateUtil sut = new SimpleDateUtil("2000-11-11");
    System.out.println( sut.convertFormat(3));
    Date d = new Date( System.currentTimeMillis());

    System.out.println(d.toString() + "::" + new Date().toString());
  }
*/
}
