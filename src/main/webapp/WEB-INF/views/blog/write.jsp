<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>

<jsp:include page="../layout/header.jsp">
   <jsp:param name="title" value="블로그 작성"/>
</jsp:include>

<style>
  #contents {
    width: 70%;
    min-height: 100px;
    margin: 30px auto;
  }
  
   h1 {
    text-align: center;
    font-size: 30px;
    margin: 30px auto;
  }
  
  write_id, title {
   text-align: center;
   margin: 20px;
  }
  
</style>


  <h1>Blog Write</h1>
  
  <form id="form-write" action="${contextPath}/blog/regist.do" method="post">
   
    <span class="write_id">
      <label for="user_id">작성자 아이디</label>
      <input type="text" name="userDto.userId" id="user_id" value="${sessionScope.loginUser.userId}" readonly>
    </span>
    
    <span class="title">
      <label for="title">제목</label>
      <input type="text" name="title" id="title">
    </span>
    
    <div>
      <textarea name="contents" id="contents" placeholder="블로그 내용을 작성해주세요."></textarea>
    </div>
    
    <div>
      <button type="submit">작성 완료</button>
      <button type="reset">입력 초기화</button>
    </div>
 
  </form>
  
  <script>
    // 블로그 작성 시 제목 필수 입력 알럿 노출
    function submitForm() {
      const formWrite = document.getElementById('form-write');
      const userId = document.getElementById('user_id');
      const title = document.getElementById('title');
      formWrite.addEventListener('submit', (event) => {
        if(title.value == '') {
          alert('제목 필수 입력!');
          title.focus();
          event.preventDefault();
          return;
        }
      })
    }
    
    submitForm();
  </script>

</body>
</html>