package com.min.semiapp.dao.Impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.min.semiapp.dao.IBlogDao;
import com.min.semiapp.dto.BlogDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class BlogDaoImpl implements IBlogDao {

  // SqlSession 활용
  private final SqlSessionTemplate template;
 
  @Override
  public List<BlogDto> selectBlogList(Map<String, Object> map) {
    return template.selectList("mybatis.mappers.blogMapper.selectBlogList", map);
  }
  
  @Override
  public int selectBlogCount() {
    return template.selectOne("mybatis.mappers.blogMapper.selectBlogCount");
  }
  
  @Override
  public int insertBlog(BlogDto blogDto) {
    return template.insert("mybatis.mappers.blogMapper.insertBlog", blogDto);
  }
  
  @Override
  public BlogDto selectBlogById(int blog_id) {
    return template.selectOne("mybatis.mappers.blogMapper.selectBlogById", blog_id);
  }
  
  @Override
  public int updateBlog(BlogDto blogDto) {
    return template.update("mybatis.mappers.blogMapper.updateBlog", blogDto);
  }
  
  @Override
  public int deleteBlog(int blog_id) {
    return template.delete("mybatis.mappers.blogMapper.deleteBlog", blog_id);
  }
  
  @Override
  public List<BlogDto> selectBlogSearchList(Map<String, Object> map) {
    return template.selectList("mybatis.mappers.blogMapper.selectBlogSearchList", map);
  }
  
  @Override
  public int selectBlogSearchCount(Map<String, Object> map) {
    int blogCount = template.selectOne("mybatis.mappers.blogMapper.selectBlogSearchCount", map);
    return blogCount;
  }
}