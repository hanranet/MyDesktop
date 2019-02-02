<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receipt.label', default: 'Receipt')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-receipt" class="content scaffold-list" role="main">
            <h1>Quick Add</h1>
            <g:render template="quickForm"/>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table>
                <thead>
                     <tr>
                        <th>ChkNo</th>
                        <th>Date</th>
                        <th>Payee</th>
                        <th>Category</th>
                        <th class="currency">Debit</th>
                        <th class="currency">Credit</th>
                        <th class="currency">Balance</th>
                        <th>&nbsp;</th>
                    </tr>
                </thead>
                <tbody>
                    <g:set var="counter" value="${0}" />
                    <g:each in="${receiptList}" var="receipt" >
                        <g:set var="style" value="${counter % 2 == 0 ? 'even' : 'odd'}" />
                        <tr class='${style}'>
                            <g:if test="${receipt.checkNo > 0}">
                                <td>${receipt.checkNo}</td>
                            </g:if>
                            <g:else>
                                <td>&nbsp;</td>
                            </g:else>
                            <td><g:formatDate date="${receipt.date}" format="MM/dd/yyyy"/></td>
                            <td>${receipt.payee}</td>
                            <td>${receipt.category}</a></td>
                            <g:if test="${receipt.debit > 0}">
                                <td class="currency"><g:formatNumber number="${receipt.debit}" type="currency" currencyCode="USD" /></td>
                            </g:if>
                            <g:else>
                                <td>&nbsp;</td>
                            </g:else>
                            <g:if test="${receipt.credit > 0}">
                                <td class="currency"><g:formatNumber number="${receipt.credit}" type="currency" currencyCode="USD" /></td>
                            </g:if>
                            <g:else>
                                <td>&nbsp;</td>
                            </g:else>
                            <td class="currency"><g:formatNumber number="${receipt.balance}" type="currency" currencyCode="USD" /></td>
                            <td><a href="/receipt/edit/${receipt.id}">edit</a>&nbsp;|&nbsp;<a href="/receipt/delete/${receipt.id}">delete
                        </tr>
                        <g:set var="counter" value="${counter + 1}" />
                    </g:each>
                </tbody>
            </table>
        </div>
    </body>
</html>