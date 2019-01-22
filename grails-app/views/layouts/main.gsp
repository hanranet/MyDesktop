<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="jquery-ui.js"/>
    <asset:javascript src="jquery-1.12.4.js"/>
    <asset:stylesheet src="jquery-ui.css"/>
    <script>
      $( function() {
        $( "#datepicker" ).datepicker();
      } );
    </script>
    <g:layoutHead/>
</head>
<body>

    <div class="navbar navbar-default navbar-static-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/#">
                    <i class="fa grails-icon">
                        <asset:image src="grails-cupsonly-logo-white.svg"/>
                    </i> MyDesktop
                </a>
            </div>
            <div class="navbar-collapse collapse" aria-expanded="false" style="height: 0.8px;">
                <ul class="nav navbar-nav navbar-right">
                    <li><g:link controller="Receipt" action="index">Receipts</g:link></li>
                    <li><g:link controller="Item" action="index">Budget</g:link></li>
                    <li><g:link controller="Statement" action="autoReconcile">AutoReconcile</g:link></li>
                    <li><g:link controller="Statement" action="index">Statements</g:link></li>
                    <!--<li><g:link controller="Debt" action="list">Debt Repay</g:link></li>-->
                    <!--<li><g:link controller="DripAccount" action="list">DRIP's</g:link></li>-->
                    <!--<li><g:link controller="DripAccount" action="list">Spending Report</g:link></li> -->
                    <!--<li><g:link controller="DripAccount" action="list">Pay Dates</g:link></li> -->
                </ul>
            </div>
        </div>
    </div>

    <g:layoutBody/>

    <div class="footer" role="contentinfo"></div>

    <div id="spinner" class="spinner" style="display:none;">
        <g:message code="spinner.alt" default="Loading&hellip;"/>
    </div>

    <asset:javascript src="application.js"/>

</body>
</html>
