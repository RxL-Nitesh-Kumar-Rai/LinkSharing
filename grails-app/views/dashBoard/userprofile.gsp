<%--
  Created by IntelliJ IDEA.
  User: nitesh
  Date: 26/03/20
  Time: 9:58 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="navbar"/>
    <title>My profile</title>
    <style>
        .card{
            margin: 1rem;
            border-width: 4px;
            border-radius: 24px;
            border-color: #1c7430;
            width: 38.5rem;
        }
        .main-body{
            display: grid;
            grid-template-columns: 40.5rem 30.5rem;
            background-color: #bee5eb;
        }
        .card.body1-card1{
            display: grid;
            grid-template-columns: 10rem 24rem;
            height: 10rem;
            background-color: #71dd8a;
            display: grid;
        }
        .body1-card1-grid{
            display: grid;
            grid-template-areas:
                    'header header'
                    'main1 main2'
                    'footer1 footer2'
                    'last1 last2';
        }
        .item1 { grid-area: header; }
        .item2 { grid-area: main1; }
        .item3 { grid-area: footer1; }
        .item4 { grid-area: footer2; }
        .item5 { grid-area: last1; }
        .item6 { grid-area: last2; }
        .card-title{
            font-size: 2rem;
            text-align: center;
        }

        .card.body1-card2{
            background-color: #71dd8a;
        }
        .card.body2-card2{
            background-color: #71dd8a;
        }
        .card-body.bo1-ca2{
            height: 15rem   ;
            display: grid;
            grid-template-areas:    'head1 head2 head2 head3'
                                    'head1 main4 main5 main6'
                                    'main main4 body7 body8'
                                    'foot9 foot10 foot11 foot12';
        }
        .item1-1{grid-area: head1}
        .item1-2{grid-area: head2}
        .item1-3{grid-area: head3}
        .item1-4{grid-area: main4}
        .item1-5{grid-area: main5}
        .item1-6{grid-area: main6}
        .item1-7{grid-area: body7}
        .item1-8{grid-area: body8}
        .item1-9{grid-area: foot9}
        .item1-10{grid-area: foot10}
        .item1-11{grid-area: foot11}
        .item1-12{grid-area: foot12}

        input.topicnew{
        width: 20rem;
        }
        #topicselect{
        width: 6rem;

        }
        #seriselect{
            width: 6rem;

        }


    </style>
    <script>
    $(document).ready(function() {
        $('#edit').on('click',function(){
            $("#topicname").attr("disabled",false);
            $("#submit").attr("disabled",false);
            $("#topicselect").attr("disabled",false);
            $("#seriselect").attr("disabled",false);
            $("#invite").attr("disabled",false);
            $("#delete").attr("disabled",false);
        });

    });
</script>
</head>

<div class="main-body">

        <div class="body1">
                <div class="card body1-card1">
                    <div>
                        for image
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
            <g:if test="${session.sessionId}">
                <g:if test="${session.sessionId==user.userName}">




            <div class="body1-item1">
                <div class="card body1-card2">
                    <div class="card-title">Topics</div>
                    <g:form controller="dashBoard" action="updatetopic">
                    <div class="card-body bo1-ca2">

                        <div class="item1-1">for image</div>
                            <div class="item1-2"><input type="text" id="topicname" class="topicnew" value="" disabled/></div>
                            <div class="item1-3"><input type="submit" id="submit" value="Save" disabled/></div>
                            <div class="item1-4">${user.userName}444</div>
                            <div class="item1-5">Subscriptions555</div>
                            <div class="item1-6">Post666</div>
                            <div class="item1-7">"sub.size"7777</div>
                            <div class="item1-8">"topic.size"888</div>
                            <div class="item1-9">
                                <g:select id="topicselect" name="up-seri" from="['casual','serious','verySerious']" disabled="true"/>
                            </div>
                            <div class="item1-10">
                                <g:select id="seriselect" name="up-visi" from="['Private','Public']" disabled="true"/>
                            </div>
                            <div class="item1-11">
                                <g:img id="edit" dir="images" file="edit.png" height="30" width="30" title="Edit"/>
                                <g:img id="invite" dir="images" file="invite.png" height="30" width="30" title="Invite" disabled="true"/>
                            </div>
                            <div class="item1-12">
                                <g:if test="${(session.isAdmin==true) || (topic.createdBy.userName==session.sessionId)}">
                                    <g:img id="delete" dir="images" file="delete.png" height="30" width="30" title="Delete" disabled="true"/>
                                </g:if>
                            </div>

                    </div>
                    </g:form>
                </div>
            </div>
        </div>
        <div class="body2">
            <div class="card body2-card2">
                <div class="card-title"> Profile</div>
                <div class="card-body">
                    <g:form controller="dashBoard" action="userupdate">
                        <pre>First name*          <input type="text" name="firstName" required/></pre>
                        <pre>Last name*           <input type="text" name="lastName" required/></pre>
                        <pre>Username*            <input type="text" name="userName" required/></pre>
                        <pre>Photo                <input type="file" name="photo"/></pre>
                        <input type="submit" class="btn btn-primary">
                    </g:form>
                </div>

            </div>
            <div class="card body2-card2">
                <div class="card-title"> Change password</div>
                <div class="card-body">
                    <g:form controller="dashBoard" action="changepass">
                        <pre>Password*             <input type="password" name="password" id="pass" required/></pre>
                        <pre>Confirm password*     <input type="password" name="cPassword" id="cPass" required/></pre>
                        <input type="submit" class="btn btn-primary" id="btn-2">
                    </g:form>
                </div>

            </div>
        </div>
                </g:if>
            </g:if>
    </div>

</body>
</html>