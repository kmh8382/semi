package com.min.semiapp.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.min.semiapp.dto.BlogDto;
import com.min.semiapp.service.IBlogService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class BlogController {

  private final IBlogService blogService;

  
  // 블로그 목록 및 페이징 처리
  @RequestMapping(value="/blog/list.do")
  public String list(HttpServletRequest request, Model model) {
    Map<String, Object> map = blogService.getBlogList(request);
    model.addAttribute("blogs", map.get("blogs"));
    model.addAttribute("total", map.get("total"));
    model.addAttribute("paging", map.get("paging"));
    model.addAttribute("offset", map.get("offset"));
    
    return "blog/list";
  }
  
  // 블로그 작성 페이지 연결
  @RequestMapping(value="/blog/write.do")
  public String write() {
    return "/blog/write";
  }
  
  // 블로그 추가 성공 여부 메시지 반환
  @RequestMapping(value="/blog/regist.do", method=RequestMethod.POST)
  public String registBlog(BlogDto blogDto, RedirectAttributes redirectAttributes) {
    redirectAttributes.addFlashAttribute("msg", blogService.registBlog(blogDto));
    return "redirect:/blog/list.do";
  }
  
  // 블로그 상세 내용 확인
  @RequestMapping(value="/blog/detail.do")
  public String detail(@RequestParam(value="blogId") int blogId, Model model) {
    // 블로그 상세 내용 detail.jsp에 전달
    model.addAttribute("blog", blogService.getBlogById(blogId));
    return "blog/detail";
  }
  
  // 블로그 수정 성공 여부 메시지 반환
  @RequestMapping(value="/blog/modify.do", method=RequestMethod.POST)
  public String modify(BlogDto blogDto, RedirectAttributes redirectAttributes) {
    // 수정 후 결과 메시지를 list.do에 요청하면서 전달
    redirectAttributes.addFlashAttribute("msg", blogService.modifyBlog(blogDto));
    return "redirect:/blog/list.do";
  }
  
  // 블로그 삭제 성공 여부 메시지 반환
  @RequestMapping(value="/blog/remove.do", method=RequestMethod.POST)
  public String remove(@RequestParam(value="blogId") int blogId, RedirectAttributes redirectAttributes) {
   redirectAttributes.addFlashAttribute("msg", blogService.removeBlog(blogId));
   return "redirect:/blog/list.do";
  }
  
}
