<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'statement.label', default: 'Statement')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-statement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="reconcile" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                <li><g:link class="reconcile" action="autoReconcile">Auto Reconcile</g:link></li>
            </ul>
        </div>
        <div id="list-statement" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table>
                <tbody>
                <g:each in="${statementList}" status="i" var="statementInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td><g:link action="show" id="${statementInstance.id}">${fieldValue(bean: statementInstance, field: "name")}</g:link></td>
                    </tr>
                </g:each>
                </tbody>
            </table>
            <div class="pagination">
                <g:paginate total="${statementInstanceTotal}" />
            </div>
        </div>
    </body>
</html>