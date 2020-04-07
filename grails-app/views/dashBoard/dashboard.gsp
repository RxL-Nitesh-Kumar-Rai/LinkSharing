<%--
  Created by IntelliJ IDEA.
  User: nitesh
  Date: 19/03/20
  Time: 3:33 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="navbar"/>
    <asset:javascript src="dashBoard.js"/>
    <asset:stylesheet src="dashboard.css"/>
    <asset:javascript src="searchtopic.js"/>
    <title>Dash Board</title>


    <style>


    </style>

</head>

<body>

<div class="grid-container">
        <div>
            <div class=" card item item1">
                <div class="card-title">Details</div>
                <div class="card-body card1">
                    <div class="i1-item1">
                        <g:link controller="dashBoard" action="userprofile" params="[userName:user.userName]">
                            <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':user.id])}"/>
                        </g:link>
                    </div>
                    <h3><b><div class="i1-item2">${user.fullName}</div></b></h3>
                    <div class="i1-item3">${user.userName}</div>
                    <div class="i1-item4">
                        <g:link controller="dashBoard" action="allSubscribedTopics">
                            Subscriptions
                        </g:link>
                    </div>
                    <div class="i1-item5">
                        <g:link controller="dashBoard" action="allCreatedTopics">
                            Topics
                        </g:link>
                    </div>
                    <div class="i1-item6">${user.subscriptions.size()}</div>
                    <div class="i1-item7">${user.topics.size()}</div>
                </div>
            </div>
            <div class="card item item2">
                <div class="card-title">
                    Subscription
                    <div style="margin-right: -30rem;margin-top: -2.5rem;font-size: 1.5rem">
                        <g:link controller="dashBoard" action="allUserTopics">
                            View all
                        </g:link>
                    </div>
                </div>
                <div class="subscriptions">
%{--                    <table class="dashboardSubscriptionsTable">--}%
%{--                        <thead><tr><th></th></tr></thead>--}%
                        <tbody>
                            <g:each in="${subs}">
%{--                                <tr>--}%
%{--                                    <td>topic--}%
                                        <div class="card body-item2">
                                            <div class="i2-item1">
                                                <g:link controller="dashBoard" action="userprofile" params="[userName:it.createdBy.userName]">
                                                    <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.createdBy.id])}"/>
                                                </g:link>
                                            </div>
                                            <div class="i2-item2">
                                                <input type="text" value="${it.name}" title="click to see full topic" class="subscriptionTopic" hidden required/>
                                                <g:link class="subscriptionTopicName" controller="dashBoard" action="searchtopic" params="[searchtopic:it.id]" id="subscriptionTopicLink">
                                                    ${it.name}
                                                </g:link>
                                            </div>
                                            <div class="i2-item3">
                                                <div class="topicId" hidden>${it.id}</div>
                                                <input type="button" class="btn btn-primary subscriptionSave" value="save" id="subscriptionSave" hidden/>
                                                <input type="button" class="btn btn-secondary subscriptionCancel" value="cancel" id="subscriptionCancel" hidden/>
                                            </div>
                                            <div class="i2-item4">${it.createdBy.userName}</div>
                                            <div class="i2-item5">Subscriptions</div>
                                            <div class="i2-item6">Post</div>
                                            <div class="i2-item7">
                                                <g:if test="${session.sessionId!=it.createdBy.userName}">
                                                    <div class="btn subscriptionsUnsubscribe" id="subscriptionLink1">Unsubscribe</div>
                                                    <div hidden>${it.id}</div>
                                                </g:if>
                                            </div>
                                            <div class="i2-item8">${it.subscriptions.size()}</div>
                                            <div class="i2-item9">${it.resources.linkResources.flatten().size()+it.resources.documentResources.flatten().size()}</div>
                                            <div class="i2-item10">
                                                <g:select style="background-color: #9fcdff;margin: 5px" name="subscriptionTopicSeriousness" class="subscriptionTopicSeriousness" from="['casual','serious','verySerious']" value="${Subscriptions.findByUserAndTopic(user,it).seriousness}" disabled="true"/>
                                                <g:if test="${(it.createdBy.userName==session.sessionId)|| session.isAdmin}">
                                                    <g:select style="width: 125px;background-color: #9fcdff;margin: 5px" name="subscriptionTopicType" class="subscriptionTopicType" from="['Public','Private']" value="${it.visibility}" disabled="true"/>
                                                </g:if>
                                            </div>
                                            <div class="i2-item11">
                                                <div class="topicId" hidden>${it.id}</div>
                                                <g:img dir="images" style="margin-left: 60" file="invite.png" height="30px" width="30px" class="subscriptionInvite" title="Click to invite"/>
                                                <g:if test="${(it.createdBy.userName==session.sessionId)|| session.isAdmin}">
                                                    <g:img dir="images" file="edit.png" height="30px" width="30px" class="subscriptionEdit" title="Click to edit topic" value="it.topic.id"/>
                                                    <g:img dir="images" file="delete.png" height="30px" width="30px" class="subscriptionDelete" title="Click to delete topic"/>
                                                </g:if>
                                            </div>
                                        </div>
