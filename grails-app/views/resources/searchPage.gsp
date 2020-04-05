<%--
  Created by IntelliJ IDEA.
  User: nitesh
  Date: 03/04/20
  Time: 3:33 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Search page</title>
    <g:if test="${session.sessionId}">
        <meta name="layout" content="navbar"/>
    </g:if>
    <g:else>
        <meta name="layout" content="loginnav"/>
    </g:else>
    <asset:stylesheet src="searchPage.css"/>
    <asset:javascript src="searchPage.js"/>
    <asset:javascript src="searchtopic.js"/>

</head>

<body>
    <div class="searchBody">
        <div>
            <div class="card body1-card1">
                <div class="card-title">Trending topics</div>
                <g:each in="${trendingTopic}">
                    <div class="card trendingTopicSearch">
                        <div class="trendingTopic-item1">
                            <g:link controller="dashBoard" action="userprofile" params="[userName:it.createdBy.userName]">
                                <img  height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.createdBy.id])}"/>
                            </g:link>
                        </div>
                        <div class="trendingTopic-item2">
                            <g:link class="trendingTopicNameLink" controller="dashBoard" action="searchtopic" params="[searchtopic:it.id]" >
                                ${it.name}
                            </g:link>
                        </div>
                        <div class="trendingTopic-item3">
                            <g:if test="${session.sessionId}">
                                <g:if test="${it.subscriptions.any{it.user.userName==session.sessionId}}">
                                    <div hidden>${it.id}</div>
                                    <g:img class="trendingTopicInvite" dir="images"  id="topicInvite"  file="invite.png" height="30px" width="30px" title="Click to invite"/>
                                </g:if>
                            </g:if>
                        </div>
                        <div class="trendingTopic-item4"></div>
                        <div class="trendingTopic-item5">
                            ${it.createdBy.userName}
                        </div>
                        <div class="trendingTopic-item6">Subscriptions</div>
                        <div class="trendingTopic-item7">Post</div>
                        <div class="trendingTopic-item8">
                            <g:if test="${session.sessionId}">
                                <g:if test="${it.subscriptions.any{it.user.userName==session.sessionId}}">
                                    <g:if test="${it.createdBy.userName!=session.sessionId}">
                                        <div class="btn searchUnsubscribe">Unsubscribe</div>
                                    </g:if>
                                </g:if>
                                <g:else>
                                    <div class="btn searchSubscribe">Subscribe</div>
                                </g:else>
                            </g:if>
                            <div hidden>${it.id}</div>
                        </div>
                        <div class="trendingTopic-item9">${it.subscriptions.size()}</div>
                        <div class="trendingTopic-item10">${it.resources.linkResources.flatten().size()+it.resources.flatten().size()}</div>
                    </div>
                </g:each>
            </div>
            <div class="card body1-card2">
                <div class="card-title">Top posts</div>
                <g:each in="${topPost}">
                    <div class="card topPosts">
                        <div class="topPosts-item1">
                            <g:link controller="dashBoard" action="userprofile" params="[userName:it.resource   .createdBy.userName]">
                                <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.resource.createdBy.id])}"/>
                            </g:link>
                        </div>
                        <div class="topPosts-item2">
                            ${it.resource.createdBy.fullName}
                        </div>
                        <div class="topPosts-item3">
                            ${it.resource.createdBy.userName}
                        </div>
                        <div class="topPosts-item4">
                            <g:link class="trendingTopicNameLink" controller="dashBoard" action="searchtopic" params="[searchtopic:it.resource.topic.id]" >
                                ${it.resource.topic.name}
                            </g:link>
                        </div>
                        <div class="topPosts-item5">${it.description}</div>
                        <div class="topPosts-item6"></div>
                        <div class="topPosts-item7">
                            <g:if test="${it.getClass()==LinkResource}">
                                <g:link url="//${it.url}" target="_balnk">
                                    View full site
                                </g:link>
                            </g:if>
                            <g:else>
                                <g:link controller="resources" action="downloadPost" params="[postId: it.id]" target="_blank">
                                    Download
                                </g:link>
                        </g:else>
                        </div>
                        <div class="topPosts-item8">
                            <g:if test="${session.sessionId}">
                                <g:if test="${it.getClass()==LinkResource}">
                                    <g:if test="${ReadingItem.findByLinkResourceAndUserAndIsRead(it,Users.findByUserName(session.sessionId),false)}">
                                        <div class="btn searchMarkAsRead">Mark as read</div>
                                    </g:if>
                                </g:if>
                                <g:else>
                                    <g:if test="${ReadingItem.findByDocumentResourceAndUserAndIsRead(it,Users.findByUserName(session.sessionId),false)}">
                                        <div class="btn searchMarkAsRead">Mark as read</div>
                                    </g:if>
                                </g:else>
                            </g:if>
                            <div hidden>${it.id}</div>
                        </div>
                        <div class="topPosts-item9">
                            <g:link controller='resources' action="viewPost" params="[postId: it.id]">
                                View post
                            </g:link>
                        </div>
                    </div>
                </g:each>
            </div>
        </div>
        <div class="searchBody2">
