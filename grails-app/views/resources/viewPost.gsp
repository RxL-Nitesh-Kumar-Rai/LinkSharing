<%--
  Created by IntelliJ IDEA.
  User: nitesh
  Date: 28/03/20
  Time: 1:44 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <g:if test="${session.sessionId}">
        <meta name="layout" content="navbar"/>
    </g:if>
    <g:else>
        <meta name="layout" content="loginnav"/>
    </g:else>
    <asset:javascript src="viewPost.js" />
    <asset:javascript src="dashBoard.js" />
    <asset:stylesheet src="viewPost.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/rateYo/2.3.2/jquery.rateyo.min.js"></script>
</head>

<body>
<div id="postId" hidden>${post.id}</div>
    <div id="postType" hidden>${type}</div>
    <div class="main-body">
        <div class="card body1">
            <div class="item1">
                <g:link controller="dashBoard" action="userprofile" params="[userName:post.resource.createdBy.userName]">
                    <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':post.resource.createdBy.id])}"/>
                </g:link>
            </div>
            <div class="item2" id="test">${post.resource.createdBy.fullName}</div>
            <div class="item3">${post.lastUpdated.format( 'h:m:s a  dd-MMM-yyyy')}</div>
            <div class="item4"><g:link controller='dashBoard' action="searchtopic" params="[searchtopic: post.resource.topic.id]">${post.resource.topic.name}</g:link></div>
            <div class="item5">${post.resource.createdBy.userName}</div>
            <div class="item6" id="rating">

%{--                <g:img dir="images" file="heart-w.png" height="30" width="30" title="rate-1" id="rat1" value="1"/>--}%
%{--                <g:img dir="images" file="heart-w.png" height="30" width="30" title="rate-2" id="rat2" value="2"/>--}%
%{--                <g:img dir="images" file="heart-w.png" height="30" width="30" title="rate-3" id="rat3" value="3"/>--}%
%{--                <g:img dir="images" file="heart-w.png" height="30" width="30" title="rate-4" id="rat4" value="4"/>--}%
%{--                <g:img dir="images" file="heart-w.png" height="30" width="30" title="rate-5" id="rat5" value="5"/>--}%
                <div id="rate" style="float: left"></div>
                <div class="ratingValue" style="display: none">
                    <g:if test="${session.sessionId}">
                        <g:if test="${post.getClass()==LinkResource}">
                            <g:if test="${ResourceRating.findByLinkResourceAndRatedBy(post,Users.findByUserName(session.sessionId))}">
                                ${ResourceRating.findByLinkResourceAndRatedBy(post,Users.findByUserName(session.sessionId)).rating}
                            </g:if>
                            <g:else>0</g:else>
                        </g:if>
                        <g:else>
                            <g:if test="${ResourceRating.findByDocumentResourceAndRatedBy(post,Users.findByUserName(session.sessionId))}">
                                ${ResourceRating.findByDocumentResourceAndRatedBy(post,Users.findByUserName(session.sessionId)).rating}
                            </g:if>
                            <g:else>0</g:else>
                        </g:else>
                    </g:if>
                    <g:else>0</g:else>
                </div>

                <div style="float: right;margin-right: 20px">
                    RatedBy->
                    <g:if test="${type=='link'}">
                        <g:if test="${ResourceRating.findByLinkResource(post)}">
                            ${ResourceRating.findAllByLinkResource(post).size()}
                        </g:if>
                    </g:if>
                    <g:else>
                        <g:if test="${ResourceRating.findByDocumentResource(post)}">
                            ${ResourceRating.findAllByDocumentResource(post).size()}
                        </g:if>
                    </g:else>
                </div>
            </div>
            <div class="item7">
                <div class="postDescription" style="margin-left: 14px">
                    ${post.description}
                </div>
                <textarea class="PostDescriptionTextArea" cols="60" rows="5" style="margin-left: 14px" hidden>${post.description}</textarea>
            </div>
            <div class="item8">
                <g:if test="${(session.isAdmin)||(post.resource.createdBy.userName==session.sessionId)}" >
                    <div class="postId" hidden>${post.id}</div>
                    <span class="btn" id="postEdit" title="Click to edit post">Edit</span>
                    <span  class="btn " id="deletePost" title="Click to delete post">Delete</span>
                    <button class="saveEditedPost" style="background-color: #9fcdff" hidden>Save</button>
                    <button class="cancelEditedPost" style="background-color: #9fcdff" hidden>Cancel</button>
                    <div class="postType" hidden>${type}</div>
                </g:if>
                <g:if test="${type=="link"}">
                    <a target="_blank"  href="//${post.url}" title="Click to view full site">View full site</a>
                </g:if>
                <g:else>
