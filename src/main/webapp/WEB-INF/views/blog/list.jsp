<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<jsp:include page="../layout/header.jsp">
   <jsp:param name="title" value="블로그 리스트"/>
</jsp:include>

<style>
  .wrap {
    width: 1060px;
    margin: 40 auto;
  }
  
  h1 {
    text-align: center;
    font-size: 30px;
    margin: 30px auto;
  }
  
  .wrap table {
    border: 0.5px solid black;
    border-collapse: collapse;
    width: 100%;
  }
  
  .wrap thead td {
    text-align: center;
    font-weight: 600;
  }
  
  .wrap td {
    border: 1px solid black;
  }
  
  .number {
    text-aling: right;
  }
  
  .wrap td: nth-of-type(1) {width: 60px; }
  .wrap td: nth-of-type(2) {width: 60px; }
  .wrap td: nth-of-type(3) {width: 200px; }
  .wrap td: nth-of-type(4) {width: 100px; }
  .wrap td: nth-of-type(5) {width: 400px; }
  .wrap td: nth-of-type(6) {width: 10px; }
  .wrap td: nth-of-type(7) {width: 10px; }
  
  .page {
    border:none;
  }
  
  .blogs:hover{
    cursur: pointer;
    background-color : #FCF9B4;
  }
  
</style>

<h1>Blog List</h1>

<div>
  <button type="button" id="btn-write">새 블로그 작성하기</button>
</div>

<div class="wrap">
  <div style="text-align: right; cursor: pointer;">
    <a href="${contextPath}/blog/list.do?page=1&sort=DESC">최신순</a> | 
    <a href="${contextPath}/blog/list.do?page=1&sort=ASC">과거순</a>
</div>

<table>
  <caption class="number" style="text-align: right;" >총 ${total}개 블로그</caption>

  <thead>
    <tr>
      <td>순번</td>
      <td>작성자</td>
      <td>제목</td>
      <td>내용</td>
      <td>조회수</td>
      <td>수정일시</td>
      <td>작성일시</td>
   </tr>
   </thead>
   
   <tbody>
      <c:forEach items="${blogs}" var="blog" varStatus="vs">
      <tr class="blogs" data-user-id="${blog.userDto.userId}" data-blog-id="${blog.blogId}">
      <td>${offset + vs.count}</td> <!-- count : index + 1 -->
      <td>${blog.userDto.userId}</td>
      <td>${blog.title}</td>
      <td>${blog.contents}</td>
      <td>${blog.hit}</td>
      <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${blog.createDtL}"/></td>
      <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${blog.modifyDtL}"/></td>
      </tr>
      </c:forEach>
   </tbody>
    
   <tfoot>
    <tr>
      <td colspan="7" class="page">${paging}</td>
      </tr>
   </tfoot>
</table>

<script>

  // 블로그 신규 작성
  function toBlogWrite() {
    document.getElementById('btn-write').addEventListener('click', (event) => {
      location.href = '${contextPath}/blog/write.do';
    })
  }
  
  // 블로그 상세 보기
  function toBlogDetail() {
    const blogs = document.getElementsByClassName('blogs');
    for(const blog of blogs) {
      blog.addEventListener('click', (event) => {
        if('${sessionScope.loginUser.userId}' === event.currentTarget.dataset.userId) {
          location.href = '${contextPath}/blog/detail.do?blogId=' + event.currentTarget.dataset.blogId;
        } else {
          locaton.href = '${contextPath}/blog/increaseHit.do?blogId=' + event.currentTarget.dataset.blogId;
        }
      })
    }
  }

  toBlogWrite();
  toBlogDetail();
  
</script>

</div>

</body>
</html>