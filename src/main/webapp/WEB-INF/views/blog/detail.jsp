<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<jsp:include page="../layout/header.jsp">
   <jsp:param name="title" value="${blog.title}"/>
</jsp:include>

<style>
  
  h1 {
    text-align: center;
    font-size: 30px;
    margin: 30px auto;
  }

  #contents {
    width: 100%;
    height: 300px;
  }
  
</style>

  <h1>Blog Detail</h1>
  
  <form id = "form-detail" method="post">
    <input type="hidden" name="blogId" value="${blog.blogId}">
    
    <div>작성자 ${blog.userDto.userId}</div>
    <div>작성일시 <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"  value="${blog.createDt}"/></div>
    <div>수정일시 <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"  value="${blog.modifyDt}"/></div>
    <div>조회수 ${blog.hit}</div>
  
    <div>
      <label for="title">제목</label>
      <input type="text" name="title" id="title" value="${blog.title}">
    </div>
  
    <div>
      <textarea name="contents" id="contents" placeholder="내용">${blog.contents}</textarea>
    </div>
    
    <div>
      <button type="reset" id="btn-reset">수정초기화</button>
      <button type="button" id="btn-modify" >수정 완료</button>
      <button type="button" id="btn-remove">블로그 삭제</button>
      <button type="button" id="btn-list">블로그 리스트</button>
    </div>
  </form>
  
  
<div>
    <c:forEach items="${commentList}" var="c" varStatus="k">
      <div>
        <span style="display: inline-block; width: 100px;">${offset + k.count}</span>
        <c:if test="${c.state == 1}">
          <span>삭제된 게시글입니다.</span>
        </c:if>
        <c:if test="${c.state == 0}">
          <!-- 댓글 수준 별 들여쓰기를 공백으로 구현합니다. -->
          <span style="display: inline-block;"><c:forEach begin="1" end="${c.depth}" step="1">&nbsp;&nbsp;</c:forEach></span>
          <!-- 댓글이나 대댓글은 내용 앞에 [Re]를 표시합니다. -->
          <c:if test="${c.depth > 0}">
            <span style="display: inline-block;">[Re]</span>
          </c:if>
          <pre style="display: inline-block; width: 500px;">${c.contents}</pre>
          <span style="display: inline-block;">${c.createDt}</span>
          <span style="display: inline-block;">${c.modifyDt}</span>
          <button type="button" class="btn-form-reply" data-index="${k.index}">댓글달기</button>
          <button type="button" class="btn-delete" data-bbs-id="${c.commentId}">삭제</button>
        </c:if>
      </div>
      <div class="form-reply hidden show${k.index}">
        <form action="${contextPath}/blog/detail.do?blogId=" method="post">
          <!-- 원글의 depth, group_id, group_order를 포함해야 합니다. -->
          <input type="hidden" name="depth" value="${c.depth}">
          <input type="hidden" name="groupId" value="${c.groupId}">
          <input type="hidden" name="groupOrder" value="${c.groupOrder}">
          <textarea rows="5" cols="30" name="contents" placeholder="작성하려면 로그인 해 주세요."></textarea><br/>
          <button type="submit">작성완료</button>
        </form>
      </div>
    </c:forEach>
  </div>
  
  <script>
      const formDetail = document.getElementById('form-detail');
    
    // 블로그 수정
    function submitForm() {
      const title = document.getElementById('title');
      document.getElementById('btn-modify').addEventListener('click', (event) => {
        if(title.value === '') {
          alert('제목 필수 입력!');
          title.focus();
          return;
        }
        formDetail.action = '${contextPath}/blog/modify.do';
        formDetail.submit();
      })
    }
    
    // 블로그 삭제
    function deleteBlog() {      
      document.getElementById('btn-remove').addEventListener('click', (event) => {
        if(confirm('현재 블로그를 삭제할까요?')) {        
          formDetail.action = '${contextPath}/blog/remove.do';
          formDetail.submit();
        }
      })
    }
    
    // 블로그 리스트로 돌아가기
    function toBlogList() {
      document.getElementById('btn-list').addEventListener('click', (event) => {
        location.href= '${contextPath}/blog/list.do';
      }) 
    }
    
    // 블로그 작성자에 따른 디테일 버튼 유무 (블로그 작성자만 수정 및 삭제 가능하도록)
    function BlogDetail() {
      const loggedInUserId = '${sessionScope.loginUser.userId}';
      
      const btnreset = document.getElementById('btn-reset');
      const btnmodify = document.getElementById('btn-modify');
      const btnremove = document.getElementById('btn-remove');
        
      if(loggedInUserId === '${blog.userDto.userId}') {
        btnreset.style.display = 'block';
        btnmodify.style.display = 'block';
        btnremove.style.display = 'block';
        
      } else {
        btnreset.style.display = 'none';
        btnmodify.style.display = 'none';
        btnremove.style.display = 'none';
      }
    }
    
    function displayFormReply() {
      const btnFormReply = document.getElementsByClassName('btn-form-reply');
      for(const btn of btnFormReply) {
        btn.addEventListener('click', (event) => {
          hiddenAllFormReply();  // 모든 댓글 입력 폼을 숨깁니다. 
          const target = event.currentTarget.parentElement.nextElementSibling;  // 화면에 표시할 댓글 입력 폼입니다.
          target.classList.remove('hidden');  // 화면에 표시할 댓글 입력 폼의 class="hidden" 속성을 없앱니다.
        })
      }
    }
    
    submitForm();
    deleteBlog();
    toBlogList();
    BlogDetail();
    displayFormReply();
  </script>
  
  

</body>
</html>