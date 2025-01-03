<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.css" integrity="sha512-kJlvECunwXftkPwyvHbclArO8wszgBGisiLeuDFwNM8ws+wKIw0sv1os3ClWZOcrEB2eRXULYUsm8OVRGJKwGA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="${contextPath}/assets/css/noticeList.css?dt=<%=System.currentTimeMillis()%>">
<jsp:include page="../layout/header.jsp">
  <jsp:param name="title" value="공지사항"/>
</jsp:include>


  <div class="front-list">
    <h1>Notice List</h1>
    
    <div>
      <button type="button" id="btn-notice"> 새 공지사항 작성하기</button>
    </div>
    
    <div>
      <button type="button"  id="btn-search"><i class="ri-chat-search-fill"></i>검색</button>
    </div>
    
    <div>
      <select id="sort-column">
        <option value="notice_id">작성일자</option>
        <option value="title">제목</option>
      </select>
      <button type="button" class="btn-sort" data-sort="ASC">오름차순</button>
      <button type="button" class="btn-sort" data-sort="DESC">내림차순</button>
    </div>
  
     <div>전체 공지 ${total}개</div>
    
    <table border="1">
      <thead>
        <tr>
          <td>공지번호</td>
          <td>제목</td>
          <td>파일수</td>
          <td>작성일시</td>
          <td>수정일시</td>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="n" items="${noticeList}" >
          <tr class="notices" data-notice-id="${n.noticeId}" >
            <td>${n.noticeId}</td>
            <td>${n.title}</td>
            <td>(${n.attachCount})...</td>
            <td><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${n.createDt}"/></td>
            <td><fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${n.modifyDt}"/></td>
          </tr>
        </c:forEach>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="5">${paging}</td>
        </tr>
      </tfoot>
    </table>
  </div>
  
  <script>
  
    function detailHandle() {
      const notices = document.getElementsByClassName('notices');
      for(const notice of notices) {
        notice.addEventListener('click', (event) => {
          location.href = '${contextPath}/notice/detail.do?noticeId=' + event.currentTarget.dataset.noticeId;
        })
      }
    }
    
    function sortList() {
      const btnSort = document.getElementsByClassName('btn-sort');
      for(const btn of btnSort) {
        btn.addEventListener('click', (event) => {
          location.href = '${contextPath}/notice/list.do?page=1&sort=' + event.target.dataset.sort + '&column=' + document.getElementById('sort-column').value;
        })
      }
    }
    
    function selectOption() {
      const paramColumn = '${param.column}';
      if(paramColumn !== '')
        document.getElementById('sort-column').value=paramColumn;
    }
    
    function toNoticeWrite() {
      document.getElementById('btn-notice').addEventListener('click', (event) => {
        location.href = '${contextPath}/notice/write.do';
      })
    }
    
    function toNoticeSearch() {
      document.getElementById('btn-search').addEventListener('click', (event) => {
        location.href = '${contextPath}/notice/search.form';
      })
    }
    
    detailHandle();
    sortList();
    selectOption();
    toNoticeWrite();
    toNoticeSearch();
    
  </script>

</div>
</body>
</html>