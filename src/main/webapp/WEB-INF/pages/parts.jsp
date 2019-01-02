<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<html>
<head>
    <title>Parts Page</title>
    <style type="text/css">
        body {
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            overflow: auto;
        }

        .mainTable {
            width: 60%;
            padding: 1%;
            background: white;
            position: absolute;
            top: 15%;
            left: 25%;
            margin: -125px 0 0 -125px;
        }

        #pagination {
            padding: 5px;
        }

        #pagination a:link {
            color: white;
        }

        #pagination a:visited {
            color: white;
        }

        #pagination a:hover {
            color: white;
        }

        #pagination a:active {
            color: white;
        }

        h1 {
            color: white;
            background-color: cornflowerblue;
        }

        a {
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="mainTable">
    <h1 align="center">Склад комплектующих</h1>
    <div>
        <form action="/parts/">
            <input type="text" placeholder="наименование" name="param"/>
            <input type="submit" value="Найти"/>
        </form>
    </div>
    <form action="/parts/">
        Фильтрация:
        <button name="param" type="submit" value="all">Все детали</button>
        <button name="param" type="submit" value="needOnly">Обязательные</button>
        <button name="param" type="submit" value="optionOnly">Опциональные</button>
    </form>
    <c:if test="${!empty listParts}">
        <table border="1" width="100%">
            <thead style="background-color:cornflowerblue; color:white">
            <tr>
                <th width="5%">ID</th>
                <th width="30%">Деталь</th>
                <th width="20%">Необходимость</th>
                <th width="15%">Количество</th>
                <th width="15%">Редактировать</th>
                <th width="15%">Удалить</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listParts}" var="part">
                <tr>
                    <td align="center">${part.id}</td>
                    <td>${part.name}</td>
                    <c:choose>
                        <c:when test="${part.necessary}">
                            <td align="center">да</td>
                        </c:when>
                        <c:otherwise>
                            <td align="center">нет</td>
                        </c:otherwise>
                    </c:choose>
                    <td align="center">${part.count}</td>
                    <td align="center"><a href="<c:url value='/edit/${part.id}'/>">Изменить</a></td>
                    <td align="center"><a href="<c:url value='/remove/${part.id}'/>">Удалить</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <div align="center" id="pagination" style="background-color:cornflowerblue">
        <c:url value="/parts/" var="prev">
            <c:param name="page" value="${page-1}"/>
        </c:url>
        <c:if test="${page > 1}">
            <a href="<c:out value="${prev}" />">Предыдущая</a>
        </c:if>

        <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
            <c:choose>
                <c:when test="${page == i.index}">
                    <span>${i.index}</span>
                </c:when>
                <c:otherwise>
                    <c:url value="/parts/" var="url">
                        <c:param name="page" value="${i.index}"/>
                    </c:url>
                    <a href='<c:out value="${url}" />'>${i.index}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:url value="/parts/" var="next">
            <c:param name="page" value="${page + 1}"/>
        </c:url>
        <c:if test="${page + 1 <= maxPages}">
            <a href='<c:out value="${next}" />'>Следующая</a>
        </c:if>
    </div>
    <div style="margin-top: 7px">
        <p style="display: inline;">Можно собрать ${availableComputers} компьютеров</p>
        <form method="post" action="<c:url value='/add/'/>" style="float: right">
            <button type="submit">Добавить запись</button>
        </form>
    </div>
</div>
</body>
</html>