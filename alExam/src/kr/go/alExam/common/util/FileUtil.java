package kr.go.alExam.common.util;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.apache.log4j.Logger;

public class FileUtil{
	
	private String fileDir;
	private String imageDir;
	private String fileDirOld;
	private String fileNotDir;
	
	public String getFileDir() {
		return fileDir;
	}

	public void setFileDir(String fileDir) {
		this.fileDir = fileDir;
	}
	
	public String getFileDirOld(){
		return fileDirOld;
	}
	
	public void setFileDirOld(String fileDirOld){
		this.fileDirOld = fileDirOld;
	}
	
	
	public String getFileNotDir(){
		return fileNotDir;
	}
	
	public void setFileNotDir(String fileNotDir) {
		this.fileNotDir = fileNotDir;
	}	
	
	

	public String getImageDir() {
		return imageDir;
	}

	public void setImageDir(String imageDir) {
		this.imageDir = imageDir;
	}


	private final  Logger LOG = Logger.getLogger(this.getClass());
	public byte[] invertBinary(String fPath, String fName) throws FileNotFoundException {
		
		byte data[] = null;
		try {
			FileInputStream fis = new FileInputStream(new File(fPath, fName));
			data = new byte[fis.available()];
			while(fis.read(data)!=-1){;}
			fis.close();
			
		}catch (IOException e) {
			e.printStackTrace();
		}
		return data;
	}
	
    /**
     * 파일아이디 생성
     * @return
     */
    public String getAttachFileId(){
    	String curDate = SimpleDateUtil.getSysDate("yyyyMMddhhmmss");
    	int rNum = (int)(Math.random()*999999);
    	return curDate.toString()+rNum;
    }
    
    public int getFileNumber(){
    	return (int)(Math.random()*9);
    }

