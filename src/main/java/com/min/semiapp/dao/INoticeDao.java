package com.min.semiapp.dao;

import java.util.List;
import java.util.Map;

import com.min.semiapp.dto.AttachDto;
import com.min.semiapp.dto.NoticeDto;

public interface INoticeDao {

  List<NoticeDto> selectNoticeList(Map<String, Object> map);
  int selectNoticeCount();
  NoticeDto selectNoticeById(int noticeId); //상세보기
  List<AttachDto>selectAttachListByNoticeId(int noticeId);
  AttachDto selectAttachById(int attachId);
  int insertNotice(NoticeDto noticeDto);
  int insertAttach(AttachDto attachDto);
  int deleteNotice(int noticeId);
  int updateAttachDownloadCount(int attachId);  
  List<NoticeDto> selectSearchList(Map<String, Object> map);
  int selectSearchCount(Map<String, Object> map);
  int updateNotice(NoticeDto noticeDto);
}
