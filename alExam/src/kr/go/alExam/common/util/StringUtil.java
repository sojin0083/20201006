package kr.go.alExam.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Clob;
import java.sql.SQLException;
//DecimalFormat,DateFormat 사용을 위해
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.Vector;

/**
 * String 관련 utility class
 *
 * @author G.S.T
 * @version 1.0
 * @since 2002.05.02
 *
 * @see -
 */
public class StringUtil {

    /**
     * <pre>
     * Constructor
     * </pre>
     */
    public StringUtil() {
    }

    /**
     * <pre>
     * java.util.Locale에 해당 하는 문자로 encoding
     * </pre>
     *
     * @param locale -
     * @param text -
     *
     * @return String
     */
    public String getLocaleString(java.util.Locale locale,String text)
    {
        throw new java.lang.UnsupportedOperationException("Method getLocaleString not yet implemented.");
    }

    /**
     * <pre>
     * java.util.Locale의 default locale에 해당 하는 문자로 encoding
     * </pre>
     *
     * @param text -
     *
     * @return String
     *
     * @exception Exception
     */
    public String getLocaleString(String text) throws Exception
    {
        return getLocaleString(null,text);
    }

    /**
     * <pre>
     * java.util.Locale에 해당 하는 charset 문자를 8859_1 encoding
     * </pre>
     *
     * @param locale -
     * @param text -
     *
     * @return String
     */
    public String getISO8859_1String(java.util.Locale locale,String text)
    {
        throw new java.lang.UnsupportedOperationException("Method getISO8859_1String not yet implemented.");
    }

    /**
     * <pre>
     * java.util.Locale의 default locale에 해당 하는 charset 문자를 8859_1 encoding
     * </pre>
     *
     * @param text -
     *
     * @return String
     *
     * @exception Exception
     */
    public String getISO8859_1String(String text) throws Exception
    {
        return getLocaleString(null,text);
    }

    /**
     * <pre>
     * String EUC_KR로 encoding
     * </pre>
     *
     * @param text -
     *
     * @return String
     */
    public static String getEUC_KR(String text)
    {
        String rtn;

        rtn = "";

        if (text == null)
            return rtn;
        else {
            try {
                return new String(text.getBytes("8859_1"),"euc-kr");
            }
            catch (UnsupportedEncodingException UEE)
            {
                return rtn;
            }
        }
    }

    /**
     * <pre>
     * String 8859_1(Unicode)로 encoding
     * </pre>
     *
     * @param text -
     *
     * @return String
     */
    public String get8859_1(String text)
    {
        String rtn;

        rtn = "";

        if (text == null)
            return rtn;
        else {
            try {
                return new String(text.getBytes("euc-kr"),"8859_1");
            }
            catch (UnsupportedEncodingException UEE)
            {
                return rtn;
            }
        }
    }

    /**
     * <pre>
     * String을 encoding
     * </pre>
     *
     * @param text -
     * @param fromEncode -
     * @param toEncode -
     *
     * @return String
     */
    public static String getConvertCharset(String text, String fromEncode, String toEncode)
    {
        String rtn;

        rtn = "";

        if (text == null)
            return rtn;
        else {
            try {
                return new String(text.getBytes(fromEncode),toEncode);
            }
            catch (UnsupportedEncodingException UEE)
            {
                return rtn;
            }
        }
    }

    /**
     * <pre>
     * str에서 rep에 해당하는 String을 tok로 replace
     * </pre>
     *
     * @param str -
     * @param rep -
     * @param tok -
     *
     * @return String
     */
    public String getReplace(String str, String rep, String tok)
    {
        String retStr = "";

        if (str==null||"".equals(str)) return "";

        for(int i = 0, j = 0; (j = str.indexOf(rep,i)) > -1 ; i = j+rep.length()) {
            retStr += (str.substring(i,j) + tok);
        }
        return (str.indexOf(rep) == -1) ? str : retStr + str.substring(str.lastIndexOf(rep)+rep.length(),str.length());
    }

    public String getReplace(String str, int index, String tok){
      String reStr = "";
      if (str==null||"".equals(str)) return "";
      if (tok==null||"".equals(tok)) return str;

       reStr = str.substring(0,index) + tok + str.substring(index+tok.length(),str.length());
      return reStr ;
    }

