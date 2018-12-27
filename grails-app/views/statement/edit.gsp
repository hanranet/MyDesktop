<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'statement.label', default: 'Statement')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-statement" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-statement" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.statement}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.statement}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form resource="${this.statement}" method="PUT">
                <g:hiddenField name="version" value="${this.statement?.version}" />

                <fieldset class="form">
                    <div class='fieldcontain required'>
  <label for='owner'>Owner
    <span class='required-indicator'>*</span>
  </label><input type="text" name="owner" value="thanrahan" required="" id="owner" />
</div><div class='fieldcontain required'>
  <label for='name'>Name
    <span class='required-indicator'>*</span>
  </label><input type="text" name="name" value="September 2018" required="" id="name" />
   </div>

   <div class='fieldcontain required'>
        <label for='beginDate'>Begin Date<span class='required-indicator'>*</span></label>
        <input type="text" name="beginDate" value="${beginDate}" size="10"  autocomplete="off" id="datepicker"></input>
   </div>
   <div class='fieldcontain required'>
        <label for='endingDate'>Ending Date<span class='required-indicator'>*</span></label>
        <input type="text" name="endingDate" value="${endingDate}" size="10"  autocomplete="off" id="datepicker"></input>
   </div>

<div class='fieldcontain required'>
  <label for='beginBalance'>Begin Balance
    <span class='required-indicator'>*</span>
  </label><input type="number decimal" name="beginBalance" value="0.00" required="" id="beginBalance" />
</div><div class='fieldcontain required'>
  <label for='endingBalance'>Ending Balance
    <span class='required-indicator'>*</span>
  </label><input type="number decimal" name="endingBalance" value="4000.00" required="" id="endingBalance" />
</div><div class='fieldcontain'>
  <label for='creditReceipt'>Credit Receipt</label><ul></ul><a href="/creditReceipt/create?statement.id=1">Add CreditReceipt</a>
</div><div class='fieldcontain'>
  <label for='debitReceipt'>Debit Receipt</label><ul></ul><a href="/debitReceipt/create?statement.id=1">Add DebitReceipt</a>
</div>
                </fieldset>

                <fieldset class="buttons">
                    <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>