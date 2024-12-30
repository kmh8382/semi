package com.min.semiapp.controller;

import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.min.semiapp.dto.UserDto;
import com.min.semiapp.service.IUserService;

import lombok.RequiredArgsConstructor;

@RequestMapping(value="/user")
@RequiredArgsConstructor
@Controller
public class UserController {

  private final IUserService userService;

  @RequestMapping(value="/signup.form")
  public String signupForm() {
    return "user/signup";
  }
  
  @RequestMapping(value="/signup.do", method=RequestMethod.POST)
  public String signup(UserDto userDto, RedirectAttributes redirectAttributes) {
    redirectAttributes.addFlashAttribute("msg", userService.signup(userDto));
    return "redirect:/";
  }
  
  @RequestMapping(value="/login.form")
  public String loginForm(HttpServletRequest request, Model model) {
    Optional<String> opt = Optional.ofNullable(request.getParameter("url"));
    String url = opt.orElse("http://localhost:8080/" + request.getContextPath());
    model.addAttribute("url", url);
    return "user/login";
  }
  
  @RequestMapping(value="/login.do", method=RequestMethod.POST)
  public String login(HttpServletRequest request, RedirectAttributes redirectAttributes) {
    boolean loginSuccess = userService.login(request);
    String url = request.getParameter("url");
    if(!loginSuccess) {
      redirectAttributes.addFlashAttribute("msg", "일치하는 회원 정보가 없습니다.");
      return "redirect:/user/login.form?url=" + url;
    }
    return "redirect:" + url;
  }
  
  @RequestMapping(value="/logout.do")
  public String logout(HttpSession session) {
    userService.logout(session);
    return "redirect:/";
  }
  
  @RequestMapping(value="/mypage.do")
  public String mypage(@RequestParam(value="userId", required=false, defaultValue="0") int userId, Model model) {
    if(userId == 0) {
      return "redirect:/";
    }
    model.addAttribute("u", userService.mypage(userId));
    return "user/mypage";
  }
  
  @RequestMapping(value="/modifyInfo.do", method=RequestMethod.POST)
  public String modifyInfo(UserDto userDto, RedirectAttributes redirectAttributes) {
    try {
      redirectAttributes.addFlashAttribute("msg", userService.modifyInfo(userDto));
      return "redirect:/user/mypage.do?userId=" + userDto.getUserId();
    } catch (Exception e) {
      redirectAttributes.addFlashAttribute("msg", "회원 정보 변경 실패");
      return "redirect:/";
    }
  }
  
  
  
  
}
