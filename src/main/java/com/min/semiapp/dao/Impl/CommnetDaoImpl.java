package com.min.semiapp.dao.Impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.min.semiapp.dao.ICommentDao;
import com.min.semiapp.dto.CommentDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class CommnetDaoImpl implements ICommentDao {
  
  private final SqlSessionTemplate template;

  @Override
  public int updateGroupOrder(CommentDto commentDto) {
    return template.update("mybatis.mappers.commentMapper.updateGroupOrder", commentDto);
  }

  @Override
  public int insertBlogReply(CommentDto commnetDto) {
    return template.insert("mybatis.mappers.commentMapper.insertBlogReply", commnetDto);
  }
  
  @Override
  public List<CommentDto> selectCommentList(Map<String, Object> map) {
    return template.selectList("mybatis.mappers.commentMapper.selectCommentList", map);
  }
  
  @Override
  public int selectCommentCount() {
    return template.selectOne("mybatis.mappers.commentMapper.selectCommentCount");
  }
  

}
