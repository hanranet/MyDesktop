<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receipt.label', default: 'Receipt')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-receipt" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-receipt" class="content scaffold-edit" role="main">
            <h1>Edit Receipt</h1>
            <form action="/receipt/update" method="post" id="${receipt.id}>
                <fieldset class="form">
                    <div class='fieldcontain'>
                        <label for='checkNo'>Check No</label><input type="number" name="checkNo" value="${receipt.checkNo}" id="checkNo" />
                    </div>
                    <div class='fieldcontain required'>
                        <label for='date'>Date
                            <span class='required-indicator'>*</span>
                        </label>
                        <input type="text" name="date" value="${formatDate(date:receipt.date, format:'MM/dd/yyyy', timeZone:timeZone)}" size="10"  autocomplete="off" id="datepicker"></p>
                    </div>
                    <div class='fieldcontain required'>
                        <label for='payee'>Payee
                            <span class='required-indicator'>*</span>
                        </label>
                        <input type="text" name="payee" value="${receipt.payee}" required="" id="payee" />
                    </div>
                    <div class='fieldcontain'>
                        <label for='category'>Category</label>
                        <g:select optionKey="name" optionValue="name" value="$receipt.category" name="category" from="${categoryList}" noSelection="['':'-Select a category-']"/>
                    </div>
                    <div class='fieldcontain'>
                        <label for='debit'>Debit</label>
                        <input type="number decimal" name="debit" value="${receipt.debit}" id="debit" />
                    </div>
                    <div class='fieldcontain'>
                        <label for='credit'>Credit</label>
                        <input type="number decimal" name="credit" value="${receipt.credit}" id="credit" />
                    </div>
                    <div class='fieldcontain'>
                        <label for='memo'>Memo</label>
                        <input type="text" name="memo" value="${receipt.memo}" id="memo" />
                    </div>
                    <input type="hidden" name="owner" value="thanrahan" />
                    <input type="hidden" name="createUser" value="thanrahan" />
                    <input type="hidden" name="updateUser" value="thanrahan" />
                    <input type="hidden" name="id" value="${receipt.id}" />
                </fieldset>
                <fieldset class="buttons">
                    <input type="submit" name="update" class="update" value="Save" id="edit" />
                </fieldset>
            </form>
            </div>
        </div>
    </body>
</html>