%{--                                    </td>--}%
%{--                                </tr>--}%
                            </g:each>
%{--                        </tbody>--}%
%{--                    </table>--}%
                </div>
            </div>
        </div>
        <div>
            <div class="card item item3">
                <div class="card-title">Inbox</div>
                <div class="readingItem">
                    <table class="inboxReadingItems">
                        <thead><tr><th></th></tr></thead>
                        <tbody>
                            <g:each in="${readingItem}">
                                <tr>
                                    <td>
                                        <g:set var="typeOfResource" value="${it.linkResource}"/>
                                        <div class="card body-item3">
                                            <div class="i3-item1">
                                            <g:link controller="dashBoard" action="userprofile" params="[userName:it.topic.createdBy.userName]">
                                                <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.topic.createdBy.id])}"/>
                                            </g:link>
                                            </div>
                                            <div class="i3-item2">${it.topic.createdBy.fullName}</div>
                                            <div class="i3-item3">${it.topic.createdBy.userName}</div>
                                            <div class="i3-item4">
                                            <g:link class="subscriptionTopicName" controller="dashBoard" action="searchtopic" params="[searchtopic:it.topic.id]" id="subscriptionTopicLink">
                                                ${it.topic.name}
                                            </g:link>
                                            </div>
                                            <div class="i3-item5">
                                                <g:if test="${typeOfResource!=null}">
                                                    ${it.linkResource.description}
                                                </g:if>
                                                <g:else>
                                                    ${it.documentResource.description}
                                                </g:else>
                                            </div>
                                            <div class="i3-item6">
                                                <g:if test="${typeOfResource}">
                                                    <g:link url="//${it.linkResource.url}" target="_balnk">
                                                        View full site
                                                    </g:link>
                                                </g:if>
                                                <g:else>
                                                    <g:link controller="resources" action="downloadPost" params="[postId: it.documentResource.id]" target="_blank">
                                                        Download
                                                    </g:link>
                                                </g:else>
                                            </div>
                                            <div class="i3-item7">
                                                <div class="btn markReadPost" >
                                                Mark as read
                                                </div>
                                                <g:if test="${it.linkResource!=null}">
                                                    <div class="readPostId" hidden>${it.linkResource.id}</div>
                                                </g:if>
                                                <g:else>
                                                    <div class="readPostId" hidden>${it.documentResource.id}</div>
                                                </g:else>
                                            </div>
                                            <div class="i3-item8">
                                                <g:if test="${typeOfResource}">
                                                    <g:link controller='resources' action="viewPost" params="[postId: it.linkResource.id]">
                                                        View post
                                                    </g:link>
                                                </g:if>
                                                <g:else>
                                                    <g:link controller='resources' action="viewPost" params="[postId: it.documentResource.id]">
                                                        View post
                                                    </g:link>
                                                </g:else>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card item item4">
                <div class="card-title">Trending topics</div>
                <div class="trendingTopic">
                    <g:each in="${trendingTopic}">
                        <g:set var="typeOfResource" value="${readingItem.linkResource}"/>
                        <div class="card body-item4">
                            <div class="i4-item1">
                                <g:link controller="dashBoard" action="userprofile" params="[userName:it.createdBy.userName]">
                                    <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.createdBy.id])}"/>
                                </g:link>
                            </div>
                            <div class="i4-item2">
                                <div class="trendingTopicId" hidden>${it.id}</div>
                                <input type="text" value="${it.name}" title="click to see full topic" class="trendingTopicName" hidden required/>
                                <g:link class="trendingTopicNameLink" controller="dashBoard" action="searchtopic" params="[searchtopic:it.id]" >
                                    ${it.name}
                                </g:link>
                            </div>
                            <div class="i4-item3"><button class="btn btn-primary saveTrendingTopic" hidden>save</button></div>
                            <div class="i4-item4"><button class="btn btn-secondary cancelTrendingTopic" hidden>Cancel</button></div>
                            <div class="i4-item5">${it.createdBy.userName}</div>
                            <div class="i4-item6">Subscriptions</div>
                            <div class="i4-item7">Post</div>
                            <div class="i4-item8">
                                <g:set var="flag" value="false"/>
                                <g:each in="${it.subscriptions}" var="sub">
                                    <g:if test="${sub.user.userName==session.sessionId}">
                                        <g:set var="flag" value="true"/>
                                    </g:if>
                                </g:each>
                                <g:if test="${session.sessionId!=it.createdBy.userName}">
                                    <g:if test="${flag=="true"}">

                                        <div class="btn trendingTopicLink1">Unsubscribe</div>
                                    </g:if>
                                    <g:else>
                                        <div class="btn trendingTopicLink2">Subscribe</div>
                                    </g:else>
                                </g:if>
                                <div hidden>${it.id}</div>
                            </div>
                            <div class="i4-item9">${it.subscriptions.size()}</div>
                            <div class="i4-item10">${it.resources.linkResources.flatten().size()+it.resources.documentResources.flatten().size()}</div>
                            <div class="i4-item11">
                                <g:if test="${flag=="true"}">

                                    <g:select value="${Subscriptions.findByUserAndTopic(Users.findByUserName(session.sessionId),it).seriousness}" class="trendingTopicSeriousness" style="background-color: #9fcdff;margin: 5px" name="trendingTopicSeriousness" from="['casual','serious','verySerious']" disabled="true"/>
                                </g:if>

                            </div>
                            <div class="i4-item12">
                                <g:if test="${(it.createdBy.userName==session.sessionId)|| session.isAdmin}">
                                    <g:select value="${it.visibility}" class="trendingTopicType" style="width: 125px;background-color: #9fcdff;margin: 5px" name="trendingTopicType" from="['Public','Private']" disabled="true"/>
                                </g:if>
                            </div>
                            <div class="i4-item13">
                                <div class="trendingTopicInvite" hidden>${it.id}</div>
                                <g:img dir="images" class="trendingTopicInvite" style="margin-left: 60" file="invite.png" height="30px" width="30px" title="Click to invite"/>
                                <g:if test="${(it.createdBy.userName==session.sessionId)|| session.isAdmin}">
                                    <g:img dir="images" class="trendingTopicEdit" file="edit.png" height="30px" width="30px" title="Click to edit topic"/>
                                    <g:img dir="images" class="trendingTopicDelete" file="delete.png" height="30px" width="30px" title="Click to delete topic"/>
                                </g:if>
                            </div>
                        </div>
                    </g:each>
                </div>
            </div>
        </div>
</div>



</body>
</html>