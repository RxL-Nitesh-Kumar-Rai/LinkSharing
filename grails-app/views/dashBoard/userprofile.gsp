<%--
  Created by IntelliJ IDEA.
  User: nitesh
  Date: 26/03/20
  Time: 9:58 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <g:if test="${session.sessionId}">
        <meta name="layout" content="navbar"/>
    </g:if>
    <g:else>
        <meta name="layout" content="loginnav"/>
    </g:else>
    <title>User profile</title>
    <asset:stylesheet src="userprofile.css"/>
    <asset:javascript src="userprofile.js"/>
    <asset:javascript src="dashBoard.js"/>
    <asset:javascript src="searchtopic.js"/>
</head>
<body>
<div class="main-body">
        <div class="body1">
                <div class="card body1-card1">
                    <div>
                        <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':user.id])}"/>
                    </div>
                    <div class="body1-card1-grid">
                        <div class="item1">
                            <b>${user.fullName}</b>
                        </div>
                        <div class="item2">
                            ${session.sessionId}
                        </div>
                        <div class="item3">
                                Subscriptions
                        </div>
                        <div class="item4">
                            Topics
                        </div>
                        <div class="item5">
                            ${subs.size()}
                        </div>
                        <div class="item6">
                            ${topics.size()}
                        </div>
                    </div>
                </div>
            <g:if test="${session.sessionId==user.userName}">
                <div class="body1-item1">
                    <div class="card body1-card2">
                        <div class="card-title">Topics</div>
                        <table class="profileTopicsTable1">
                            <thead><tr><th></th></tr></thead>
                            <tbody>
                                <g:each in="${user.topics}">
                                    <tr>
                                        <td>
                                            <div class="card card-body bo1-ca2">
                                                <div class="item1-1">
                                                    <img height="90"  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':user.id])}"/>
                                                </div>
                                                <div class="item1-2"><input type="text" class="topicName" value="${it.name}" disabled/></div>
                                                <div class="item1-3">
                                                    <input type="button" class="topicSave" value="Save" disabled/>
                                                    <input type="button" class="topicCancel" value="Cancel" disabled/>
                                                    <div class="topicId" hidden>${it.id}</div>
                                                </div>
                                                <div class="item1-4">${user.userName}</div>
                                                <div class="item1-5">Subscriptions</div>
                                                <div class="item1-6">Post</div>
                                                <div class="item1-7">${it.subscriptions.size()}</div>
                                                <div class="item1-8">${it.resources.linkResources.flatten().size()+it.resources.documentResources.flatten().size()}</div>
                                                <div class="item1-9">
                                                    <g:select class="topicSeriousness" name="up-seri" from="['casual','serious','verySerious']" value="${Subscriptions.findByTopicAndUser(it,Users.findByUserName(session.sessionId)).seriousness}" disabled="true"/>
                                                </div>
                                                <div class="item1-10">
                                                    <g:select class="topicVisibility" name="up-visi" from="['Public','Private']" value="${it.visibility}" disabled="true"/>
                                                </div>
                                                <div class="item1-11">
                                                    <g:if test="${(session.isAdmin==true) || (it.createdBy.userName==session.sessionId)}">
                                                        <g:img  dir="images" class="topicEdit" file="edit.png" height="30" width="30" title="Edit"/>
                                                    </g:if>
                                                    <div class="topicId" hidden>${it.id}</div>
                                                    <g:img class="topicInvite" dir="images" file="invite.png" height="30" width="30" title="Invite" disabled="true"/>
                                                </div>
                                                <div class="item1-12">
                                                    <g:if test="${(session.isAdmin==true) || (it.createdBy.userName==session.sessionId)}">
                                                        <g:img class="topicDelete" dir="images" file="delete.png" height="30" width="30" title="Delete" disabled="true"/>
                                                    </g:if>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </g:if>
            <g:else>
                <div class="body1-item1">
                    <div class="card body1-card22">
                        <div class="card-title">Topics</div>
                        <table class="profileTopicsTable2">
                            <thead><tr><th></th></tr></thead>
                            <tbody>
                                <g:each in="${topics}">
                                    <tr>
                                        <td>
                                            <div class="card card-body bo1-ca22">
                                                <div class="item1-122">
                                                    <g:link controller='dashBoard' action="searchtopic" params="[searchtopic: it.id]">
                                                        ${it.name}
                                                    </g:link>
                                                </div>
                                                <div class="item1-22">Subscriptions</div>
                                                <div class="item1-32">Post</div>
                                                <div class="item1-42">
                                                    <div class="topicId2" hidden>${it.id}</div>
                                                    <g:if test="${session.sessionId}">
                                                        <g:if test="${it.subscriptions.any{it->it.user.userName==session.sessionId}}">
                                                            <g:select name="selectSeriousness" class="topicSeriousness2" from="['casual','serious','verySerious']" value="${Subscriptions.findByUserAndTopic(Users.findByUserName(session.sessionId),it).seriousness}"/>
                                                        </g:if>
                                                        <g:else>
                                                            <div class="btn topic2-subscribe">Subscribe</div>
                                                        </g:else>
                                                    </g:if>
                                                </div>
                                                <div class="item1-52">${it.subscriptions.size()}
                                                    <g:if test="${session.sessionId}">
                                                        <g:img style="margin-left: 100px" class="topic2-Invite" dir="images" file="invite.png" height="30" width="30" title="Invite" disabled="true"/>
                                                        <div class="topicId" hidden>${it.id}</div>
                                                    </g:if>
                                                </div>
                                                <div class="item1-62">${it.resources.linkResources.flatten().size()+it.resources.documentResources.flatten().size()}</div>
                                            </div>
                                        </td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </g:else>
        </div>

        <div class="body2">
            <g:if test="${session.sessionId==user.userName}">
                <div class="card body2-card2">
                    <div class="card-title"> Profile</div>
                    <div class="card-body">
                        <g:uploadForm controller="dashBoard" action="userupdate">
                            <pre>First name*          <input type="text" name="firstName" value="${user.firstName}" required/></pre>
                            <pre>Last name*           <input type="text" name="lastName" value="${user.lastName}" required/></pre>
                            <pre>Username*            <input type="text" name="userName" value="${user.userName}" required/></pre>
                            <pre>Photo                <input type="file" name="photo"/></pre>
                            <input type="submit" class="btn btn-primary" id="btn-1">
                        </g:uploadForm>
                    </div>
                </div>
            </g:if>
            <g:else>
                    <div class="card body2-card22">
                        <div class="card-title">Subscriptions</div>
                        <table class="profileSubscriptionsTable">
                            <thead><tr><th></th></tr></thead>
                            <tbody>
                                <g:each in="${subs}">
                                    <tr>
                                        <td>
                                            <div class="card card-body bo1-ca23">
                                                <div class="item1-13">
                                                    <g:link controller='dashBoard' action="searchtopic" params="[searchtopic: it.topic.id]">
                                                        ${it.topic.name}
                                                    </g:link>
                                                </div>
                                                <div class="item1-23">Subscriptions</div>
                                                <div class="item1-33">Post</div>
                                                <div class="item1-43">
                                                    <div class="topicId2" hidden>${it.id}</div>
                                                        <g:select name="selectSeriousness" class="topicSeriousness3" from="['casual','serious','verySerious']" value="${it.seriousness}" disabled="true"/>
                                                </div>
                                                <div class="item1-53">${it.topic.subscriptions.size()}</div>
                                                <div class="item1-63">${it.topic.resources.linkResources.flatten().size()+it.topic.resources.documentResources.flatten().size()}</div>
                                            </div>
                                        </td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
            </g:else>
            <g:if test="${session.sessionId==user.userName}">
            <div class="card body2-card2">
                <div class="card-title"> Change password</div>
                <div class="card-body">
                    <g:form controller="dashBoard" action="changepass">
                        <pre>Password*             <input type="password" name="password" id="pass" required/></pre>
                        <pre>Confirm password*     <input type="password" name="cPassword" id="cPass" required/></pre>
                        <input type="button" class="btn btn-primary" id="btn-2" value="Submit" disabled title="Enter password"/>
                    </g:form>
                </div>
            </div>
            </g:if>
            <g:else>
                <div class="card body2-posts">
                    <div class="card-title">Posts</div>
                    <table class="profilePostsTable">
                        <thead><tr><th></th></tr></thead>
                        <tbody>
