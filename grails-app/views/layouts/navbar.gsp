<%--
  Created by IntelliJ IDEA.
  User: nitesh
  Date: 19/03/20
  Time: 3:33 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

%{--    <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>--}%
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
    <asset:javascript src="navbar.js"/>
    <asset:stylesheet src="navbar.css"/>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
    <title><g:layoutTitle default="Link sharing"/></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"/>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <g:layoutHead/>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand btn btn-outline-success my-2 my-sm-0" href="${createLink(controller: 'loginPage',action: 'index')}" title="home page">Link sharing</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item dropdown active btn btn-outline-success my-2 my-sm-0   ">
                    <a class="nav-link dropdown-toggle active " href="#"
                       id="navbarDropdown" role="button" data-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false" title="About user">
                        User
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <g:link class="dropdown-item" controller="dashBoard" params="[userName:session.sessionId]" action="userprofile">Profile</g:link>
                        <div class="dropdown-divider"></div>
                        <g:if test="${session.getAttribute("isAdmin")}">
                            <a class="dropdown-item" href="${createLink(controller: 'dashBoard',action: 'allusers')}">Users</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="${createLink(controller: 'dashBoard',action: 'alltopics')}">Topics</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="${createLink(controller: 'resources', action: 'allPosts')}">
                                Posts
                            </a>
                            <div class="dropdown-divider"></div>
                        </g:if>
                        <g:link class="dropdown-item" controller="dashBoard" action="logout">Logout</g:link>
                    </div>
                </li>
                <button class="nav-item active btn btn-outline-success my-2 my-sm-0 nav-link  btn-primary" data-target="#createtopic" data-toggle="modal">
                    Create Topic
                </button>
                <button class="nav-item active btn btn-outline-success my-2 my-sm-0 nav-link  btn-primary" id='navInvite' data-target="#invite" data-toggle="modal">
                    Invite
                </button>
                <button class="nav-item active btn btn-outline-success my-2 my-sm-0 nav-link  btn-primary" data-target="#createlink" data-toggle="modal">
                    Create link
                </button>
                <button class="nav-item active btn btn-outline-success my-2 my-sm-0 nav-link  btn-primary" data-target="#createdocument" data-toggle="modal">
                           Create Document
                </button>
            </ul>
            <g:uploadForm class="form-inline my-2 my-lg-0" url="[controller:'resources',action:'searchPage']">
%{--                <g:select class="form-control mr-sm-2 " name="searchtopic"--}%
%{--                          aria-label="Search" noSelection="${['null':'Select topic...']}"--}%
%{--                          from="${Topic.list(sort:'name')}" optionValue="name" optionKey="id" />--}%
                <input type="text" class="form-control mr-sm-2 custom-select" name="search" aria-label="Search" placeholder="Search..."/>
                <button class="btn btn-outline-success my-2 my-sm-0 full" type="submit">Search topic</button>
            </g:uploadForm>
        </div>
    </nav>

<div class="modal fade" id="createtopic" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel1" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel1">Create topic</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
%{--                url="[controller:'dashBoard',action:'createtopic']"--}%
                <g:uploadForm name="shareLink" id="form1" >

                    <div class="modal-body" >
                        <pre>Name*:         <input type="text" name="tName" id="topicName" size="33" required/></pre>

                        Visibility*:
                        <div class="input-group mb-3">
                            <select class="custom-select" id="inputGroupSelect01"  name="tType"  required>
                                <option value="Public">Public</option>
                                <option value="Private">Private</option>
                            </select>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" id="form1-btn1" class="btn btn-primary" value="submit">Save</button>
                        <button type="button" id="form1-btn2" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </g:uploadForm>
            </div>

        </div>
    </div>
</div>

<div class="modal fade" id="invite" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel2" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel2">Send invitation</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <g:uploadForm name="shareLink" id="form1" controller="resources" action="sendInvitation"  >
%{--                <g:uploadForm name="shareLink" id="form1" controller="inviteLink" action="sendInvite"  >--}%

                    <div class="modal-body" >
                        <pre>Email*:       <input type="email" name="emailInvite" id="emailInvite" required size="33" required/></pre>
                        Topic*:
                        <div class="input-group mb-3">
                            <g:select class="custom-select" id="inputGroupSelect03" name="emailTopic" value="" from="${Topic.createCriteria().list(sort:'name'){'subscriptions' {eq('user',Users.findByUserName(session.sessionId))}}}" optionKey="id" optionValue="name" required="true"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="inviteButton" value="submit">Invite</button>
                        <button type="button" class="btn btn-secondary" id="inviteCancel" data-dismiss="modal">Cancel</button>
                    </div>
                </g:uploadForm>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="createlink" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel3" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel3">Create link</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <g:uploadForm name="shareLink" id="form3" >

                <div class="modal-body" >
                <pre>Link*:         <input type="text" required size="38" id="linkurl" name="linkurl" required/></pre>
                    <pre>Description*:  <textarea rows="4" cols="38" id="linkdescription" required name="linkdescription" aria-multiline="true"maxlength="255"></textarea> </pre>
                Topic*:
                    <div class="input-group mb-3">
                                    <g:select class="custom-select" name="topiclink" id="inputGroupSelect04"
                                              from="${Topic.createCriteria().list(sort:'name'){'subscriptions' {eq('user',Users.findByUserName(session.sessionId))}}}" optionValue="name" optionKey="id" />
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="form3-btn1" >Share</button>
                <button type="button" class="btn btn-secondary" id="form3-btn2" data-dismiss="modal">Cancel</button>
            </div>
                </g:uploadForm>

        </div>
    </div>
</div>

<div class="modal fade" id="createdocument" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel4" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel4">Share document</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times</span>
                </button>
            </div>
            <g:uploadForm name="shareLink" id="form4" action="createDocument" >

                <div class="modal-body" >
                    <pre>Document*:         <input type="file" required size="38" name="documentfile" required/></pre>
                    <pre>Description*:  <textarea rows="4" cols="38" name="documentdescription" required></textarea> </pre>
                    Topic*:
                    <div class="input-group mb-3">
                    <g:select class="custom-select" name="topicdocument" id="inputGroupSelect05"
                              from="${Topic.createCriteria().list(sort:'name'){'subscriptions' {eq('user',Users.findByUserName(session.sessionID))}}}" optionValue="name" optionKey="id" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" value="submit">Share</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                </div>
            </g:uploadForm>
        </div>
    </div>
</div>
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
<div id="hidden-field-success" class="alert alert-success" hidden></div>
<div id="hidden-field-fail" class="alert alert-danger" hidden></div>
<script>
    $(document).ready(function () {
        $(".flash").fadeOut(5000);
    });
</script>
<g:layoutBody/>
</body>
</html>