package kr.go.alExam.common.util;


public class PaginationUtil {

	private int rowSize;
	private int pageSize;
	
	private int curPage;	
	private long totalRecordCnt; 

	private int totalPageCnt; 
	private int firstPageNum;
	private int lastPageNum;	
	private int lastPageNum2;
	private int pageStartIndex;
	

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(Object curPage) {
		this.curPage = curPage==null?1:Integer.parseInt(curPage.toString()); 
	}

	public void setRowSize(int rowSize) {
		this.rowSize = rowSize;
	}

	public void setPageSize(int pageSize) { 
		this.pageSize = pageSize;
	} 

	public int getRowSize() {
		return rowSize;
	}

	public int getPageSize() {
		return pageSize;
	}

	public long getTotalRecordCnt() {
		return totalRecordCnt;
	}	
	
	public void setTotalRecordCnt(long totalRecordCnt) {
		this.totalRecordCnt = totalRecordCnt;
	}


	public int getTotalPageCnt() {
		totalPageCnt = (int)(Math.ceil((double)totalRecordCnt/rowSize));   
		return totalPageCnt; 
	}

	public int getFirstPageNum() {
		firstPageNum = ((int)((curPage -1) / pageSize))*pageSize +1;
		return firstPageNum;
	}
	
	//페이징 표시할 갯수
	public int getLastPageNum() {
		lastPageNum = ((int)((curPage -1) / pageSize))*pageSize + 10;
		return lastPageNum < totalPageCnt ? lastPageNum : totalPageCnt;        
	}
	
	//페이징 표시할 갯수 (혈당그래프)
	public int getLastPageNum2() {
		lastPageNum2 = ((int)((curPage -1) / pageSize))*pageSize + 3;
		return lastPageNum2 < totalPageCnt ? lastPageNum2 : totalPageCnt;        
	}
	
	//reverse
	public int getPageStartIndex(){
		pageStartIndex = ((int)getTotalRecordCnt())-( (curPage-1)*rowSize);           
		return pageStartIndex;
	}
	
	public int getSkipRs(){
		return ((curPage-1)*rowSize);
	}
	
	public int getMaxRs(){
		return rowSize; 
	}
	
	public int getStartIndex(){
		return ((curPage-1)*rowSize)+1;
	}
	
	public int getLastIndex(){
		int last = getStartIndex() + rowSize - 1;
		return last > getTotalRecordCnt() ? (int)getTotalRecordCnt() : last; 
	}

}