%{--            --}%
            <div id="accordion">
                <div class="card">
                    <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                        Users
                    </button>
                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordion">
                        <div class="card-body searchPanel">
                            <table class="searchUsersTable">
                                <thead><tr><th></th></tr></thead>
                                <tbody>
                                    <g:each in="${users}">
                                        <tr>
                                            <td>
                                                <div class="card searchUsers">
                                                    <div class="searchUsers-item1">
                                                        <g:link controller="dashBoard" action="userprofile" params="[userName:it.userName]">
                                                            <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.id])}"/>
                                                        </g:link>
                                                    </div>
                                                    <div class="searchUsers-item2">${it.fullName}</div>
                                                    <div class="searchUsers-item3">${it.userName}</div>
                                                    <div class="searchUsers-item4">Subscriptions <br>${it.subscriptions.size()} </div>
                                                    <div class="searchUsers-item5">Topics <br> ${it.topics.size()}</div>
                                                </div>
                                            </td>
                                        </tr>
                                    </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                Topics
                    </button>
                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
                        <div class="card-body searchPanel">
                            <table class="searchTopicsTable">
                                <thead><tr><th></th></tr></thead>
                                <tbody>
                                    <g:each in="${topics}">
                                        <tr>
                                            <td>
                                                <div class="card searchUsers">
                                                    <div class="searchUsers-item1">
                                                        <g:link controller="dashBoard" action="userprofile" params="[userName:it.createdBy.userName]">
                                                            <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.createdBy.id])}"/>
                                                        </g:link>
                                                    </div>
                                                    <div class="searchUsers-item2">${it.createdBy.fullName}</div>
                                                    <div class="searchUsers-item3">
                                                        <g:link class="trendingTopicNameLink" controller="dashBoard" action="searchtopic" params="[searchtopic:it.id]" >
                                                            ${it.name}
                                                        </g:link>
                                                    </div>
                                                    <div class="searchUsers-item4">Subscriptions <br>${it.subscriptions.size()} </div>
                                                    <div class="searchUsers-item5">Posts <br> ${it.resources.linkResources.flatten().size()+it.resources.documentResources.flatten().size()}</div>
                                                </div>
                                            </td>
                                        </tr>
                                    </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="card">

                            <button class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                Posts
                            </button>

                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
                        <div class="card-body searchPanel">
                            <table class="searchPostsTable">
                                <thead><tr><th></th></tr></thead>
                                <tbody>
                                    <g:each in="${posts}">
                                        <tr>
                                            <td>
                                                <div class="card searchUsers">
                                                    <div class="searchUsers-item1">
                                                        <g:link controller="dashBoard" action="userprofile" params="[userName:it.resource.createdBy.userName]">
                                                            <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.resource.createdBy.id])}"/>
                                                        </g:link>
                                                    </div>
                                                    <div class="searchUsers-item2">${it.resource.createdBy.fullName}</div>
                                                    <div class="searchUsers-item3">
                                                        <g:link class="trendingTopicNameLink" controller="dashBoard" action="searchtopic" params="[searchtopic:it.resource.topic.id]" >
                                                            ${it.resource.topic.name}
                                                        </g:link>
                                                        <g:link controller='resources' action="viewPost" params="[postId: it.id]">
                                                            View post
                                                        </g:link>
                                                    </div>
                                                    <div class="searchUsers-item4">Subscriptions <br>${it.resource.topic.subscriptions.size()} </div>
                                                    <div class="searchUsers-item5">Posts <br> ${it.resource.topic.resources.linkResources.flatten().size()+it.resource.topic.resources.documentResources.flatten().size()}</div>
                                                </div>
                                            </td>
                                        </tr>
                                    </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

%{--            --}%
        </div>
    </div>
</body>
</html>