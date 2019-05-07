<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'PTO.label', default: 'PTO')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#create-PTO" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="create-PTO" class="content scaffold-create" role="main">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.PTO}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.PTO}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <form action="/PTO/save" method="post" >
                <fieldset class="form">
                    <div class='fieldcontain required'>
                        <label for='startDate'>Start Date<span class='required-indicator'>*</span></label>
                        <input type="text" name="startDate" value="" size="10"  autocomplete="off" id="datepicker">
                    </div>
                    <div class='fieldcontain required'>
                      <label for='type'>Type<span class='required-indicator'>*</span></label>
                      <input type="text" name="type" value="" required="" id="type" />
                    </div>
                    <div class='fieldcontain required'>
                      <label for='days'>Days<span class='required-indicator'>*</span></label>
                      <input type="text" name="days" value="" required="" id="days" />
                    </div>
                </fieldset>
                <fieldset class="buttons">
                    <input type="submit" name="create" class="save" value="Create" id="create" />
                </fieldset>
            </form>
        </div>
    </body>
</html>