    /**
     * 썸네일 파일 생성
     * @param fileNm
     * @return
     */
    public void getThumbnailImage(String fileName, String extnsn, int thumbnail_width, int thumbnail_height){
    	try {
            //원본이미지파일의 경로+파일명
            File origin_file_name = new File(fileName);
            //생성할 썸네일파일의 경로+썸네일파일명
            File thumb_file_name = new File(fileName+"_thumb");
            
            BufferedImage buffer_original_image = ImageIO.read(origin_file_name);
            BufferedImage buffer_thumbnail_image = new BufferedImage(thumbnail_width, thumbnail_height, BufferedImage.TYPE_3BYTE_BGR);
            Graphics2D graphic = buffer_thumbnail_image.createGraphics();
            graphic.drawImage(buffer_original_image, 0, 0, thumbnail_width, thumbnail_height, null);
            ImageIO.write(buffer_thumbnail_image, extnsn, thumb_file_name);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    
    /**
     * 파일 삭제
     * @param fileNm
     * @return
     */
    public void deleteFile(String fileName, String filePath) {
    	try {
    		if("".equals(fileName) || "".equals(filePath))
    			return;
    		
    		String delFilePath = getFileDir() + File.separator + fileName + File.separator + filePath;
			File delFile = new File(delFilePath);
			if(!delFile.isDirectory()){
				delFile.delete();
			}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	
    }
    
    /**
     * 파일 확장자 체크
     * @param fileNm
     * @return
     */
    public String getFileType(String fileNm){    	
    	// 동영상 : AVI,WMV,MPEG,MPG,ASF,MKV,MKA,TP,TS,FLV,MP4,MOV,K3G,VOB,SKM 
    	// 이미지 : JPG, JPEC, GIF, BMP, TIFF, PNG
    	// 음원 : MP3, OGG, WAV, MID
    	//String[] movTypes = {"AVI","WMV","MPEG","MPG","ASF","MKV","MKA","TP","TS","FLV","MP4","MOV","K3G","VOB","SKM"};
    	String[] movTypes = {"MEPG","MOV","ASF","ASX","RM","MP4","AVI","3GP","OGM","MKV","WMV","FLV","M2T","MPG"};
    	String[] imgTypes = {"JPG","JPEG","JPEC","GIF","BMP","TIFF","PNG"};
    	String[] docTypes = {"PDF", "HWP","PPT","PPTX","XLS","XLSX","DOC", "TXT", "ZIP"};    	
    	String[] mp3Types = {"MP3","OGG","WAV","MID"};   	
    	String[] fileTypes = {"MOV","PDF","IMG","MP3","ETC"};
    	String rtType = "ETC"; //ETC
    	
//    	String[] fileNames = fileNm.split("."); //20160712 윤봉훈 - split이 정상적으로 안되서 다른 방법 사용.
//    	String fileExt = "";
//    	if(fileNames.length==2){
//    		fileExt = fileNames[1].toUpperCase();
    	String fileExt = fileNm.substring(fileNm.lastIndexOf(".")+1).toUpperCase();
    		if(chkFileTypes(movTypes, fileExt)){
    			rtType = "MOV";
    		}else if(chkFileTypes(imgTypes, fileExt)){
    			rtType = "IMG";
    		}else if(chkFileTypes(mp3Types, fileExt)){
    			rtType = "MP3";
    		}else if(chkFileTypes(docTypes, fileExt)){
    			rtType = "DOC";
    		}
//    	}  	
    	    	
    	return rtType;
    }
    
    private boolean chkFileTypes(String[] fileTypes, String fileExt){
    	boolean rtBool = false;
    	for(String fileType : fileTypes){
    		if(fileType.equals(fileExt)){
    			rtBool = true;
    			break;
    		}
    	}
    	
    	return rtBool;
    }
    
    public byte[] getGraphImage(){
    	byte[] resultByte = null;
    	
    	try {
			//resultByte = invertBinary(getImageDir(),"graph.gif");
    		resultByte = getGraphImage(new float[]{100,200,300,400,500},new float[]{100,250,305,400,508});
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	return resultByte;
    }
    
    public byte[] getGraphImage(float[] x_val, float[] y_val){
    	byte[] resultByte = null;
    	try {
    		String outputFileNm = "output_"+getFileNumber()+".png";
    		File outputFile = new File(getImageDir()+"/output",outputFileNm);    	 
			BufferedImage img = ImageIO.read(new File(getImageDir()+"/graph.jpg"));
    		int img_w = 365;
    		int img_h = 178;
    		
    		if(x_val.length>=2){
    		
    			System.out.println("graph !!!");
	    		Graphics g = img.createGraphics();
	
	    		Graph graph = new Graph(g,x_val,y_val);
	    		graph.initGraph();
    		
    		}

			
			ImageIO.write(img, "png", outputFile);
			
	    	resultByte = invertBinary(getImageDir()+"/output",outputFile.getName());
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

    	
    	return resultByte;
    }

	public class Graph{
		private int r = 6; //원의 반지름
		
		private float pp = r/2; //포인트 반지름 길이
		
		private float sx = 49f;			//x축 시작점
		private float sy = 144f;		//y축 시작점
		
		private float graph_w = 296f;	//그래프 전체 가로사이즈
		private float graph_h = 138f;	//그래프 전체 세로 범위 
		
		private Graphics g;
		private float[] x_val;
		private float[] y_val;
		private float xx, yy;
		private float maxVal;
		
		public Graph(Graphics g, float[] x_val, float[] y_val){
			this.g = g;
			this.x_val = x_val;
			this.y_val = y_val;
			this.maxVal = getMaxVal(x_val);
			yy = graph_h/maxVal; 		// 1mg/dl당 세로사이즈
			xx = graph_w/maxVal;		// 1mg/dl당 가로사이즈
		}
		
		public void initGraph(){
			float x=0,y=0;

			g.setColor(new Color(0,0,0));
			
			initAxis();
			
			setPoint();
			
			setResult();

		}
		
		public void initAxis(){
			float x=0,y=0;			
			for(int i=0; i<x_val.length;i++){
				//Axix X
				x = sx+(xx*x_val[i]);
				y = sy;
				
				g.drawLine((int)x, (int)y, (int)x, (int)y+3);
				g.drawString(String.valueOf((int)x_val[i]), (int)x-10, (int)y+15);				
				//Axix Y
				x = sx;
				y = sy-(yy*x_val[i]);
				if(x_val[i] > 0){
					g.setColor(new Color(200,200,200));
					g.drawLine((int)x, (int)y, (int)(x+graph_w), (int)y);
					g.setColor(new Color(0,0,0));
					g.drawString(String.valueOf((int)x_val[i]), (int)x-25, (int)y+5);
				}
			}
		}

		
		public void setPoint(){
			g.setColor(new Color(255,0,0));
			float x=0,y=0;			
			for(int i=0; i<x_val.length;i++){				
				if(i<y_val.length){						
					x = sx+(xx*x_val[i])-pp;
					y = sy-(yy*y_val[i])-pp;
					g.fillOval((int)x, (int)y, r, r);
				}				
			}	
		}
		
		public void setResult(){
			g.setColor(new Color(0,0,0));
			
			double a = getA(x_val,y_val);
			double b = getB(x_val,y_val);
			double r2 = getR2(x_val,y_val);
			
			System.out.println("maxVal::"+maxVal);
			System.out.println("getAvg X=="+getAvg(x_val)+"  getAvg Y=="+getAvg(y_val));
			System.out.println("a=="+a+"  b=="+b+"  r=="+r2);
			
			String str_a = String.format("%.4f",a);
			String str_b = String.format("%.2f",b);
			String str_r2 = String.format("%.4f",r2);
			
			g.drawString("y="+str_a+"x"+(b<0?str_b:"+"+str_b), (int)60, (int)25);
			g.drawString("R2="+str_r2, (int)60, (int)45);
			
//			double x1 = sx;
//			double y1 = sy-(yy*b);
//			double x2 = sx+(xx*maxVal);		
//			double y2 = sy-(yy*(a*maxVal+b));
			
	
			double x1=0,x2=0,y1=0,y2=0, x=0;
			if(b>=0){
				x1 = sx;
				y1 = sy-(yy*b);

			}else{
				x = (-b)/a;	
				x1 = sx+(xx*x);	
				y1 = sy;
			}
			x = (maxVal-b)/a;
			x2 = sx+(xx*x);		
			y2 = sy-(yy*(a*x+b));
	
			g.drawLine((int)x1, (int)y1, (int)x2, (int)y2);
		}

		
	    public float getMaxVal(float[] arr_val){
	    	float maxVal = 0;
	    	for(int i=0; i<arr_val.length; i++){
	    		if(maxVal<arr_val[i])
	    			maxVal = arr_val[i];
	    	}
	    	float interval = maxVal/arr_val.length;
	    	maxVal = maxVal+interval;
	    	return maxVal;
	    }
	    
	    
	    public boolean hasZero(float[] arr_val){
	    	float bool = 0;
	    	for(int i=0; i<arr_val.length; i++){
	    		if(arr_val[i] == 0)
	    			return true;
	    	}
	    	return false;
	    }
		public float getSum(float[] values){
			float result = 0;
			for(float val : values){
				result = result+val;
			}
			return result;
		}
		
		public float getAvg(float[] values){
			float sum = getSum(values);
			return sum/values.length;
		}
		public float[] getDiffValues(float[] values){
			float avg = getAvg(values);
			float[] result = new float[values.length];
			for(int i=0; i<values.length; i++){
				result[i]= values[i]-avg;
				//System.out.println("diff="+result[i]);
			}

			return result;
		}
		
		public double getA(float[] x_values, float[] y_values){
			float[] diff_x = getDiffValues(x_values);
			float[] diff_y = getDiffValues(y_values);
			double sum01=0,sum02 = 0;
			double result = 0;
			for(int i=0;i< diff_x.length; i++){
				sum01 = sum01 + (diff_x[i]*diff_y[i]);
			}
			for(int i=0;i< diff_x.length; i++){
				sum02 = sum02 + Math.pow((double)diff_x[i],2);
			}
			//System.out.println("sum01="+sum01);
			//System.out.println("sum02="+sum02);
			
			result = sum01/sum02;
			
			return result;
		}
		
		public double getB(float[] x_values, float[] y_values){
			double a = getA(x_values,y_values);
			double b = getAvg(y_values)-(getAvg(x_values)*a);
			
			return b;
		}
		
		public double getR2(float[] x_values, float[] y_values){
			
			float[] diff_x = getDiffValues(x_values);
			float[] diff_y = getDiffValues(y_values);
			double sum01=0,sum02=0, sum03 = 0;
			double result = 0;
			for(int i=0;i< diff_x.length; i++){
				sum01 = sum01 + Math.pow((double)diff_x[i],2);
				sum02 = sum02 + Math.pow((double)diff_y[i],2);		
				
				sum03 = sum03 + (diff_x[i]*diff_y[i]);
			}

			
			double sqrt_x = Math.sqrt(sum01);
			double sqrt_y = Math.sqrt(sum02);
			
			result = Math.pow(sum03/(sqrt_x*sqrt_y),2);
			
			return result;	
			
		}
	}
 
}
