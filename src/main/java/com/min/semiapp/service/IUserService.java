package com.min.semiapp.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.min.semiapp.dto.UserDto;

public interface IUserService {
  String signup(UserDto userDto);
  boolean login(HttpServletRequest request);
  void logout(HttpSession session);
  UserDto mypage(int userId);
  String modifyInfo(UserDto userDto) throws Exception;
  
}
