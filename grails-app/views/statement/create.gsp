<%@ page import="com.hanranet.mydesktop.statements.Statement" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'statement.label', default: 'Statement')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<style media="screen" type="text/css">
			.yellowBackground{
				background-color:yellow;
			}
		</style>
	</head>
	<body>

	<script>

		$(document).ready(function() {

			function recalculateCredits(){
			    var sum = 0;

			    $("input[name='creditReceipts']:checked").each(function(){
			      sum += parseFloat($(this).attr("rel"));
			    });

			    $("#paymentsAndChecks").val(sum.toFixed(2));

			}

			function recalculateDebits(){
			    var sum = 0;

			    $("input[name='debitReceipts']:checked").each(function(){
				    sum += parseFloat($(this).attr("rel"));
			    });

			    $("#deposits").val(sum.toFixed(2));
			}

			function recalculateDifference(){

				var beginBalance= +$("#beginBalance").val();
				var paymentsAndChecks = +$("#paymentsAndChecks").val();
				var deposits = +$("#deposits").val();
		        var endingBalance = +$("#endingBalance").val();
				var clearedBalance = beginBalance + paymentsAndChecks + deposits;
				var difference = endingBalance - clearedBalance;

			    $("#difference").val(difference.toFixed(2));

			}

		    $("input[type=checkbox]").change(function() {
		        if($(this).is(":checked")){
		            $(this).parents("tr:first").addClass("yellowBackground");
		        }else{
		            $(this).parents("tr:first").removeClass("yellowBackground");
		        }
		        recalculateCredits();
		        recalculateDebits();
		        recalculateDifference();
		    });

		    $('#endingBalance').keyup(function () {
		        var beginBalance= $("#beginBalance").val();
		        var endingBalance = $("#endingBalance").val();

		        var difference= endingBalance - beginBalance;
		        $('#difference').html(difference);

		    });

		    $('#startingBalance').keyup(function () {
		        var beginBalance= $("#beginBalance").val();
		        var endingBalance = $("#endingBalance").val();

		        var difference= endingBalance - beginBalance;
		        $('#difference').html(difference);

		    });
		});
		</script>

		<a href="#edit-statement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="edit-statement" class="content scaffold-edit" role="main">
			<h1>Statement Reconciliation</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${statementInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${statementInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" >
				<g:hiddenField name="id" value="${statementInstance?.id}" />
				<g:hiddenField name="version" value="${statementInstance?.version}" />
				<g:hiddenField name="owner" value="thanrahan" />
				<fieldset class="form">

				<div class="fieldcontain ${hasErrors(bean: statementInstance, field: 'name', 'error')} ">
					<label for="name"> <g:message code="statement.name.label" default="Name" /></label>
					<g:textField name="name" value="${statementInstance?.name}"  autocomplete="off" />
				</div>

				<div class="fieldcontain ${hasErrors(bean: statementInstance, field: 'beginDate', 'error')} required">
					<label for="beginDate"> <g:message code="statement.beginDate.label" default="Begin Date" />
						<span class="required-indicator">*</span>
					</label>
					<g:datePicker name="beginDate" precision="day" value="${statementInstance?.beginDate}" />
				</div>

				<div class="fieldcontain ${hasErrors(bean: statementInstance, field: 'endingDate', 'error')} required">
					<label for="endingDate">
						<g:message	code="statement.endingDate.label" default="Ending Date" />
						<span class="required-indicator">*</span>
					</label>
					<g:datePicker name="endingDate" precision="day"	value="${statementInstance?.endingDate}" />
				</div>

				<div class="fieldcontain ${hasErrors(bean: statementInstance, field: 'beginBalance', 'error')} required">
					<label for="beginBalance">
						<g:message code="statement.beginBalance.label" default="Begin Balance" />
						<span class="required-indicator">*</span>
					</label>
					<g:field type="text" name="beginBalance" required="" value="${statementInstance?.beginBalance}" />
				</div>

				<div class="fieldcontain ${hasErrors(bean: statementInstance, field: 'endingBalance', 'error')} required">
					<label for="endingBalance">
						<g:message code="statement.endingBalance.label" default="Ending Balance" />
						<span class="required-indicator">*</span>
					</label>
					<g:field type="text" name="endingBalance" required="" value="${fieldValue(bean: statementInstance, field: 'endingBalance')}" />
				</div>

				<div class="fieldcontain">
					<label for="paymentsAndChecks">
						<g:message code="statement.paymentsAndChecks.label" default="Payments and Checks" />
					</label>
					<g:field type="text" name="paymentsAndChecks" required="" value="" id="paymentsAndChecks" disabled="true"/>
				</div>

				<div class="fieldcontain">
					<label for="deposits">
						<g:message code="statement.deposits.label" default="Deposits" />
					</label>
					<g:field type="text" name="deposits" required="" value="" id="deposits" disabled="true"/>
				</div>

				<div class="fieldcontain">
					<label for="difference">
						<g:message code="statement.difference.label" default="Difference" />
					</label>
					<g:field type="text" name="difference" required="" value="" id="difference" disabled="true"/>
				</div>

			</fieldset>

			<table>
						<tr>
						<td>
							<table border="1">
							<thead>
								<tr>
									<th colspan="5">Payments and Checks</th>
								</tr>
								<tr>
									<th>Date</th>
									<th>Chk#</th>
									<th>Payee</th>
									<th>Amount</th>
									<th>&nbsp</th>
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
											<td><input type="checkbox" name="creditReceipts" value="${c.id}" rel="${c.reconcileAmount}"></td>
										</tr>
									</g:each>
								</g:if>
								<g:else>
     								<tr>
										<td colspan="5">There are no receipts.</td>
									</tr>
								</g:else>

								</tbody>
							</table>
						</td>
						<td>
							<table border="1">
							<thead>
								<tr>
									<th colspan="5">Deposits</th>
								</tr>
								<tr>
									<th>Date</th>
									<th>Chk#</th>
									<th>Payee</th>
									<th>Amount</th>
									<th>&nbsp;</th>
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
											<td><input type="checkbox" name="debitReceipts" value="${d.id}" rel="${d.reconcileAmount}"></td>
										</tr>
									</g:each>
								</g:if>
								<g:else>
     								<tr>
										<td colspan="5">There are no receipts.</td>
									</tr>
								</g:else>

								</tbody>
							</table>
						</td>
					</tr>
				</table>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="save" value="${message(code: 'default.button.reconcile.label', default: 'Reconcile')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