%{--                            <g:each in="${user.topics.resources.linkResources.flatten()+user.topics.resources.documentResources.flatten()}">--}%
                            <g:each in="${posts}">
                                <tr>
                                    <td>
                                        <g:set var="isLink" value="false"/>
                                        <g:if test="${it.getClass()==LinkResource}">
                                            <g:set var="isLink" value="true"/>
                                        </g:if>
                                        <div class="card body2-posts-body">
                                            <div class="post-item1">
                                                <g:link controller='dashBoard' action="searchtopic" params="[searchtopic: it.resource.topic.id]">
                                                    ${it.resource.topic.name}
                                                </g:link>
                                            </div>
                                            <div class="post-item2"></div>
                                            <div class="post-item3">${it.description}</div>
                                            <div class="post-item4"></div>
                                            <div class="post-item5">
                                                <g:if test="${isLink=="true"}">
                                                    <g:link url="//${it.url}" target="_balnk">
                                                        View full site
                                                    </g:link>
                                                    <g:if test="${session.sessionId!=null}">
                                                        <g:if test="${ReadingItem.findByLinkResourceAndUserAndIsRead(it,Users.findByUserName(session.sessionId),false)}">
                                                            <div class="btn userProfileMarkAsRead">Mark as read</div>
                                                        </g:if>
                                                        <div hidden>${it.id}</div>
                                                    </g:if>
                                                </g:if>
                                                <g:else>
                                                    <g:link controller="resources" action="downloadPost" params="[postId: it.id]" target="_blank">
                                                        Download
                                                    </g:link>
                                                    <g:if test="${session.sessionId!=null}">
                                                        <g:if test="${ReadingItem.findByDocumentResourceAndUserAndIsRead(it,Users.findByUserName(session.sessionId),false)}">
                                                            <div class="btn userProfileMarkAsRead">Mark as read</div>
                                                        </g:if>
                                                        <div hidden>${it.id}</div>
                                                    </g:if>
                                                </g:else>
                                            </div>
                                            <div class="post-item6">
                                                <g:link controller='resources' action="viewPost" params="[postId: it.id]">
                                                    View post
                                                </g:link>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </g:else>
        </div>
    </div>

</body>
</html>