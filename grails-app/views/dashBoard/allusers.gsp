<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
        <title>All users</title>
    <meta name="layout" content="navbar"/>
    <script>

        $(document).ready( function () {
            $('.table.table-bordered.table-dark').DataTable();
        } );
    </script>
    <style>
        .table{
            color: black;
        }
    </style>
</head>

<body>

    <table class="table table-bordered table-dark">
        <col width="50">
        <col width="200">
        <col width="400">
        <col width="200">
        <col width="150">
        <col width="50">
        <col width="200">
        <thead>
        <tr>
            <th scope="col">Id</th>
            <th scope="col">Username</th>
            <th scope="col">Email</th>
            <th scope="col">Firstname</th>
            <th scope="col">Lastname</th>
            <th scope="col">Active</th>
            <th scope="col">Manage</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${users}">
        <tr>
            <td>${it.id}</td>
            <td>${it.userName}</td>
            <td>${it.email}</td>
            <td>${it.firstName}</td>
            <td>${it.lastName}</td>
            <g:set id="userId" var="userId" value="${it.id}" />
            <g:if test="${it.active==true}">
                <td>Yes</td>
                <td><g:link controller="dashBoard" id="activeID" action="changestatus" params="[status:'1',userId:userId]">DeActivate</g:link></td>
            </g:if>
            <g:else>
                <td>No</td>
                <td><g:link controller="dashBoard" id="inactiveId" action="changestatus" params="[status:'0',userId:userId]">Activate</g:link></td>
            </g:else>
        </tr>
        </g:each>
        </tbody>
    </table>


</body>
</html>
