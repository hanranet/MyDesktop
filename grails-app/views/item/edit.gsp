<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'item.label', default: 'Item')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <asset:javascript src="jquery-ui.js"/>
        <asset:javascript src="jquery-1.12.4.js"/>
        <asset:stylesheet src="jquery-ui.css"/>
        <script>
          $( function() {
            $( "#datepicker" ).datepicker();
          } );
        </script>
    </head>
    <body>
        <a href="#create-item" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-item" class="content scaffold-create" role="main">
            <h1>Edit Item</h1>
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
            <form action="/item/update" method="post" id="${item.id}">
               <fieldset class="form">
                   <!-- hidden fields -->
                   <input type="hidden" name="owner" value="thanrahan" required="" id="owner" />
                   <input type="hidden" name="updateUser" value="thanrahan" required="" id="updateUser" />
                   <input type="hidden" name="id" value="${item.id}" />

                   <div class='fieldcontain required'>
                     <label for='name'>Name
                       <span class='required-indicator'>*</span>
                     </label><input type="text" name="name" value="${item.name}" required="" id="name" autocomplete="off"/>
                   </div>

                   <div class='fieldcontain'>
                     <label for='monthlyBucketAmount'>Monthly Bucket Amount</label>
                     <input type="number decimal" name="monthlyBucketAmount" value="${item.monthlyBucketAmount}" id="monthlyBucketAmount" autocomplete="off"/>
                   </div>

                   <div class='fieldcontain'>
                     <label for='bucketAmount'>Bucket Amount</label>
                     <input type="number decimal" name="bucketAmount" value="${item.bucketAmount}" id="bucketAmount" autocomplete="off"/>
                   </div>

                   <div class='fieldcontain'>
                     <label for='memo'>Memo</label>
                     <input type="text" name="memo" value="${item.memo}" id="memo" autocomplete="off"/>
                   </div>

                   <div class='fieldcontain required'>
                       <label for='billDate'>Bill Date</label>
                       <input type="text" name="billDate" size="10" value="${formatDate(date:item.billDate, format:'MM/dd/yyyy', timeZone:timeZone)}" id="datepicker" autocomplete="off"></p>
                   </div>

                   <div class='fieldcontain'>
                     <label for='billPayee'>Bill Payee</label>
                     <input type="text" name="billPayee" value="${item.billPayee}" id="billPayee" autocomplete="off"/>
                   </div>

                   <div class='fieldcontain'>
                     <label for='billAmount'>Bill Amount</label>
                     <input type="number decimal" name="billAmount" value="${item.billAmount}" id="billAmount" autocomplete="off"/>
                   </div>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="update" class="save" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </form>
        </div>
    </body>
</html>