    /**
     * <pre>
     * HTML과 관련하여 일부 특수문자를 반환
     * & --->> &amp;
     * < --->> &lt;
     * > --->> &gt;
     * ' --->> &acute;
     * " --->> &quot;
     * | --->> &brvbar;
     * </pre>
     * html 을 tag 적용 없이 text 로 적용 시킬때
     * @param str -
     *
     * @return String
     */
    public String getSpecialCharacters(String str)
    {
        str = getReplace(str, "&", "&amp;");
        str = getReplace(str, "<", "&lt;");
        str = getReplace(str, ">", "&gt;");
        str = getReplace(str, "'", "&acute;");
        str = getReplace(str, "\"", "&quot;");
        str = getReplace(str, "|", "&brvbar;");
        //str = getReplace(str, " ", "&nbsp;");

        str = getReplace(str, "\n", "<BR>");
        str = getReplace(str, "\r", "");

        return str;
    }

    public String getSpecialCharactersSpaceInc(String str){
    str = getReplace(str, "&", "&amp;");
    str = getReplace(str, "<", "&lt;");
    str = getReplace(str, ">", "&gt;");
    str = getReplace(str, "'", "&acute;");
    str = getReplace(str, "\"", "&quot;");
    str = getReplace(str, "|", "&brvbar;");
    str = getReplace(str, " ", "&nbsp;");

    str = getReplace(str, "\n", "<BR>");
    str = getReplace(str, "\r", "");

    return str;
    }
    
    /**
     * <pre>
     * \n --->> <BR>
     * \r --->> ""
     * "" --->>  &nbsp;
     * </pre>
     * @param str
     * @return
     */
    public String getSpecialCharactersBaseInc(String str){ 
    	
    	str = getReplace(str, " ", "&nbsp;");
        str = getReplace(str, "\n", "<BR>");
        str = getReplace(str, "\r", "");

        return str;
    } 



    public String getSingleToDB(String str){
    	str = getReplace(str, "'", "''");
      return str;
    }
    
    public String getFileStrChk(String str){ 
    	
    	str = getReplace(str, "..", "");
        str = getReplace(str, "/", "");
        str = getReplace(str, "\\", "");
        str = getReplace(str, "&", "");
        str = getReplace(str, "=", "");

        return str;
    }

    /**
     * <pre>
     * HTML과 관련하여 일부 특수문자를 변환
     * &amp;    --->> &
     * &lt;     --->> <
     * &gt;     --->> >
     * &acute;  --->> '
     * &quot;   --->> "
     * &brvbar; --->> |
     * </pre>
     * html tag 적용하여 html 형식으로 적용 시킬때
     * @param str -
     *
     * @return String
     */
    public String getRreplaceSpecialCharacters(String str)
    {
        str = getReplace(str, "<BR>", "\n");

        str = getReplace(str, "&amp;", "&");
        str = getReplace(str, "&lt;", "<");
        str = getReplace(str, "&gt;", ">");
        str = getReplace(str, "&acute;", "'");
        str = getReplace(str, "&quot;", "\"");
        str = getReplace(str, "&brvbar;", "|");
//        20140703 추가 
        str = getReplace(str, "&apos;", "'");

        str = getReplace(str, "&nbsp;", " ");

        return str;
    }

    /**
     * <pre>
     * String에 comma를 삽입
     * </pre>
     *
     * @param str -
     *
     * @return String
     */
    public String getComma(String str)
    {
        return getComma(str,true);
    }

    /**
     * <pre>
     * String에 comma를 삽입
     * isTruncated가 false이면 소수점 이하를 자르지 않는다.
     * </pre>
     *
     * @param str -
     * @param isTruncated -
     *
     * @return String
     */
    public String getComma(String str, boolean isTruncated)
    {
        DecimalFormat commaFormat; // comma 삽입을 위한 변수

        if (str==null)
            return "";
        else if (str.trim().equals(""))
            return "";
        else if (str.trim().equals("&nbsp;"))
            return "&nbsp;";
        else {
            //str에 .이 있으면 Float으로 처리한다.
            int pos = str.indexOf(".");
            if (pos!=-1) {
                if (!isTruncated) {
                    commaFormat = new DecimalFormat("#,##0.00");
                    return commaFormat.format(Float.parseFloat(str.trim()));
                }
                else {
                    commaFormat = new DecimalFormat("#,##0");
                    return commaFormat.format(Long.parseLong(str.trim().substring(0,pos)));
                }
            }
            else {
                commaFormat = new DecimalFormat("#,##0");
                return commaFormat.format(Long.parseLong(str.trim()));
            }
        }
    }

