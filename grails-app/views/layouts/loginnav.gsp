<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
%{--    <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>--}%
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"/>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <asset:stylesheet src="loginpage.css"/>
    <asset:javascript src="loginpage.js" />
    <asset:stylesheet src="navbar.css"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
    <title><g:layoutTitle default="Home Page"/></title>
    <g:layoutHead/>
</head>

<body>
<g:uploadForm url="[controller:'resources',action:'searchPage']">
    <nav class="navbar navbar-expand-lg navbar-light bg-light" >
        <div class="nav-division">
            <div>
                <h4><a class="btn btn-outline-success my-2 my-sm-0" href="${createLink(controller: 'loginPage',action: 'index')}">Link Sharing <span class="sr-only">(current)</span></a></h4>
            </div>

            <div>
                <input type="text" class="form-control mr-sm-2 custom-select" name="search" aria-label="Search" placeholder="Search..."/>
            </div>
            <div>
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </div>

        </div>

    </nav>
</g:uploadForm>
    <div class="flash">
        <g:if test="${flash.error}">
            <div class="alert alert-danger" role="alert">
                <h3>${flash.error}</h3>
            </div>
        </g:if>
        <g:if test="${flash.message}">
            <div class="alert alert-success" role="alert">
                <h3>${flash.message}</h3>
            </div>
        </g:if>
    </div>
<script>
    $(document).ready(function () {
        $(".flash").fadeOut(5000);
    });
</script>
<div id="hidden-field-success" class="alert alert-success" hidden></div>
<div id="hidden-field-fail" class="alert alert-danger" hidden></div>
<g:layoutBody/>
</body>
</html>
