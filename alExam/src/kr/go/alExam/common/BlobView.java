package kr.go.alExam.common;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.net.URLConnection;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class BlobView extends AbstractView {

	public BlobView(){   
		super();
	}
	@Override
	public void render(Map<String, ?> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		//super.render(model, request, response);
		System.out.println("start BlobView!!!");
		if(model.get("bytes")==null){
			System.out.println("bytes not exist");
			return;
		}
		byte[] bytes = (byte[])model.get("bytes"); 
 
		
		if(bytes.length >0 ){

			InputStream is = new ByteArrayInputStream(bytes);
         
			String contentType = URLConnection.guessContentTypeFromStream(is);
			
			contentType = contentType!=null?contentType:"image/jpeg";  
			
			System.out.println(contentType);     
			
			//if(contentType.equals("image/jpeg")
			//	||contentType.equals("image/png")
			//	||contentType.equals("image/gif")){
				response.setContentType(contentType);
				response.setContentLength((int)bytes.length);
				ServletOutputStream os = response.getOutputStream(); 
				
				FileCopyUtils.copy(is,os);  
				os.flush(); 
				
			//}
		}
	}
	@Override
	protected void renderMergedOutputModel(Map model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("start BlobView!!!");
		byte[] bytes = (byte[])model.get("bytes"); 
 
		
		if(bytes.length >0 ){

			InputStream is = new ByteArrayInputStream(bytes);
         
			String contentType = URLConnection.guessContentTypeFromStream(is);
			
			contentType = contentType!=null?contentType:"image/jpeg";  
			
			System.out.println(contentType);     
			
			//if(contentType.equals("image/jpeg")
			//	||contentType.equals("image/png")
			//	||contentType.equals("image/gif")){
				response.setContentType(contentType);
				response.setContentLength((int)bytes.length);
				ServletOutputStream os = response.getOutputStream(); 
				
				FileCopyUtils.copy(is,os);  
				os.flush(); 
				
			//}
		}
	}

}