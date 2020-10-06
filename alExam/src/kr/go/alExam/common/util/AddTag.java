package kr.go.alExam.common.util;
import java.util.*;

/**
 *  AddTag class
 *
 * @author G.S.T
 * @version 1.0
 * @since
 *
 * @see -
 * <pre>
 *  jsp 페이지에서 request 파라메타 값을 GET,POST 에 관계 없이 
 *  받아들여서 가공 한다
 * </pre>
 */
public class AddTag {
  private HashMap map;
  /**
   * <pre>
   *  class AddTag 의 생성자로 request.getParameterMap()의 map 은 수정이
   *  않되므로 새로운 HashMap 에 복제 한다.
   * </pre>
   */
  public AddTag(){
    map = new HashMap();
  }
  /**
   * <pre>
   *  class AddTag 의 생성자로 request.getParameterMap()의 map 은 수정이
   *  않되므로 새로운 HashMap 에 복제 한다.
   * </pre>
   */

  public AddTag(Map paraMap) {
    map = new HashMap();
    Iterator itr = paraMap.entrySet().iterator();
    while(itr.hasNext()){
      Map.Entry e = (Map.Entry)itr.next();
      map.put(e.getKey(),(String[])e.getValue());
    }
  }

  public AddTag(String getParam){
    map = new HashMap();
    String tmp = "";
    if(getParam != null && getParam != "" && !"".equals(getParam)){
      StringTokenizer str = new StringTokenizer(getParam,"&");
      while(str.hasMoreTokens()){
        tmp = str.nextToken();
       this.put(tmp.substring(0,tmp.indexOf("=")),tmp.substring(tmp.indexOf("=")+1));
      }

    }
  }
  /**
   *<pre>
   * HashMap 에 키와 값의 쌍의로 저장한다.
   * value 는 String[] 타입으로 받는다.
   * </pre>
   */
  public Object put(String key,String[] value){
    return map.put(key,value);
  }
  /**
   *<pre>
   * HashMap 에 키와 값의 쌍의로 저장한다.
   * value 는 String 타입으로 받는다.
   * valuesms 내부에서 String[]로 변환한다.
   * </pre>
   */
  public Object put(String key,String value){
    String[] tmp = new String[]{value};
    return map.put(key,tmp);
  }
  /**
   *<pre>
   * 키를 비교 하여 같은 것을 삭제 한다.
   * </pre>
   */
  public Object remove(String key){
    return map.remove(key);
  }
  /**
   *<pre>
   *  GET 형식의 질의어로 리턴 한다.
   * 예) m=jdbc&b=javascript&c=r_p&n=1050569487
   * </pre>
   */
  public String getAddTagToGET(){
    StringBuffer addTag = new StringBuffer();
    Iterator itr = map.entrySet().iterator();
    while(itr.hasNext()){
      Map.Entry e = (Map.Entry)itr.next();
      String[] a_value = (String[])e.getValue();
      for(int i=0; i<a_value.length;i++){
        addTag.append( "&" + e.getKey() + "=" + a_value[i] );
      }
    }
    String addTagReturn	= addTag.toString();

    if(addTagReturn != null && addTagReturn != "" && addTagReturn.length()  > 0){
      addTagReturn = addTagReturn.substring(1);
    }else{
      addTagReturn = "";
    }
    return addTagReturn;
  }
  /**
   *<pre>
   *  POST 형식의 hidden input 로 리턴 한다.
   * 예) &lt;input type=&quot;hidden&quot; name=&quot;k&quot; value=&quot;124&quot;&gt;
   *     &lt;input type=&quot;hidden&quot; name=&quot;y&quot; value=&quot;124&quot;&gt;
   *     &lt;input type=&quot;hidden&quot; name=&quot;s&quot; value=&quot;124&quot;&gt;
   * </pre>
   */
  public String getAddTagToPOST(){
    StringBuffer addTag = new StringBuffer();
    Iterator itr = map.entrySet().iterator();
    while(itr.hasNext()){
      Map.Entry e = (Map.Entry)itr.next();
      String[] a_value = (String[])e.getValue();
      for(int i=0; i<a_value.length;i++){
        addTag.append( "<input type=\"hidden\" name=\"" + e.getKey() + "\" value=\"" + a_value[i] + "\"> \n");
      }

    }
    return addTag.toString();
  }

}
