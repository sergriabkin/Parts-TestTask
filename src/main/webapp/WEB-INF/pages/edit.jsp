<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>

<html>
<head>
    <title>Edit Page</title>
    <style type="text/css">
        body {
            width: 130%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            overflow: auto;
        }
        .addForm {
            width: 30%;
            padding: 1%;
            background: white;
            position: absolute;
            top: 15%;
            left: 49%;
            margin: -125px 0 0 -125px;
        }
        h1 {
            color: white;
            background-color:cornflowerblue
        }
        a{
            text-decoration: none;
        }
    </style>
</head>

<body>
<div class="addForm" >
    <c:url var="addAction" value="/parts/update"/>
    <form:form action="${addAction}" commandName="part">
        <h1 align="center">
            <c:if test="${!empty part.name}">
                Изменить деталь
            </c:if>
            <c:if test="${empty part.name}">
                Добавить деталь
            </c:if>
        </h1>
        <table border="1" width="100%">
            <thead style="background-color:cornflowerblue; color: white">
            <tr>
                <th width="40%">Поле</th>
                <th width="60%">Значение</th>
            </tr>
            </thead>
            <c:if test="${!empty part.name}">
                <tr>
                    <td>
                        <form:label path="id">
                            <spring:message text="ID"/>
                        </form:label>
                    </td>
                    <td>
                        ${part.id}
                        <form:hidden path="id"/>
                    </td>
                </tr>
            </c:if>
            <tr>
                <td>
                    <form:label path="name">
                        <spring:message text="Деталь"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="name" size="40"/>
                </td>
            </tr>
            <tr>
                <td>
                    <form:label path="necessary">
                        <spring:message text="Обязательна при сборке"/>
                    </form:label>
                </td>
                <td>
                    <select name="necessary">
                        <option <c:if test="${part.necessary}">selected</c:if> value="1">да</option>
                        <option <c:if test="${!part.necessary}">selected</c:if> value="0">нет</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <form:label path="count">
                        <spring:message text="Количество"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="count"/>
                </td>
            </tr>
        </table>
        <br>
        <c:if test="${!empty part.name}">
            <input type="submit" value="<spring:message text="Сохранить"/>"/>
        </c:if>
        <c:if test="${empty part.name}">
            <input type="submit" value="<spring:message text="Добавить"/>"/>
        </c:if>
    </form:form>
    <form method="post" action="<c:url value='/parts/'/>">
        <button type="submit">Назад в список</button>
    </form>
</div>
</body>
</html>