%{--                    <span class="btn btn-primary" id="download">Download1</span>--}%
                    <g:link target="_blank" controller="resources" action="downloadPost" params="[postId:post.id,postType:'document']">Download</g:link>
                </g:else>
            </div>
        </div>
        <div class="card body2">
            <div class="card-title">Trending topic</div>
            <g:each in="${trendTopic}">
            <div class="card-body grid">
                <div>
                <g:link controller="dashBoard" action="userprofile" params="[userName:it.createdBy.userName]">
                        <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.createdBy.id])}"/>
                </g:link>
                </div>
                <div class="card grid-trending">
                    <div class="item1"><g:link class="trendingTopicNameLink" controller="dashBoard" action="searchtopic" params="[searchtopic: it.id]" title="View this topic">${it.name} (${it.visibility})</g:link>
                        <input type="text" class="trendingTopicName" value="${it.name}" hidden/>
                    </div>
                    <div class="item11">
                        <button class="btn btn-primary trendingTopicSave" hidden>Save</button>
                        <button class="btn btn-secondary trendingTopicCancel" hidden>Cancel</button>
                        <div class="topicId" hidden>${it.id}</div>
                    </div>
                    <div class="item2">${it.createdBy.userName}</div>
                    <div class="item3">Subscriptions</div>
                    <div class="item4">Post</div>
                    <div class="item5">
                        <g:set var="isSubscribed" value="false"/>
                        <g:each in="${it.subscriptions}" var="sub">
                            <g:if test="${sub.user.userName==session.sessionId}">
                                <g:set var="isSubscribed" value="true"/>
                                </g:if>
                        </g:each>
                        <g:if test="${it.createdBy.userName!=session.sessionId}">
                            <g:if test="${isSubscribed=='true'}">
                                <div class="btn trendingUnsubscribe">
                                    Unsubscribe
                                </div>
                            </g:if>
                            <g:else>
                                <div class="btn trendingSubscribe">
                                    Subscribe
                                </div>
                            </g:else>
                        </g:if>
                    </div>
                    <div class="item6">${it.subscriptions.size()}</div>
                    <div class="item7">${it.resources.linkResources.size()+it.resources.documentResources.size()}</div>
                    <div class="item8">
                        <g:if test="${isSubscribed=='true'}">
                            <g:select disabled="true" class="subscriptonSeriousness" name="subscriptonSeriousness" from="['casual','serious','verySerious']" value="${Subscriptions.findByUserAndTopic(Users.findByUserName(session.sessionId),it).seriousness}"/>
                        </g:if>
                    </div>
                    <div class="item9">
                        <g:if test="${session.isAdmin==true||it.createdBy.userName==session.sessionIs}">
                            <g:select disabled="true" class="topicVisibility" name="topicVisibility" from="['Public','Private']" value="${it.visibility}"/>
                        </g:if>
                    </div>
                    <div class="item10">
                        <g:if test="${session.isAdmin==true||it.createdBy.userName==session.sessionIs}">
                            <div class="btn viewPostTopicEdit">Edit</div>
                            <div class="btn viewPostTopicDelete">Delete</div>
                        </g:if>
                    </div>




                </div>
            </div>
            </g:each>
        </div>
    </div>

</body>
</html>