    /**
     * <pre>
     * Long값에 comma를 삽입한 String을 리턴
     * </pre>
     *
     * @param lstr -
     *
     * @return String
     */
    public String getComma(Long lstr)
    {
        DecimalFormat commaFormat; // comma 삽입을 위한 변수
        commaFormat = new DecimalFormat("#,##0");

        if (lstr==null) return "";
        else return commaFormat.format(lstr);
    }

    /**
     * <pre>
     * text를 format에 맞추어 출력
     * getFormatedText("0193372412","???-???-????") --->> 019-337-2412로 출력
     * </pre>
     *
     * @param text -
     * @param format -
     *
     * @return String
     */
    public String getFormatedText(String text,String format)
    {
        String rtn;
        int start,i,j,len;
        int tCount,fCount;

        tCount = text.length();
        fCount = format.length();

        rtn = "";

        if (text.equals("")) return rtn;
        if (text.equals("&nbsp;")) return "&nbsp;";
        // text가 01252412 이고 format 이 ????-???? 이면 0125-2412로 출력
        //text에서 -를 제거한다.
        for (i=0; i<tCount; ++i) {
            if (!text.substring(i,i+1).equals("-"))
                rtn = rtn + text.substring(i,i+1);
        }

        text = rtn;
        tCount = text.length();

        //포멧에서 ?의  count
        len = 0;
        for (j=0; j<fCount; ++j) {
            if (format.substring(j,j+1).equals("?")) ++len;
        }
        //text의 길이가 len보다 작으면 앞에 0를 붙인다.
        if (tCount<len) {
            for (i=0; i<(len-tCount); ++i) {
                text = '0' + text;
            }
            tCount = len;
        }

        rtn = "";
        start = 0;
        for (i=0; i<tCount; ++i) {
            for (j=start; j<fCount; ++j) {
                if (format.substring(j,j+1).equals("?")) {
                    rtn = rtn + text.substring(i,i+1);
                    start = start + 1;
                    break;
                }
                else {
                    rtn = rtn + format.substring(j,j+1);
                    start = start + 1;
                }
            }
        }
        return rtn+format.substring(start);
    }

    /**
     * <pre>
     * format형태의 String에서 문자만을 추출하여 리턴
     * getFormatedText("019-337-2412","???-???-????") --->> 0193372412로 출력
     * </pre>
     *
     * @param text -
     * @param format -
     *
     * @return String
     */
    public String getRawText(String text,String format)
    {
        int start,i,j,tCount,fCount;
        String rtn;

        tCount = text.length();
        fCount = format.length();

        rtn = "";
        if (text.equals("")) return rtn;
        if (text.equals("&nbsp;")) return "&nbsp;";
        // test가 0125-2412 이고 format 이 ????-???? 이면 01252412로 출력

        start = 0;
        for (i=0; i<tCount; ++i) {
            for (j=start; j<fCount; ++j) {
                if (format.substring(j,j+1).equals("?")) {
                    rtn = rtn + text.substring(i,i+1);
                    start = start + 1;
                    break;
                }
                else {
                    start = start + 1;
                    break;
                }
            }
        }
        return rtn;
    }

    /**
     * <pre>
     * null String을 "" String으로 변환
     * </pre>
     *
     * @param text -
     *
     * @return String
     */
    public String getNullToEmpty(String text)
    {
        return getNullToEmpty(text,true);
    }

    /**
     * <pre>
     * null String을 "" String으로 변환
     * isNull이 false이면 "null"이란 String은 ""으로 변환하지 않는다.
     * </pre>
     *
     * @param text -
     * @param isNull -
     *
     * @return String
     */
    public String getNullToEmpty(String text,boolean isNull)
    {
        String rtn;

        rtn = "";
        if (text == null)
            return rtn;
        else if (isNull&&text.toLowerCase().equals("null"))
            return rtn;
        else
            return text;
    }

    /**
     * <pre>
     * 문자열에서 숫자만을 리턴
     * </pre>
     *
     * @param str -
     *
     * @return String
     */
    public String getNumericString(String str)
    {
        String rtn = "";
        int itmp = 0;

        if (str==null) {
            rtn = "";
        }
        else {
            for (int i=0; i<str.length(); ++i) {
                try {
                    itmp = Integer.parseInt(str.substring(i,i+1));
                    rtn += str.substring(i,i+1);
                }
                catch(Exception ignore) {}
            }
        }
        return rtn;
    }
    /**
     * <pre>
     * 주어진 size내에서 0으로 채워진 String을 리턴
     * </pre>
     *
     * @param num -
     * @param size -
     *
     * @return String
     */
    public String getZeroBaseString(int num,int size)
    {
        return getZeroBaseString(String.valueOf(num),size);
    }

