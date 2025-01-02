package com.min.semiapp.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.min.semiapp.dto.CommentDto;

public interface ICommentService {
  
  // 댓글 업데이트 및 추가
  String registBlogReply(CommentDto commentDto);
  
  // 댓글 리스트 생성
  Map<String, Object> getCommentList(HttpServletRequest request);

}
