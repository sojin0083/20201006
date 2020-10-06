package kr.go.alExam.common;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

public class DMultiEgovAbstractMapper extends EgovAbstractMapper {
	
	@Resource(name = "sqlSessionTemplate")
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate){
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public int insert(String queryId) {
		// TODO Auto-generated method stub
		return super.insert(queryId);
	}

	@Override
	public int insert(String queryId, Object parameterObject) {
		// TODO Auto-generated method stub
		return super.insert(queryId, parameterObject);
	}

	@Override
	public int update(String queryId) {
		// TODO Auto-generated method stub
		return super.update(queryId);
	}

	@Override
	public int update(String queryId, Object parameterObject) {
		// TODO Auto-generated method stub
		return super.update(queryId, parameterObject);
	}

	@Override
	public int delete(String queryId) {
		// TODO Auto-generated method stub
		return super.delete(queryId);
	}

	@Override
	public int delete(String queryId, Object parameterObject) {
		// TODO Auto-generated method stub
		return super.delete(queryId, parameterObject);
	}

	@Override
	public Object selectByPk(String queryId, Object parameterObject) {
		// TODO Auto-generated method stub
		return super.selectByPk(queryId, parameterObject);
	}

	@Override
	public <T> T selectOne(String queryId) {
		// TODO Auto-generated method stub
		return super.selectOne(queryId);
	}

	@Override
	public <T> T selectOne(String queryId, Object parameterObject) {
		// TODO Auto-generated method stub
		return super.selectOne(queryId, parameterObject);
	}

	@Override
	public <K, V> Map<K, V> selectMap(String queryId, String mapKey) {
		// TODO Auto-generated method stub
		return super.selectMap(queryId, mapKey);
	}

	@Override
	public <K, V> Map<K, V> selectMap(String queryId, Object parameterObject,
			String mapKey) {
		// TODO Auto-generated method stub
		return super.selectMap(queryId, parameterObject, mapKey);
	}

	@Override
	public <K, V> Map<K, V> selectMap(String queryId, Object parameterObject,
			String mapKey, RowBounds rowBounds) {
		// TODO Auto-generated method stub
		return super.selectMap(queryId, parameterObject, mapKey, rowBounds);
	}

	@Override
	public List<?> list(String queryId, Object parameterObject) {
		// TODO Auto-generated method stub
		return super.list(queryId, parameterObject);
	}

	@Override
	public <E> List<E> selectList(String queryId) {
		// TODO Auto-generated method stub
		return super.selectList(queryId);
	}

	@Override
	public <E> List<E> selectList(String queryId, Object parameterObject) {
		// TODO Auto-generated method stub
		return super.selectList(queryId, parameterObject);
	}

	@Override
	public <E> List<E> selectList(String queryId, Object parameterObject,
			RowBounds rowBounds) {
		// TODO Auto-generated method stub
		return super.selectList(queryId, parameterObject, rowBounds);
	}

	@Override
	public List<?> listWithPaging(String queryId, Object parameterObject,
			int pageIndex, int pageSize) {
		// TODO Auto-generated method stub
		return super.listWithPaging(queryId, parameterObject, pageIndex, pageSize);
	}

	@Override
	public void listToOutUsingResultHandler(String queryId,
			ResultHandler handler) {
		// TODO Auto-generated method stub
		super.listToOutUsingResultHandler(queryId, handler);
	}
	
}