    /**
     * <pre>
     * 주어진 size내에서 0으로 채워진 String을 리턴
     * </pre>
     *
     * @param num -
     * @param size -
     *
     * @return String
     */
    public String getZeroBaseString(String num,int size)
    {
        String zeroBase = "";

        if (num.length() >= size)
            return num;

        for(int index=0; index<(size-num.length()); ++index) {
            zeroBase += "0";
        }

        return zeroBase+num;
    }

    /**
     * <pre>
     * 주어진 splitSize를 기준으로 장문의 문장을 쪼개서 Vector에 담아 리턴
     * </pre>
     *
     * @param content -
     * @param splitSize -
     *
     * @return String[]
     */
    public String[] splitString(String content,int splitSize)
    {
        Vector vt = new Vector(10,10);
        String ctmp = content;
        int cntlen = 0;
        int csize=3999;
        int strlen , bylen;
        char c;

        if (content!=null) {
            ctmp = content;
            cntlen = content.getBytes().length;
        }
        else {
            ctmp = " ";
            cntlen = 1;
        }

        if (splitSize>0)
            csize = splitSize - 1;
        else
            csize = 3999;

        while(cntlen>0) {
            strlen = bylen =0;
            if (cntlen>csize) {
                while(bylen < csize) {
                    c = ctmp.charAt(strlen);
                    bylen++;
                    strlen++;
                    if ( c  > 255 ) bylen++;  //한글
                }
            }
            else {
                strlen = ctmp.length();
                bylen = ctmp.getBytes().length;
            }
            cntlen -= bylen;
            String ct = ctmp.substring(0,strlen);
            ctmp = ctmp.substring(strlen);
            vt.add(ct);
        }

        String[] rtnArr = null;
        rtnArr = new String[vt.size()];

        vt.copyInto(rtnArr);

        return rtnArr;
    }
    /**
     <pre>
     제목등 일정 공간보다 길이가 길 경우 일정 길이 이후에 "...."를 붙여 리턴한다.
     html에서 영문과 한글의 크기가 다르지만 동일하게 1개로 취급하므로 한글기준으로 길이설정.
     "...."로 고정이므로 leng은 4 보다 커야 한다.
     </pre>
     @param str -자르고 싶은 스트링
     @param leng - 일정 공간에 들어 갈 수 있는 스트링 길이("...." 포함)
     @return String
     */

    public String getTitleWithComma(String str , int leng){
      String rtnStr;
      if(str == null){
        rtnStr = "";
      }else if(str.length() <= leng  || leng < 4){
        rtnStr = str ;
      }else{
        rtnStr =  str.substring(0,leng-4) + "....";
      }
      return rtnStr;
    }
       /* Namos가 추가합니다
       문자열에서 comma를 제거합니다..
    */

    public String delComma(String str)
    {
        String rtnStr = "";
        for (int i=0;i<str.length();i++){
          if (!str.substring(i,i+1).equals(",")){
             rtnStr += str.substring(i,i+1);
          }
        }
        return rtnStr;
    }
    
    
    /**
	 * pStr의 NULL이거나 ""인 경우 ""을 리턴하고 아닌경우 pStr을 린턴  
	 * 
	 * @param pStr
	 * @return toEmpty(pStr)
	 */
	public static String toEmpty(String pStr){		
		return pStr!=null?pStr.length()>0?pStr:"":""; 
	}

    /**
	 * pStr의 NULL이거나 ""인 경우 ""을 리턴하고 아닌경우 pStr을 린턴  
	 * 
	 * @param pStr
	 * @return nvl(pStr)
	 */
	public static String nvl(String pStr){
		return nvl(pStr, null);
	}
	public static String nvl(String pStr, String reStr){
		String rtnStr = "";
//		String pStr = String.valueOf(pObj);
		if(pStr != null && pStr.length() > 0 && "null^undefined^NaN".indexOf(pStr) < 0){
			rtnStr = pStr;
		}else{
			rtnStr = reStr != null ? reStr : "";
		}
		
		return rtnStr;
	}
	public static String nvl(Object pStr){
		return nvl(pStr, null);
	}
	public static String nvl(Object pObj, String reStr){
		String rtnStr = "";
		String pStr = String.valueOf(pObj);
		if(pStr != null && pStr.length() > 0 && "null^undefined".indexOf(pStr) < 0){
			rtnStr = pStr;
		}else{
			rtnStr = reStr != null ? reStr : "";
		}
		
		return rtnStr;
	}
	
