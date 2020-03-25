<%--
  Created by IntelliJ IDEA.
  Users: nitesh
  Date: 17/03/20
  Time: 10:36 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <style>
    .test11{
        border-bottom-right-radius: 20px;
    }

    </style>
    <title>
        Home page
    </title>
    <link rel = "icon" href =  "icon.svg" type = "image/x-icon">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body>
<div class="grid-container">
    <div>
        <nav class="navbar navbar-expand-lg navbar-light bg-light" >
        <div class="collapse navbar-collapse" id="navbarSupportedContent" >
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <h4><a class="nav-link" href="#">Link Sharing <span class="sr-only">(current)</span></a></h4>
                </li>
            </ul>
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2 test11" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
    </nav>
</div>
    <span class="card" style="float: left;width: 56rem;">
        <div class="card" style="height: 21.5rem;background-color: rgb(204,255,204);">
            <h2><p style="text-align: center;margin-bottom: 0rem;color: rgb(72,72,95);">Recent shares</p><h2><hr>
        </div>
        <div class="card" style="height: 21.5rem;background-color: rgb(204,255,204);">
            <h2><p style="text-align: center;margin-bottom: 0rem;color: rgb(72, 72, 95);">Top posts</p><h2><hr>
        </div>
    </span>
    <span style="float: right;width: 24rem;">
%{--        <form target="#" action="#" class="card" style="color: rgb(72,72,95);background-color: rgb(179, 255, 179);">--}%
            <g:form name="myForm" action="persist" id="1" class="card" style="color: rgb(72,72,95);background-color: rgb(179, 255, 179);">
            <div class="card-body">
                <h5 class="card-title">Login</h5> <hr>
                <pre>Email/usernamee*   <input type="text" required name="userName"></pre>
                <pre>Password*          <input type="password" required name="password"></pre><br>
                <a href="#">Forgot password</a>
                <input type="submit" class="btn btn-primary" style="float: right;"value="Login">
            </div>
            </g:form>
%{--        </form>--}%
        <form target="#" action="#" class="card" style="background-color: rgb(179, 255, 179);" >
            <div class="card-body"S>
                <h5 class="card-title">Register</h5><hr>
                <pre>First Name*        <input type="text" required></pre>
                <pre>Last Name*         <input type="text" required></pre>
                <pre>Email*             <input type="text" required></pre>
                <pre>username*          <input type="text" required></pre>
                <pre>Password*          <input type="password" required></pre>
                <pre>confirm Password*  <input type="text" required></pre>
                <pre>Photo <input type="file"></pre>
                <input type="submit" class="btn btn-primary" style="float: right;"value="Register">
            </div>
        </form>
    </span></div>
</body>
</html>