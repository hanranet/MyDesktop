<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'item.label', default: 'Item')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>

        <script type="text/javascript">
            function objectAction(objectAction, id)	{
                params = "/" + id;

                if (objectAction == 'Edit') {
                    window.location.href="${createLink(controller:'item' ,action:'edit')}" + params;
                }

                if (objectAction == 'Delete') {

                    var result = confirm("Are you sure you want to delete this item?");
                    if (result==true)
                    {
                        window.location.href="${createLink(controller:'item' ,action:'delete')}" + params;
                    }
                }

                if (objectAction == 'Pay Now') {
                    var result = confirm("Are you sure you want to pay this item?");
                    if (result==true)
                    {
                        window.location.href="${createLink(controller:'item' ,action:'payNow')}" + params;
                    }
                }

            }

            function payDay()	{
                var result = confirm("Are you sure today is PAY DAY?");
                if (result==true)
                {
                    window.location.href="${createLink(controller:'item' ,action:'payDay')}";
                }

            }

        </script>

        <style>
            td {text-align: left;}
         </style>
    </head>
    <body>
        <a href="#list-item" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                <li><a href="#" class="payday" onclick="javascript:payDay();">Pay Day</a></li>
                <li><a href="#" class="report">Spending Report</a></li>
            </ul>
        </div>
        <div id="list-item" class="content scaffold-list" role="main">
            <h1>Budget</h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
        </div>
        <table>
            <thead>
                <tr>
                    <th>Category</th>
                    <th>Name</th>
                    <th class='currency'>Weekly</th>
                    <th class='currency'>Monthly</th>
                    <th class='currency'>Bucket</th>
                    <th>Bill Date</th>
                    <th class='currency'>Bill Amount</th>
                    <th>Memo</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <g:set var="counter" value="${0}" />
                <g:each in="${itemList}" var="item" >
                    <g:set var="style" value="${counter % 2 == 0 ? 'even' : 'odd'}" />
                    <tr class='${style}'>
                        <g:if test="${item.category == 'A'}">
                            <td>Annual Expense</td>
                        </g:if>
                        <g:if test="${item.category == 'U'}">
                            <td>Utilities</td>
                        </g:if>
                        <g:if test="${item.category == 'L'}">
                            <td>Liability</td>
                        </g:if>
                        <td>${item.name}</td>

                        <g:if test="${item.weeklyBucketAmount > 0}">
                            <td class='currency'><g:formatNumber number="${item.weeklyBucketAmount}" type="currency" currencyCode="USD" /></td>
                        </g:if>
                        <g:else>
                            <td>&nbsp;</td>
                        </g:else>

                        <g:if test="${item.monthlyBucketAmount > 0}">
                            <td class='currency'><g:formatNumber number="${item.monthlyBucketAmount}" type="currency" currencyCode="USD" /></td>
                        </g:if>
                        <g:else>
                            <td>&nbsp;</td>
                        </g:else>

                        <td class='currency'><g:formatNumber number="${item.bucketAmount}" type="currency" currencyCode="USD" /></td>

                        <td><g:formatDate format="MM/dd/yyyy" date="${item.billDate}"/></td>

                        <g:if test="${item.billAmount > 0}">
                            <td class='currency'><g:formatNumber number="${item.billAmount}" type="currency" currencyCode="USD" /></td>
                        </g:if>
                        <g:else>
                            <td>&nbsp;</td>
                        </g:else>

                        <td>${item.memo}</td>
                        <td>
                            <g:select name="objectAction"
                                  from="${['Click to Select', 'Edit', 'Delete','Pay Now']}"
                                  value="${params.objectAction}"
                                  onchange="javascript:objectAction(this.value, ${item.id});"/>
                        </td>
                    </tr>
                    <g:set var="counter" value="${counter + 1}" />
                </g:each>

                <tr class='${style}'>
                	<td>&nbsp;</td>
                	<td>&nbsp;</td>
                	<td class='currency'><b><g:formatNumber number="${weeklyTotal}" type="currency" currencyCode="USD" /></b></td>
                	<td class='currency'><b><g:formatNumber number="${monthlyTotal}" type="currency" currencyCode="USD" /></b></td>
                	<td class='currency'><b><g:formatNumber number="${bucketTotal}" type="currency" currencyCode="USD" /></b></td>
                	<td>&nbsp;</td>
                	<td>&nbsp;</td>
                	<td>&nbsp;</td>
                	<td>&nbsp;</td>
                </tr>
                <g:set var="counter" value="${counter + 1}" />
                <tr class='${style}'>
                 	<td>&nbsp;</td>
                 	<td><b>Receipt Balance</b></td>
                    <td>&nbsp;</td>
                	<td>&nbsp;</td>
                	<td class='currency'><b><g:formatNumber number="${receiptBalance}" type="currency" currencyCode="USD" /></b></td>
                	<td colspan="2">&nbsp;</td>
                </tr>
                <g:set var="counter" value="${counter + 1}" />
                <tr class='${style}'>
                  	<td>&nbsp;</td>
                  	<td><b>Difference</b></td>
                  	<td>&nbsp;</td>
                	<td>&nbsp;</td>
                	<td class='currency'><b><g:formatNumber number="${difference}" type="currency" currencyCode="USD" /></b></td>
                	<td>&nbsp;</td>
                	<td>&nbsp;</td>
                </tr>

            </tbody>

        </table>
    </body>
</html>