<!DOCTYPE html>
<html>
    <head>
        <g:set var="entityName" value="${message(code: 'item.label', default: 'Item')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <meta charset="utf-8">
        <meta name="layout" content="main">
    </head>
    <body>
        <a href="#create-item" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="create-item" class="content scaffold-create" role="main">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.item}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.item}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <form action="/item/save" method="post">

               <fieldset class="form">

                   <!-- hidden fields -->
                   <input type="hidden" name="owner" value="thanrahan" required="" id="owner" />
                   <input type="hidden" name="createUser" value="thanrahan" required="" id="createUser" />
                   <input type="hidden" name="updateUser" value="thanrahan" required="" id="updateUser" />

                   <div class='fieldcontain required'>
                     <label for='name'>Name
                       <span class='required-indicator'>*</span>
                     </label><input type="text" name="name" value="" required="" id="name" autocomplete="off"/>
                   </div>

                   <div class='fieldcontain'>
                     <label for='monthlyBucketAmount'>Monthly Bucket Amount</label>
                     <input type="number decimal" name="monthlyBucketAmount" value="" id="monthlyBucketAmount" autocomplete="off"/>
                   </div>

                   <div class='fieldcontain'>
                     <label for='bucketAmount'>Bucket Amount</label>
                     <input type="number decimal" name="bucketAmount" value="" id="bucketAmount" autocomplete="off"/>
                   </div>

                   <div class='fieldcontain'>
                     <label for='memo'>Memo</label>
                     <input type="text" name="memo" value="" id="memo" autocomplete="off"/>
                   </div>

                   <div class='fieldcontain'>
                     <label for='category'>Category</label>
                     <g:select name="category" from="${['U', 'A', 'L']}" valueMessagePrefix="item.category" />
                   </div>

                   <div class='fieldcontain required'>
                      <label for='billDate'>Bill Date</label>
                      <input type="text" name="billDate" value="" size="10"  autocomplete="off" id="datepicker"></p>
                  </div>

                   <div class='fieldcontain'>
                     <label for='billPayee'>Bill Payee</label>
                     <input type="text" name="billPayee" value="" id="billPayee" autocomplete="off"/>
                   </div>

                   <div class='fieldcontain'>
                     <label for='billAmount'>Bill Amount</label>
                     <input type="number decimal" name="billAmount" value="" id="billAmount" autocomplete="off"/>
                   </div>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </fieldset>
            </form>
        </div>
    </body>
</html>
