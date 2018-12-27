<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'statement.label', default: 'Statement')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-statement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
       <div id="show-statement" class="content scaffold-show" role="main">
       			<g:if test="${flash.message}">
       				<div class="message" role="status">${flash.message}</div>
       			</g:if>
       			<ol class="property-list statement">
       				<li class="fieldcontain">
       					<span id="beginDate-label" class="property-label">
       						<g:message code="statement.beginDate.label" default="Beginning Date" />
       					</span>
       					<span class="property-value" aria-labelledby="beginDate-label">
       						<g:formatDate format="MM/dd/yyyy" date="${statementInstance?.beginDate}" />
       					</span>
       				</li>
       				<li class="fieldcontain">
       					<span id="endingDate-label" class="property-label">
       						<g:message code="statement.endingDate.label" default="Ending Date" />
       					</span>
       					<span class="property-value" aria-labelledby="endingDate-label">
       						<g:formatDate format="MM/dd/yyyy" date="${statementInstance?.endingDate}" />
       					</span>
       				</li>
       				<li class="fieldcontain">
       					<span id="beginBalance-label" class="property-label">
       						<g:message code="statement.beginBalance.label" default="Beginning Balance" />
       					</span>
       					<span class="property-value" aria-labelledby="beginBalance-label">
       						<g:formatNumber number="${statementInstance.beginBalance}" type="currency" currencyCode="USD" />
       					</span>
       				</li>
       				<li class="fieldcontain">
       					<span id="endingBalance-label" class="property-label">
       						<g:message code="statement.endingBalance.label" default="Ending Balance" />
       					</span>
       					<span class="property-value" aria-labelledby="endingBalance-label">
       						<g:formatNumber number="${statementInstance.endingBalance}" type="currency" currencyCode="USD" />
       					</span>
       				</li>
       			</ol>
       		</div>

       				<table>
       						<tr>
       						<td>
       							<table border="1">
       							<thead>
       								<tr>
       									<th colspan="4">Payments and Checks</th>
       								</tr>
       								<tr>
       									<th>Date</th>
       									<th>Chk#</th>
       									<th>Payee</th>
       									<th>Amount</th>
       								</tr>
       								</thead>
       								<tbody>

       								<g:if test="${creditReceipts}">
       									<g:each in="${creditReceipts}" var="c">
       										<tr>
       											<td><g:formatDate format="MM/dd/yyyy" date="${c.date}" /></td>
       											<td>
       												<g:if test = "${c.checkNo > 0}">
       													${c.checkNo}
       												</g:if>
       												<g:else>
       													&nbsp;
       												</g:else>
       											</td>
       											<td>${c.payee}</td>
       											<td><g:formatNumber number="${c.credit}" type="currency" currencyCode="USD" /></td>
       										</tr>
       									</g:each>
       								</g:if>
       								<g:else>
            								<tr>
       										<td colspan="4">There are no receipts.</td>
       									</tr>
       								</g:else>

       								</tbody>
       							</table>
       						</td>
       						<td>
       							<table border="1">
       							<thead>
       								<tr>
       									<th colspan="4">Deposits</th>
       								</tr>
       								<tr>
       									<th>Date</th>
       									<th>Chk#</th>
       									<th>Payee</th>
       									<th>Amount</th>
       								</tr>
       								</thead>
       								<tbody>
       								<g:if test="${debitReceipts}">
       									<g:each in="${debitReceipts}" var="d">
       										<tr>
       											<td><g:formatDate format="MM/dd/yyyy" date="${d.date}" /></td>
       											<td>
       												<g:if test = "${d.checkNo > 0}">
       													${d.checkNo}
       												</g:if>
       												<g:else>
       													&nbsp;
       												</g:else>
       											</td>
       											<td>${d.payee}</td>
       											<td><g:formatNumber number="${d.debit}" type="currency" currencyCode="USD" /></td>
       										</tr>
       									</g:each>
       								</g:if>
       								<g:else>
            								<tr>
       										<td colspan="4">There are no receipts.</td>
       									</tr>
       								</g:else>

       								</tbody>
       							</table>
       						</td>
       					</tr>
       				</table>
    </body>
</html>
