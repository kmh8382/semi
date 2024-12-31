<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<jsp:include page="../layout/header.jsp">
  <jsp:param name="title" value="공지사항 작성"/>
</jsp:include>
  <h1>Notice Write</h1>
  
  <div>
    <form  id="form-write" action="${contextPath}/notice/regist.do" method="post" enctype="multipart/form-data">
      <input type="hidden" name="userId" value="${sessionScope.loginUser.userId}">
      <input type="text" name="title" placeholder="제목"><br/>
      <textarea rows="5" cols="30" name="contents" placeholder="내용"></textarea><br/>
      <input type="file" name="files" id="files" multiple><br/>
      <button type="submit">작성완료</button>
      <button type="button" id="back-write" >돌아가기</button>
    </form>
  </div>
  
  <script>
    function attachCheck() {
      const files = document.getElementById('files');
      
      // 개별 파일 크기
      const limitPerSize = 1024 * 1024 * 10;
      
      // 전체 파일 크기
      const limitTotalSize = 1024 * 1024 * 100;
      
      // 전체 파일 크기를 저장할 변수
      let totalSize = 0;
      
      files.addEventListener('change', (event) => {
        for(const file of event.currentTarget.files) {
          if(file.size > limitPerSize) {
            alert('각 첨부 파일의 크기는 최대 10MB입니다.');
            event.currentTarget.value = '';
            return; // 이벤트 핸들러 취소
          }
          
          totalSize += file.size;
          
          if(totalSize > limitTotalSize) {
            alert('전체 첨부 파일의 크기는 최대 100MB입니다.');
            event.currentTarget.value = '';
            return;
          }
        }
      })
    }
    
    function backWrite() {
      const backBtn = document.getElementById('back-write');
      backBtn.addEventListener('click', (event) => {
      location.href = '${contextPath}/notice/list.do';
    })
  }
    
    attachCheck();
    backWrite();
  </script>
</div>
</body>
</html>