    /**
	 * 구분자가 포함된 문자열 배열로 변환한다.
	 *  1. 문자열을 구분자를 기준으로 배열을 생성하여 리턴한다.
	 * 
	 * @param str 구분자(delim)가 포함된 문자열
	 * @param delim 구분자
	 * @return 문자열을 구분으로 생성된 배열
	 * @throws Exception
	 */
	public static String[] getTokens(String str, String delim) throws Exception{		
		
		StringTokenizer tokenizer = new StringTokenizer(str, delim);
		String[] reArray = new String[tokenizer.countTokens()];

		if(reArray.length == 0 ) return reArray;		
		for(int i=0; tokenizer.hasMoreTokens(); i++)
		{
			reArray[i] = toEmpty(tokenizer.nextToken());			
		}	
		return reArray;
	}
	
	/** 작성자 : 김보람 
	 *  리스트를 스트링으로 변환 
	 * @param list  스트링으로 변환할 리스트
	 * @param key   스트링으로 변환할 리스트의 key 값
	 * @param split  구분자
	 * @return string 
	 */
	public static String getStringToList(List<Map<String,Object>> list, String key, String split){
		StringBuffer sb = new StringBuffer();
		if(list.size()>0){
			for(int i=0; i<list.size(); i++){
				if(i!=0)sb.append(split);
				sb.append(list.get(i).get(key));
			}
		}
		return sb.toString().trim();  
	}
	
	/** 작성자 : 윤봉훈
	 *  토큰으로 구분되어 있는 스트링을 리스트<맵> 형태로 변환  
	 * @param strParam	리스트로 변환할 스트링
	 * @return List<Map<String,String>> 
	 */
	public static List<Map<String,String>> makeStringToIterator(String strParam){
		return makeStringToIterator(strParam,null,null);
	}
	
	/** 작성자 : 윤봉훈
	 *  토큰으로 구분되어 있는 스트링을 리스트<맵> 형태로 변환  array 활용
	 * @param strParam	리스트로 변환할 스트링
	 * @return List<Map<String,String>> 
	 */
	public static List<Map<String,String>> makeStringToIterator(String[] strParam){
		
		String param = "";
		for (int i = 0; i < strParam.length; i++) {
			param = param + (i == 0 ? "" : ",") + strParam[i];
		}
		
		return makeStringToIterator(param,null,null);
	}

	/** 작성자 : 윤봉훈
	 *  토큰으로 구분되어 있는 스트링을 리스트<맵> 형태로 변환  
	 * @param strParam	리스트로 변환할 스트링
	 * @param rowToken	행 구분자
	 * @param colToken	열 구분자
	 * @return List<Map<String,String>> 
	 */
	public static List<Map<String,String>> makeStringToIterator(String strParam, String rowToken, String colToken){
		List<Map<String,String>> rtnList = new ArrayList<Map<String,String>>();
		
		if(rowToken == null) rowToken = ",";
		if(colToken == null) colToken = "^";
		
		if(!"".equals(nvl(strParam))){
			try {
				StringTokenizer arrRow = new StringTokenizer(strParam, rowToken);
				while (arrRow.hasMoreTokens()) {
					String strCol = nvl(arrRow.nextToken());
					if(!"".equals(strCol)){
						Map<String,String> dataMap = null;
						StringTokenizer arrCol = new StringTokenizer(strCol, colToken);
						dataMap = new HashMap<String,String>();
						for (int col = 0; arrCol.hasMoreTokens(); col++) {
							String strVal = nvl(arrCol.nextToken());
							if(!"".equals(strVal)){
								if(strVal.indexOf("=") < 0){
									dataMap.put("value" + (col == 0 ? "" : col), strVal);
								}else{
									String[] arrVal = strVal.split("=");
									dataMap.put(arrVal[0], arrVal[1]);
								}
							}
						}
						rtnList.add(dataMap);
					}
				}
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
//		System.out.println("rtnList ==================>>>>>>>>>>>>>>>>>>>>>>>>>>>  "+rtnList);
		return rtnList;
	}
	
	
	
	/*
	 * Clob를 String으로 변경
	 */			
	public static String clobToString(Clob clob) throws SQLException, IOException {
		if (clob == null) {
			return "";
		}
		
		StringBuffer strOut = new StringBuffer();

		String str = "";
		BufferedReader br = new BufferedReader(clob.getCharacterStream());

		while ((str = br.readLine()) != null) {
			strOut.append(str);
		}
		return strOut.toString();
	}
	
}
