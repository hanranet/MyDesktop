<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-event" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-event" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.event}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.event}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <div id="create-event" class="content scaffold-create" role="main">
                            <form action="/event/save" method="post" >
                                <fieldset class="form">
                                    <div class='fieldcontain required'>
                                        <label for='date'>Start Date<span class='required-indicator'>*</span></label>
                                        <input type="text" name="startDate" value="${formatDate(date:event.startDate, format:'MM/dd/yyyy', timeZone:timeZone)}" size="10"  autocomplete="off" id="datepicker">
                                    </div>
                                    <div class='fieldcontain required'>
                                        <label for='days'>Days<span class='required-indicator'>*</span></label>
                                        <input type="number" name="days" value="${event.days}" autocomplete="off" required="" id="days" />
                                    </div>
                                    <div class='fieldcontain required'>
                                        <label for='comment'>Comment<span class='required-indicator'>*</span></label>
                                        <input type="text" name="comment" value="${event.comment}" autocomplete="off" required="" id="comment" />
                                    </div>
                                    <div class='fieldcontain required'>
                                        <label for='type'>Type<span class='required-indicator'>*</span></label>
                                        <g:select optionKey="type" optionValue="type" value="$event.type" name="type" from="${typeList}" noSelection="['':'-Select a type-']"/>
                                    </div>
                                <!--todo remove these hard coded items -->
                                    <input type="hidden" name="owner" value="thanrahan" />
                                    <input type="hidden" name="endDate" value="01/01/2015" />
                                    <input type="hidden" name="id" value="${event.id}" />
                                </fieldset>
                                <fieldset class="buttons">
                                    <input type="submit" name="create" class="save" value="Update" id="create" />
                                </fieldset>
                            </form>
                        </div>
        </div>
    </body>
</html>
