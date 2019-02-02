<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receipt.label', default: 'Receipt')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#create-receipt" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="create-receipt" class="content scaffold-create" role="main">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.receipt}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.receipt}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
                       <form action="/receipt/save" method="post" >
                           <fieldset class="form">
                               <div class='fieldcontain'>
                                   <label for='checkNo'>Check No</label><input type="number" name="checkNo" value="" id="checkNo" />
                               </div>
                               <div class='fieldcontain required'>
                                   <label for='date'>Date
                                       <span class='required-indicator'>*</span>
                                   </label>
                                   <input type="text" name="date" value="${receipt.date}" size="10"  autocomplete="off" id="datepicker"></p>
                               </div>
                               <div class='fieldcontain required'>
                                   <label for='payee'>Payee
                                       <span class='required-indicator'>*</span>
                                   </label>
                                   <input type="text" name="payee" value="" required="" id="payee" />
                               </div>
                               <div class='fieldcontain'>
                                   <label for='category'>Category</label>
                                   <g:select optionKey="name" optionValue="name" name="category" from="${categoryList}" noSelection="['':'-Select a category-']"/>
                               </div>
                               <div class='fieldcontain'>
                                   <label for='debit'>Debit</label>
                                   <input type="number decimal" name="debit" value="" id="debit" />
                               </div>
                               <div class='fieldcontain'>
                                   <label for='credit'>Credit</label>
                                   <input type="number decimal" name="credit" value="" id="credit" />
                               </div>
                               <div class='fieldcontain'>
                                   <label for='memo'>Memo</label>
                                   <input type="text" name="memo" value="" id="memo" />
                               </div>
                               <!--todo remove these hard coded items -->
                               <input type="hidden" name="owner" value="" />
                               <input type="hidden" name="createUser" value="" />
                               <input type="hidden" name="updateUser" value="" />
                           </fieldset>
                           <fieldset class="buttons">
                               <input type="submit" name="create" class="save" value="Create" id="create" />
                           </fieldset>
                       </form>

        </div>
    </body>
</html>
