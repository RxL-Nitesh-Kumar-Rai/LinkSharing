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
        .item1{grid-area: header1;}
        .item2{grid-area: header2;}
        .item3{grid-area: header3;}
        .item4{grid-area: main;}
        .item5{grid-area: foot3;}

        .card.grid-compo{
            display:grid;
            grid-template-areas: "header1 header2 header3"
                                    "main main main"
                                    "foot1 foot2 foot3";
            grid-template-rows: 20% 60% 20%;
            background-color: #71dd8a;
            color: #000000;
        }

    </style>

    <meta name="layout" content="loginnav"/>
%{--    <asset:link rel="shortcut icon" href="icon.ico" type="image/x-icon"/>--}%
</head>
<body>
        <div class="grid-container">
            <div>
                <div class="card dynamic">
                    <h2><p class ="login-register">Recent shares</p></h2>
                    <div class="card-scroll">
                        <g:each in="${topic}">
                            <div class="card grid-shares">
                                <div>
                                    <asset:image src="icon.ico" height="120" alt="Grails Guides" class="float-left"/>
                                </div>
                                <div class="card grid-compo">
%{--                                    <pre class="topic-content">${new Date()-it.dateCreated}th day    ${it.name}   ${it.createdBy.email}  ${it.createdBy.userName}  </pre >--}%
%{--                                    <pre>${it.description}</pre>--}%
                                    <div class="item1">${it.createdBy.userName}</div>
                                    <div class="item2">${it.createdBy.email}</div>
                                    <div class="item3">${new Date()-it.dateCreated}th day   ${it.name}</div>
                                    <div class="item4"></div>
                                    <g:set var="idd" value="${it.id}"/>
                                    <div class="item5">
                                        <g:link controller='dashBoard' action="searchtopic" params="[searchtopic: it.id]">
                                            Book List
                                        </g:link>
                                    </div>
                                    ${params.searchtopic}
                                </div>

                            </div>
                        </g:each>
                    </div>

                </div>
                <div class="card dynamic">
                    <h2><p class ="login-register">Top posts</p></h2>
                </div>
                </div>
                <div>
                    <g:form name="myForm" action="login" id="1" class="card form">
                        <div class="card-body">
                            <div class="login-register"><h2 class="card-title">Login</h2></div> <hr>
                            <pre class="form-text">Email/Username*    <input type="text" name="lgName"required></pre>
                            <pre>Password*          <input type="password" required name="lgPassword"></pre><br>
                            <a href="#">Forgot password</a>
                            <input type="submit" class="btn btn-primary" value="Login" id="btn-1">
                        </div>
                </g:form>
                <g:uploadForm name="myForm"  action="register" id="2" class="card form" method="POST">
                    <div class="card-body"S>
                        <div class="login-register"><h2 class="card-title">Register</h2></div><hr>
                        <pre>First Name*        <input type="text" required name="rgFname" id="rFname" maxlength="10"></pre>
                        <pre>Last Name*         <input type="text" required name="rgLname" id="rLname" maxlength="10"></pre>
                        <pre>Email*             <input type="email" required name="rgEmail" maxlength="40"
                                                       title="pattern:- abc@xyz.domain"
                                                       pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" id="rEmail"></pre>
                        <pre>username*          <input type="text" required name="rgName" id="rName" maxlength="20"></pre>
                        <pre>Password*          <input type="password" required name="rgPassword" id="pass"></pre>
                        <pre>confirm Password*  <input type="password" required name="rgCpassword"id="cPass"></pre>
                            <pre>Photo <g:field type="file" accept="image/*" name="rgPhoto" /></pre>
                            <input type="submit" class="btn btn-primary" value="Register" id="btn-2" >
                        </div>
                </g:uploadForm>
            </div>
        </div>
    </div>
</body>
</html>