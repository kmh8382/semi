<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Notice Search</title>
</head>
<body>

  <h1>Search</h1>
  <div>
    <form action="${contextPath}/notice/search.do">
      <div><input type="text" name="noticeTitle" placeholder="제목검색"></div>
      <div><input type="text" name="noticeContents" placeholder="내용검색"></div>
      <div><input type="date" name="beginDt"> - <input type="date" name="endDt"></div>
      <div><button type="submit">검색</button></div>
    </form>
  </div>
  
  <div>
  <c:if test="${empty searchList}">
    <div>검색 결과 없음</div>
  </c:if>
  <c:if test="${not empty searchList}">
    <div>검색 결과 ${searchList}개</div>
    <c:forEach items="${searchList}" var="n" varStatus="vs">
      <div class="notices" data-notice-id="${n.noticeId}">
        ${offset +vs.count} | ${n.noticeTitle}(${n.attachCount}) ... <fmt:formatDate value="${n.createdAt}" pattern="yyyy.MM.dd HH:mm:ss"/>
      </div>
    </c:forEach>
    <div>${paging}</div>
  </c:if>
  </div>
  <script>
    function detailHandle() {
      const notices = document.getElementsClassName('notices');
      for(const notice of notices) {
        notice.addEventListener('click', (event) => {
          lacation.href = '${contextPath}/notice/detail.do?noticeId=' + event.currentTarget.dataset.noticeId;
        })
      }
    }
    detailHandle();
  </script>
</body>
</html>