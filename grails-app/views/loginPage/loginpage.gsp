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


    </style>


    <meta name="layout" content="loginnav"/>
</head>
<body>
        <div class="grid-container">
            <div>
                <div class="card dynamic">
                    <h2><p class ="card-title">Recent shares</p></h2>
                    <div class="card-scroll">
                        <g:if test="${post}">
                        <g:each in="${post}">
                            <div class="card grid-shares">
                                <div class="recentSharePhoto">
                                    <g:link controller="dashBoard" params="[userName:it.resource.createdBy.userName]" action="userprofile">
                                        <img height="90"  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.resource.createdBy.id])}"/>
                                    </g:link>
                                </div>
                                <div class="card grid-compo">
                                    <div class="item1">${it.resource.createdBy.userName}</div>
                                    <div class="item2">${it.resource.createdBy.email}</div>
                                    <div class="item3">day${new Date()-it.dateCreated}     <g:link controller='dashBoard' action="searchtopic" params="[searchtopic: it.resource.topic.id]">${it.resource.topic.name}</g:link></div>
                                    <div class="item4">${it.description}</div>
                                    <g:set var="idd" value="${it.id}"/>
                                    <div class="item5">
                                        <g:link controller='resources' action="viewPost" params="[postId: it.id]">
                                            View post
                                        </g:link>
                                    </div>
                                    ${params.searchtopic}
                                </div>

                            </div>
                        </g:each>
                        </g:if>
                    </div>

                </div>
                <div class="card dynamic">
                    <h2><p class ="card-title">Top posts</p></h2>
                    <div class="card-scroll">
                        <g:if test="${topPost}">
                            <g:each in="${topPost}">
                                <div class="card grid-shares">
                                    <div class="topPostPhoto">
                                        <g:link controller="dashBoard" params="[userName:it.resource.createdBy.userName]" action="userprofile">
                                            <img height="90"  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.resource.createdBy.id])}"/>
                                        </g:link>
                                    </div>
                                    <div class="card grid-compo">
                                        <div class="item1">
                                            ${it.resource.createdBy.userName}
                                        </div>
                                        <div class="item2">
                                            ${it.resource.createdBy.email}
                                        </div>
                                        <div class="item3">
                                            day${new Date() - it.dateCreated}
                                            <g:link controller='dashBoard' action="searchtopic" params="[searchtopic: it.resource.topic.id]">${it.resource.topic.name}</g:link>
                                        </div>
                                        <div class="item4">
                                            ${it.description}
                                        </div>
                                        <g:set var="idd" value="${it.id}"/>
                                        <div class="item5">
                                            <g:link controller='resources' action="viewPost" params="[postId: it.id]">
                                                View post
                                            </g:link>
                                        </div>
                                        ${params.searchtopic}
                                    </div>

                                </div>
                            </g:each>
                        </g:if>
                    </div>
                </div>
                </div>
                <div>
                    <g:form name="myForm" action="login" id="1" class="card form">
                        <div class="card-body">
                            <div class="login-register"><h2 class="card-title">Login</h2></div> <hr>
                            <pre class="form-text">Email/Username*    <input type="text" name="lgName"required></pre>
                            <pre>Password*          <input type="password" required name="lgPassword"></pre><br>
                            <div class="btn" data-toggle="modal" data-target="#staticBackdrop">Forgot password</div>
                            <input type="submit" class="btn btn-primary" value="Login" id="btn-1">
                        </div>
                </g:form>
                <g:uploadForm name="myForm"  action="register" id="2" class="card form" method="POST">
                    <div class="card-body"S>
                        <div class="login-register"><h2 class="card-title">Register</h2></div><hr>
                        <pre>First Name*        <input type="text" required name="rgFname" id="rFname" maxlength="10"></pre>
                        <pre>Last Name*         <input type="text" required name="rgLname" id="rLname" maxlength="10"></pre>
                        <pre>Email*             <input type="email" required name="rgEmail" maxlength="40" id="rEmail"></pre>
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

<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <g:form controller="loginPage" action="forgotPassword">
                <div class="modal-body">
                    UserName/Email* <input type="text" name="loginDetail"/>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Submit</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                </div>
            </g:form>
        </div>
    </div>
</div>
</body>
</html>