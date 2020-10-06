package kr.go.alExam.common;

import java.util.Locale;

import org.springframework.context.NoSuchMessageException;
import org.springframework.context.support.MessageSourceAccessor;

public class DMessage {
	private  MessageSourceAccessor msAcc;
	
	public void setMessageSourceAccessor(MessageSourceAccessor msAcc) { 
		this.msAcc = msAcc;
	}

	/*
	public String getMsg(String code) throws NoSuchMessageException {
		return StringUtil.getConvertCharset(getLogMsg(code),"utf-8","8859_1"); 
	}
	*/
	
	public String getLogMsg(String code) throws NoSuchMessageException { 
		return msAcc.getMessage(code, Locale.KOREAN);
	}
	
	public String getMsg(String code, Object[] args)
			throws NoSuchMessageException {
		return msAcc.getMessage(code, args, Locale.KOREAN);  
	}
	
	public String getMsg(String code)
			throws NoSuchMessageException {
		return msAcc.getMessage(code);  
	}	

}
