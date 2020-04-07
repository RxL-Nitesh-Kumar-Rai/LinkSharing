<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <asset:javascript src="searchtopic.js" />
    <g:if test="${session.sessionId}">
        <meta name="layout" content="navbar"/>
    </g:if>
    <g:else>
        <meta name="layout" content="loginnav"/>
    </g:else>
<title>Search topic</title>

<style>

</style>
<asset:stylesheet src="searchtopic.css"/>
<script type="text/javascript">

</script>

</head>
<body>
    <div class="card searchtopic">
        <div>
            <div class="card searcTopicTopic">
                %{--                <div class="card">--}%
                <h5 class="card-title">Topic: ${searchtopic.name}</h5>
                <div class="card-body grid1">
                    <div>
                        <g:link controller="dashBoard" action="userprofile" params="[userName:searchtopic.createdBy.userName]">
                            <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':searchtopic.createdBy.id])}"/>
                        </g:link>
                    </div>
                    <div class="card grid-pagecontent">
                        <div class="item1">${searchtopic.name} (${searchtopic.visibility})</div>
                        <div class="item2">${searchtopic.createdBy.userName}</div>
                        <div class="item3">Subscriptions</div>
                        <div class="item4">Post</div>
                        <div class="item5">
                            <div class="topicId" hidden>${searchtopic.id}</div>
                            <g:set var="flag" value="false"/>
                            <g:if test="${session.sessionId}">
                            <g:if test="${session.sessionId!=searchtopic.createdBy.userName}">
                                <g:each in="${searchtopic.subscriptions}">
                                    <g:if test="${it.user.userName==session.sessionId}">
                                        <g:set var="flag" value="true"/>
                                    </g:if>
                                </g:each>
                                <g:if test="${flag=="true"}">

                                    <div class="btn" id="link1">Unsubscribe</div>
                                </g:if>
                                <g:else>
                                    <div class="btn" id="link2">Subscribe</div>
                                </g:else>
                            </g:if>
                            </g:if>
                        </div>
                        <div class="item6">${searchtopic.subscriptions.size()}</div>
                        <div class="item7">${searchtopic.resources.linkResources.flatten().size()+searchtopic.resources.documentResources.flatten().size()}</div>

                        <div class="item8">
                            <g:if test="${flag=='true'}">
                                <g:select id="seriousness2" class="form-control mr-sm-2 search" name="sub-unsub" from="['casual','serious','verySerious']" value="${Subscriptions.findByUserAndTopic(Users.findByUserName(session.sessionId),searchtopic).seriousness}"/>
                                <div hidden>${searchtopic.id}</div>
                                <g:img dir="images" style="float: right;margin-top: -24px;margin-right: 100px" id="topicInvite"  file="invite.png" height="30px" width="30px" title="Click to invite"/>
                            </g:if>
                        </div>

                    </div>
                </div>
            </div>
            <div class="card searchTopicUsers">
                <h5 class="card-title">Users: ${searchtopic.name}</h5>
                <div class="card-body grid2">
                    <table class="topicUsersTable">
                        <thead><tr><th></th></tr></thead>
                        <tbody>
                            <g:each in="${searchtopic.subscriptions}">
                                <tr>
                                    <td>
                                        <div class="card topicUsers">
                                            <div class="topicUsers-item1">
                                                <g:link controller="dashBoard" action="userprofile" params="[userName:it.user.userName]">
                                                    <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.user.id])}"/>
                                                </g:link>
                                            </div>
                                            <div class="topicUsers-item2"><b><h3>${it.user.fullName}</h3></b></div>
                                            <div class="topicUsers-item3"></div>
                                            <div class="topicUsers-item4">${it.user.userName}</div>
                                            <div class="topicUsers-item5"></div>
                                            <div class="topicUsers-item6">Subscriptions</div>
                                            <div class="topicUsers-item7">Topics</div>
                                            <div class="topicUsers-item8"></div>
                                            <div class="topicUsers-item9">${it.user.subscriptions.size()}</div>
                                            <div class="topicUsers-item10">${it.user.topics.size()}</div>
                                        </div>
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>

                </div>
            </div>

        </div>
        <div class="card searchTopicPosts">
            </pre><h5 class="card-title">Posts: ${searchtopic.name}  </h5>
                <div class="card-body grid3">
                    <table class="topicPostsTable">
                        <thead><tr><th></th></tr></thead>
                        <tbody>
                            <g:each in="${searchtopic.resources.linkResources.flatten()}">
                                <tr>
                                    <td>
                                        <div class="card topicPosts">
                                            <div class="topicPosts-item1">
                                                <g:link controller="dashBoard" action="userprofile" params="[userName:it.resource.createdBy.userName]">
                                                    <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.resource.createdBy.id])}"/>
                                                </g:link>
                                            </div>
                                            <div class="topicPosts-item2">${it.description}</div>
                                            <div class="topicPosts-item3"></div>
                                            <div class="topicPosts-item4">
                                                    <a href="//${it.url}" target="_blank">
                                                        View full site
                                                    </a>
                                            </div>
                                            <div class="topicPosts-item5">
                                                <g:link controller="resources" action="viewPost" params="[postId:it.id]">
                                                    View post
                                                </g:link>
                                                <div class="postsTopicId" hidden>${it.id}</div>
                                                <g:if test="${session.sessionId}">
                                                    <g:if test="${ReadingItem.findByLinkResourceAndUser(it,Users.findByUserName(session.sessionId))}">
                                                        <g:if test="${ReadingItem.findByLinkResourceAndUser(it,Users.findByUserName(session.sessionId)).isRead==false}">
                                                            <div class="btn markAsReadPost">Mark as read</div>
                                                        </g:if>
                                                    </g:if>
                                                </g:if>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                    <g:each in="${searchtopic.resources.documentResources.flatten()}">
                        <div class="card topicPosts">
                            <div class="topicPosts-item1">
                                <g:link controller="dashBoard" action="userprofile" params="[userName:it.resource.createdBy.userName]">
                                    <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.resource.createdBy.id])}"/>
                                </g:link>
                            </div>
                            <div class="topicPosts-item2">${it.description}</div>
                            <div class="topicPosts-item3"></div>
                            <div class="topicPosts-item4">
                                <g:link controller="resources" action="downloadPost" params="[postId: it.id]" target="_blank">
                                    Download
                                </g:link>
                            </div>
                            <div class="topicPosts-item5">
                                <g:link controller="resources" action="viewPost" params="[postId:it.id]">
                                    View post
                                </g:link>
                                <div class="postsTopicId" hidden>${it.id}</div>
                                <g:if test="${session.sessionId}">
                                    <g:if test="${ReadingItem.findByDocumentResourceAndUser(it,Users.findByUserName(session.sessionId))}">
                                        <g:if test="${ReadingItem.findByDocumentResourceAndUser(it,Users.findByUserName(session.sessionId)).isRead==false}">
                                            <div class="btn markAsReadPost">Mark as read</div>
                                        </g:if>
                                    </g:if>
                                </g:if>
                            </div>
                        </div>
                    </g:each>

                </div>

        </div>
    </div>



</body>
</html>
