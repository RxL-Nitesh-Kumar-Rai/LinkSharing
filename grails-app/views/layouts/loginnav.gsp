<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <asset:stylesheet src="navbar.css"/>
    <title><g:layoutTitle default="Home Page"/></title>
%{--    <asset:link rel="shortcut icon" href="icon.ico" type="image/x-icon"/>--}%
%{--    <link rel="shortcut icon" href="/assets/icon.ico">--}%
<asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"/>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <asset:javascript src="application.js"/>
    <asset:stylesheet src="loginpage.css"/>
    <asset:javascript src="loginpage.js" />
    <g:layoutHead/>
</head>

<body>
<g:uploadForm url="[controller:'dashBoard',action:'searchtopic']">
    <nav class="navbar navbar-expand-lg navbar-light bg-light" >
        <div class="nav-division">
            <div>
                <h4><a class="btn btn-outline-success my-2 my-sm-0" href="#">Link Sharing <span class="sr-only">(current)</span></a></h4>
            </div>

            <div>
                <g:select class="form-control mr-sm-2 custom-select" name="searchtopic"
                          aria-label="Search" noSelection="${['null':'Select topic...']}"
                          from="${Topic.createCriteria().list(sort:'name',order:'desc'){
                              eq ("visibility" ,Topic.Visibility.'Public')
                          }}" optionValue="name" optionKey="id" />
            </div>
            <div>
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </div>

        </div>

    </nav>
</g:uploadForm>
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


<g:layoutBody/>
</body>
</html>
