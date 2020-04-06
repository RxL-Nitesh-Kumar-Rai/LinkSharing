<%--
  Created by IntelliJ IDEA.
  User: nitesh
  Date: 06/04/20
  Time: 9:08 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="loginnav"/>
    <title>changePass</title>
</head>

<body>
    <g:form class="card" controller="loginPage" action="updatePassword">
        <div class="card-title">Change Pass</div>
        <div class="card-body">
           <pre>UserName*    <input name="userName" type="text" required/></pre>
            <pre>New password* <input name="password" type="password" required/></pre>
            <button type="submit" >Submit</button>
        </div>
    </g:form>
</body>
</html>