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
    <style>
        body {
          font-family: "Comic Sans", sans-serif;
        }

        .sidenav {
          width: 130px;
          position: fixed;
          z-index: 1;
          top: 75px;
          left: 10px;
          background: #eee;
          overflow-x: hidden;
          padding: 8px 0;
        }

        .sidenav a {
          padding: 6px 8px 6px 16px;
          text-decoration: none;
          font-size: 15px;
          color: #2196F3;
          display: block;
        }

        .sidenav a:hover {
          color: #064579;
        }

        .main {
          margin-left: 140px; /* Same width as the sidebar + left position in px */
          margin-top: 80px;
          font-size: 15px; /* Increased text to enable scrolling */
          padding: 0px 10px;
        }

       	.greet {
        	  font-family: "Open Sans", "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
        	  color: white;
        	  padding: 10px 10px;
        }

        .greet a {
          	color: white
        }

        @media screen and (max-height: 450px) {
          .sidenav {padding-top: 15px;}
          .sidenav a {font-size: 18px;}
        }
        </style>
        </head>
        <body>

        <div class="navbar navbar-default navbar-fixed-top" role="navigation">
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
                        <sec:ifLoggedIn>
                            <li><g:link controller='logout'>Welcome, ${sec.username()}! [logout]</g:link></li>
                        </sec:ifLoggedIn>
                        <sec:ifNotLoggedIn>
                            <li><g:link controller='login'>[login]</g:link></li>
                        </sec:ifNotLoggedIn>
                    </ul>
                </div>
            </div>
        </div>

        <sec:ifLoggedIn>
           <div class="sidenav">
               <g:link controller="receipt">Receipts</g:link>
               <g:link controller="item">Budget</g:link>
               <g:link controller="statement" action="autoReconcile">Auto-Reconcile</g:link>
               <g:link controller="statement">Statements</g:link>
               <g:link controller="user">User</g:link>
           </div>
       </sec:ifLoggedIn>

       <div class="main">
         <g:layoutBody/>
       </div>
    </div>

    <div class="footer" role="contentinfo"></div>

    <div id="spinner" class="spinner" style="display:none;">
        <g:message code="spinner.alt" default="Loading&hellip;"/>
    </div>

    <asset:javascript src="application.js"/>

</body>
</html>
