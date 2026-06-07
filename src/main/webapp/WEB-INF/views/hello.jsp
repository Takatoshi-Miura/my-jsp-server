<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <h1>Hello!</h1>
    <%-- EL式でServletからのデータを表示（スクリプトレット不使用） --%>
    <p>メッセージ: <c:out value="${message}" /></p>
    <a href="${pageContext.request.contextPath}/">← トップへ戻る</a>
</body>
</html>
