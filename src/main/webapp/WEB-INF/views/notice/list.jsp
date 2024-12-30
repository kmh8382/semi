<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title></title>
</head>
<body>

<h1>Notice List</h1>
  
  <div>
    <a href="${contextPath}/notice/write.do">새 공지사항 작성하기</a>
  </div>
  
  <div>
    <a href="${contextPath}/notice/list.do?page=1&sort=DESC">최신순</a> |
    <a href="${contextPath}/notice/list.do?page=1&sort=ASC">과거순</a>
  </div>

  <table border="1">
    <thead>
      <tr>
        <td>공지번호</td>
        <td>내용</td>
        <td>조회수</td>
        <td>작성일시</td>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="n" items="${noticeList}" >
        <tr class="notices" data-notice-id="${n.noticeId}" >
          <td>${n.noticeId}</td>
          <td>${n.noticeTitle}</td>
          <td>(${n.attachCount})...</td>
          <td><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${n.createdAt}"/></td>
        </tr>
      </c:forEach>
    </tbody>
    <tfoot>
      <tr>
        <td colspan="4">${paging}</td>
      </tr>
    </tfoot>
  </table>

  <script>
  
    function detailHandle() {
      const notices = document.getElementsByClassName('notices');
      for(const notice of notices) {
        notice.addEventListener('click', (event) => {
          location.href = '${contextPath}/notice/detail.do?noticeId=' + event.currentTarget.dataset.noticeId;
        })
      }
    }

    function msgHandle() {
      const msg = '${msg}';
      if(msg !== '')
        alert(msg);
    }
    detailHandle();
    msgHandle();
    
  </script>
</body>
</html>