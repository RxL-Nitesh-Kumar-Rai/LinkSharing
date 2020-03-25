<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<html xmlns="http://www.w3.org/1999/html">
<head>

<meta name="layout" content="loginnav"/>
<title>Search topic</title>
<style>
.card.searchtopic{
    display: grid;
    grid-template-columns: 40rem 40rem;
}
.card-body.grid{
    display: grid;
    grid-template-columns: 8rem 30rem;
    min-height: 10rem;
    background-color: #71dd8a;
}
    .item1 { grid-area: header; }
    .item2 { grid-area: main1; }
    .item3 { grid-area: main2; }
    .item4 { grid-area: main3; }
    .item5 { grid-area: body1; }
    .item6 { grid-area: body2; }
    .item7 { grid-area: body3; }
    .item8 { grid-area: foot1; }
    .card.grid-pagecontent{
        display: grid;
        grid-template-areas:    "header header header1"
                                "main1 main2 main3"
                                "body1 body2 body3"
                                "foot foot1 foot1 ";
        grid-template-rows: 25% 25% 25% 25%;
        background-color: #71dd8a;
        color: #000000;
    }
    .form-control.mr-sm-2.search{
        height: 25px;
        width: 100px;
        font-size: 16px;
        text-align: center;
        padding-top: 2px;
        box-shadow: 0 0 2px rgba(0,0,0,0.2);
        background-color: #bee5eb;
    }
</style>
<script>
    // $(document).ready(function(){
    //     $("#seriousness2").onchange(function(){
    //         $("#link2").attr('params',[seriousness,$("#seriousness2").val()]);
    //     });
    // });

</script>

</head>
<body>
<g:each in="${searchtopic}">
    <div class="card searchtopic">
        <div>
            <div class="card">
                %{--                <div class="card">--}%
                <h5 class="card-title">Topic: ${searchtopic.name}</h5>
                <div class="card-body grid">
                    <div>
                        <g:img dir="/home/nitesh/Downloads" file="profile.png" heigth="120" width="120"/>

                    </div>
                    <div class="card grid-pagecontent">
                        <div class="item1">${searchtopic.name} (${searchtopic.visibility})</div>
                        <div class="item2">${searchtopic.createdBy.userName}</div>
                        <div class="item3">Subscriptions</div>
                        <div class="item4">Post</div>
                        <div class="item5">
                            <g:set var="flag" value="false"/>
                            <g:if test="${session.sessionId!=searchtopic.createdBy.userName}">
                                <g:each in="${subscription}">
                                    <g:if test="${it.user.userName==session.sessionId}">
                                        <g:set var="flag" value="true"/>
                                    </g:if>
                                </g:each>
                                <g:if test="${flag=='true'}">
                                    <g:link id="link1" controller='dashBoard' action="unsubscribe" params="[unsub: searchtopic.id]">
                                        Unsubscribe
                                    </g:link>
                                </g:if>
                                <g:else>
                                    <g:link  id="link2" action="subscribe" params="[sub: searchtopic.id,seriousness:'casual']">
                                        Subscribe
                                    </g:link>
                                </g:else>
                            </g:if>
                        </div>
                        <div class="item6">${subscription.size()}</div>
                        <div class="item7">${linkResource.size()+documentResource.size()}</div>

                        <div class="item8">
                            <select id="seriousness2" class="form-control mr-sm-2 search" name="sub-unsub">
                                <option value="casual">casual</option>
                                <option value="serious">Serious</option>
                                <option value="verySerious">Very Serious</option>
                            </select>
                        </div>
                            <button type="submit" id="hidbut"hidden></button>


                    </div>
                </div>
                %{--                </div>--}%
            </div>
            <div class="card">
                %{--                <div class="card">--}%
                <h5 class="card-title">Users: ${searchtopic.name}</h5>
                <div class="card-body grid">

                </div>
                %{--                </div>--}%
            </div>

        </div>
        <div>
            <div class="card">
            </pre><h5 class="card-title">Posts: ${searchtopic.name}  </h5>
                <div class="card-body grid">

                </div>
            </div>

        </div>
    </div>

</g:each>


</body>
</html>
