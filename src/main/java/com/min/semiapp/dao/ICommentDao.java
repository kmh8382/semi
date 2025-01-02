package com.min.semiapp.dao;

import java.util.List;
import java.util.Map;

import com.min.semiapp.dto.CommentDto;

public interface ICommentDao {

  // 댓글 업데이트 및 추가
  int updateGroupOrder(CommentDto commentDto);
  
  int insertBlogReply(CommentDto commnetDto);
  
  // 댓글 리스트 가져오기
  List<CommentDto> selectCommentList(Map<String, Object> map);
  
  // 페이징 처리를 위한 갯수 체크
  int selectCommentCount();
  
}
