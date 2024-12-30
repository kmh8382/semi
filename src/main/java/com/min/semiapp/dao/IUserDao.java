package com.min.semiapp.dao;

import java.util.Map;

import com.min.semiapp.dto.UserDto;

public interface IUserDao {
  int insertUser(UserDto userDto);
  UserDto selectUserByMap(Map<String, Object> map);
  int updateUserInfo(UserDto userDto) throws Exception;
  
}
