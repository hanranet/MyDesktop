<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <style>
            .vacation-hours-table {
              display: table;
              width: auto;
              background-color: #eee;
              border: 1px solid #666666;
              border-spacing: 5px; /* cellspacing:poor IE support for  this */
              padding: 10px;
            }
            .vacation-hours-table-row {
              display: table-row;
              width: auto;
              clear: both;
            }
            .vacation-hours-table-col {
              float: left; /* fix for  buggy browsers */
              display: table-column;
              width: 200px;
            }
            .ptobalance {
                text-align: center;
            }
        </style>
    </head>
    <body>

        <a href="#list-vacationBalance" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" controller="PTO" action="create">New PTO Balance</g:link></li>
                <li><g:link class="create" controller="event" action="create">New Event</g:link></li>
            </ul>
        </div>
        <div id="list-event" class="content scaffold-list" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
           <h1>PTO Balance</h1>
           <table>
             <tr>
               <th>Type</th>
               <th>&nbsp;</th>
               <th class="ptobalance">Total Days</th>
               <th class="ptobalance">Days Used</th>
               <th class="ptobalance">Days Left</th>
               <th>&nbsp;</th>
               <th>Action</th>
             </tr>
             <g:set var="counter" value="${0}" />
             <g:each in="${ptoBalanceList}" var="ptoBalance" >
                <g:set var="style" value="${counter % 2 == 0 ? 'even' : 'odd'}" />
                <tr class='${style}'>
                    <td>${ptoBalance.type}</td>
                    <td>&nbsp;</td>
                    <td class="ptobalance">${ptoBalance.days}</td>
                    <td class="ptobalance">${ptoBalance.used}</td>
                    <td class="ptobalance">${ptoBalance.left}</td>
                    <td>&nbsp;</td>
                    <td><a href="/PTO/edit/${ptoBalance.id}">edit</a>&nbsp;|&nbsp;<a href="/PTO/delete/${ptoBalance.id}">delete
                </tr>
                <g:set var="counter" value="${counter + 1}" />
             </g:each>
           </table>
        </div>
        &nbsp;
        <div id="list-event" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <table>
                <thead>
                     <tr>
                         <th>Start Date</th>
                         <th>End Date</th>
                         <th>Type</th>
                         <th>Days</th>
                         <th>Comment</th>
                         <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                     <g:set var="eventCounter" value="${0}" />
                     <g:each in="${eventList}" var="event" >
                        <g:set var="style" value="${eventCounter % 2 == 0 ? 'even' : 'odd'}" />
                        <tr class='${style}'>
                            <td><g:formatDate date="${event.startDate}" format="MM/dd/yyyy"/></g></td>
                            <td><g:formatDate date="${event.endDate}" format="MM/dd/yyyy"/></g></td>
                            <td>${event.type}</td>
                            <td>${event.days}</td>
                            <td>${event.comment}</td>
                            <td><a href="/event/edit/${event.id}">edit</a>&nbsp;|&nbsp;<g:link onClick="if(!confirm('Are you sure you want to delete this event?')) { return false; }" action="delete" id="${event.id}">delete</g:link>
                        </tr>
                        <g:set var="eventCounter" value="${eventCounter + 1}" />
                     </g:each>
                </tbody>
            </table>
        </div>
    </body>
</html>