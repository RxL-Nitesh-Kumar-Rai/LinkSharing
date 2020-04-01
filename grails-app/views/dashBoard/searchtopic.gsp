<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <asset:javascript src="application.js"/>
    <asset:javascript src="searchtopic.js" />

<meta name="layout" content="loginnav"/>
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
                        <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':searchtopic.createdBy.id])}"/>

                    </div>
                    <div class="card grid-pagecontent">
                        <div class="item1">${searchtopic.name} (${searchtopic.visibility})</div>
                        <div class="item2">${searchtopic.createdBy.userName}</div>
                        <div class="item3">Subscriptions</div>
                        <div class="item4">Post</div>
                        <div class="item5">
                            <g:set var="flag" value="false"/>
                            <g:if test="${session.sessionId!=searchtopic.createdBy.userName}">
                                <g:each in="${searchtopic.subscriptions}">
                                    <g:if test="${it.user.userName==session.sessionId}">
                                        <g:set var="flag" value="true"/>
                                    </g:if>
                                </g:each>
                                <g:if test="${flag=="true"}">

                                    <a href="" id="link1">Unsubscribe</a>
                                </g:if>
                                <g:else>
                                    <a href="" id="link2">Subscribe</a>
                                </g:else>
                            </g:if>
                        </div>
                        <div class="item6">${searchtopic.subscriptions.size()}</div>
                        <div class="item7">${searchtopic.resources.linkResources.flatten().size()+searchtopic.resources.documentResources.flatten().size()}</div>

                        <div class="item8">
                            <select id="seriousness2" class="form-control mr-sm-2 search" name="sub-unsub" >
                                <option value="sub=${searchtopic.id}&seriousness=casual">casual</option>
                                <option value="sub=${searchtopic.id}&seriousness=serious">Serious</option>
                                <option value="sub=${searchtopic.id}&seriousness=verySerious">Very Serious</option>
                            </select>
%{--                            <g:select name="selectseri" from="['casual','serious','verySerious']" value="${subscription.seriousness}"/>--}%

                        </div>


                    </div>
                </div>
            </div>
            <div class="card searchTopicUsers">
                <h5 class="card-title">Users: ${searchtopic.name}</h5>
                <div class="card-body grid2">
                    <g:each in="${searchtopic.subscriptions}">
                    <div class="card topicUsers">
                        <div class="topicUsers-item1">
                            <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.user.id])}"/>
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
                    </g:each>


                </div>
            </div>

        </div>
        <div class="card searchTopicPosts">
            </pre><h5 class="card-title">Posts: ${searchtopic.name}  </h5>
                <div class="card-body grid3">
                    <g:each in="${searchtopic.resources}">
%{--                        <g:if test="${it.readingitems}"--}%
                        <div class="card topicPosts">
                            <div class="topicPosts-item1">
                                <img height="90" style="margin-top: 20px;margin-left: 15px "  width="90" src="${createLink(controller: 'loginPage', action: 'viewImage', params: ['userId':it.createdBy.id])}"/>
                            </div>
                            <div class="topicPosts-item2">${it.description}</div>
                            <div class="topicPosts-item3"></div>
                            <div class="topicPosts-item4">
                                <g:if test="${it.linkResources}">
                                    View full site
                                </g:if>
                                <g:else>
                                    Download
                                </g:else>
                            </div>
                            <div class="topicPosts-item5">View post</div>
                        </div>
                    </g:each>

                </div>

        </div>
    </div>



</body>
</html>
