package com.min.semiapp.service.Impl;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.min.semiapp.dao.IBbsDao;
import com.min.semiapp.dto.BbsDto;
import com.min.semiapp.service.IBbsService;
import com.min.semiapp.util.PageUtil;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class BbsServiceImpl implements IBbsService {

  private final IBbsDao bbsDao;
  private final PageUtil pageUtil;
  
  @Override
  public String registBbs(BbsDto bbsDto) {
    return bbsDao.insertBbs(bbsDto) == 1 ? "게시글 등록 성공" : "게시글 등록 실패";
  }
  
  @Override
  public Map<String, Object> getBbsList(HttpServletRequest request) {
    
    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(optPage.orElse("1"));

    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
    int display = Integer.parseInt(optDisplay.orElse("20"));
    
    int count = bbsDao.selectBbsCount();
    
    pageUtil.setPaging(page, display, count);
    
    int offset = pageUtil.getOffset();
    
    List<BbsDto> bbsList = bbsDao.selectBbsList(Map.of("offset", offset, "display", display));
    
    String paging = pageUtil.getPaging(request.getContextPath() + "/bbs/list.do", "");
    
    return Map.of("offset", offset
                , "count", count
                , "bbsList", bbsList
                , "paging", paging);
    
  }
  
  @Override
  public String registBbsReply(BbsDto bbsDto) {

    /*
     * 파라미터 BbsDto bbsDto는 아래 값을 가지고 있습니다.
     *   contents   : 댓글의 내용
     *   depth      : 원글의 depth
     *   groupId    : 원글의 groupId
     *   groupOrder : 원글의 groupOrder
     */
    
    // 1. 기존 댓글의 group_order 업데이트
    bbsDao.updateGroupOrder(bbsDto);
    
    // 2. 댓글 등록
    bbsDto.setDepth(bbsDto.getDepth() + 1);            // 댓글의 depth는 원글의 depth 보다 1 큽니다.
    bbsDto.setGroupId(bbsDto.getGroupId());            // 댓글의 groupId는 원글의 groupId와 같습니다. 이 코드는 설명을 위한 코드일 뿐 작성하지 않습니다.
    bbsDto.setGroupOrder(bbsDto.getGroupOrder() + 1);  // 댓글의 groupOrder는 원글의 groupOrder 보다 1 큽니다.
    
    return bbsDao.insertBbsReply(bbsDto) == 1 ? "댓글 등록 성공" : "댓글 등록 실패";
    
  }
  
  @Override
  public String deleteBbs(int bbsId) {
    return bbsDao.deleteBbs(bbsId) == 1 ? "게시글 삭제 성공" : "게시글 삭제 실패";
  }

}
