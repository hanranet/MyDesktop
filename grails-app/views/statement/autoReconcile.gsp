<%@ page import="com.hanranet.mydesktop.statements.Statement" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'statement.label', default: 'Statement')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<asset:javascript src="application.js"/>
        <asset:stylesheet src="application.css"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
        <style>
        		label, input { display:block; }
        		input.text { margin-bottom:12px; width:95%; padding: .4em; }
        		fieldset { padding:0; border:0; margin-top:25px; }
        		h1 { font-size: 1.2em; margin: .6em 0; }
        		div#users-contain { width: 350px; margin: 20px 0; }
        		div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
        		div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
        		.ui-dialog .ui-state-error { padding: .3em; }
        		.validateTips { border: 1px solid transparent; padding: 0.3em; }
        </style>
        <script>
            $( document ).ready(function() {
                $("#myLink").click(function(e) {
                    var me = $(this), data = me.data('key');

                    var payee = data.payee;
                    $('#modalPayee').val(payee);
                    var debit = data.debit;
                    $('#modalDebit').val(debit);
                    var credit = data.credit;
                    $('#modalCredit').val(credit);
                    var date = data.date;
                    $('#datepicker').val($.date(date));

                    jQuery.noConflict();
                    $('#addReceiptDialog').modal();
                });

                $.date = function(dateObject) {
                    var d = new Date(dateObject);
                    var day = d.getDate();
                    var month = d.getMonth() + 1;
                    var year = d.getFullYear();
                    if (day < 10) {
                        day = "0" + day;
                    }
                    if (month < 10) {
                        month = "0" + month;
                    }
                    var date = month + "/" + day + "/" + year;

                    return date;
                };
            });
        </script>

	</head>
	<body>
        <div id="addReceiptDialog" class="modal" title="Create new receipt">
        <form action="/receipt/autoReconcileSave" method="post" >
         	 <div class="modal-body">
                <table>
                    <tr>
                        <td><b>Date:</b></td>
                        <td><input type="text" name="date" value="" size="10" autocomplete="off" id="datepicker"></td>
                    </tr>
                    <tr>
                        <td><b>Payee:</b></td>
                        <td><input type="text" name="payee" id="modalPayee" value="" size="30" autocomplete="off"></td>
                    </tr>
                    <tr>
                        <td><b>Category:</b></td>
                        <td><g:select optionKey="name" optionValue="name" name="category" from="${categoryList}" noSelection="['':'-Select a category-']"/></td>
                    </tr>
                    <tr>
                        <td><b>Debit:</b></td>
                        <td><input type="text" name="debit" id="modalDebit" value="" autocomplete="off"></td>
                    </tr>
                    <tr>
                        <td><b>Credit:</b></td>
                        <td><input type="text" name="credit" id="modalCredit" value="" autocomplete="off"></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center"><input type="submit" name="create" class="save" value="Create" id="create" /></td>
                    </tr>
                </table>
                <!-- Hidden form fields required for save -->
                <input type="hidden" name="owner" value="thanrahan">
                <input type="hidden" name="createUser" value="thanrahan">
                <input type="hidden" name="updateUser" value="thanrahan">
             </div>
        </form>
        </div>

		<a href="#edit-statement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="edit-statement" class="content scaffold-edit" role="main">
			<h1>Automatic Reconciliation</h1>
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
			
			<g:uploadForm action="autoReconcile" method="post" enctype="multipart/form-data">
			
			<table>
				<!-- SNIP -->
				<tr>
					<td><label for="file">File:</label></td>
					<td><input type="file" id="file" name="file" /></td>
				</tr>
			</table>

 			<fieldset class="buttons">
					<g:actionSubmit class="save" action="autoReconcile" value="Upload File"/>
				</fieldset>
			</g:uploadForm>
		</div>
<g:if test="${inSession}">
	<table>
		<tr>
			<td>
				<table border="1">
					<thead>
						<tr>
							<th colspan="6">Receipts that need to be added to My Desktop</th>
						</tr>
						<tr>
							<th>Date</th>
							<th>Chk#</th>
							<th>Payee</th>
							<th>Debit</th>
							<th>Credit</th>
							<th>&nbsp</th>
						</tr>
					</thead>
					<tbody>

						<g:if test="${csvReceiptList}">
							<g:each in="${csvReceiptList}" var="c">
								<tr>
									<td><g:formatDate format="MM/dd/yyyy" date="${c.date}" /></td>
									<td><g:if test="${c.checkNo > 0}">${c.checkNo}</g:if><g:else>&nbsp;</g:else></td>
									<td>${c.payee}</td>
									<td><g:formatNumber number="${c.debit}" type="currency" currencyCode="USD" /></td>
									<td><g:formatNumber number="${c.credit}" type="currency" currencyCode="USD" /></td>
									<td><a id='myLink' href='#' data-key='{"payee":"${c.payee}", "debit":"${c.debit}", "credit":"${c.credit}", "date":"${c.date}"}' >Add</a></td>
								</tr>
							</g:each>
						</g:if>
						<g:else>
							<tr>
								<td colspan="6">There are no receipts.</td>
							</tr>
						</g:else>

					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table border="1">
					<thead>
						<tr>
							<th colspan="6">Receipts in My Desktop that have not cleared the bank</th>
						</tr>
						<tr>
							<th>Date</th>
							<th>Chk#</th>
							<th>Payee</th>
							<th>Debit</th>
							<th>Credit</th>
							<th>&nbsp</th>
						</tr>
					</thead>
					<tbody>

						<g:if test="${mydReceiptList}">
							<g:each in="${mydReceiptList}" var="c">
								<tr>
									<td><g:formatDate format="MM/dd/yyyy" date="${c.date}" /></td>
									<td><g:if test="${c.checkNo > 0}">${c.checkNo}</g:if><g:else>&nbsp;</g:else></td>
									<td>${c.payee}</td>
									<td><g:formatNumber number="${c.debit}" type="currency" currencyCode="USD" /></td>
									<td><g:formatNumber number="${c.credit}" type="currency" currencyCode="USD" /></td>
									<td><g:link onClick="if(!confirm('Are you sure you want to delete this receipt?')) { return false; }" controller="Receipt" action="delete" id="${c.id}">Delete</g:link></td>
								</tr>
							</g:each>
						</g:if>
						<g:else>
							<tr>
								<td colspan="6">There are no receipts.</td>
							</tr>
						</g:else>

					</tbody>
				</table>
			</td>
		</tr>
	</table>
</g:if>
</body>
</html>
