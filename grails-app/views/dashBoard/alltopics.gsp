<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <title>All users</title>
    <meta name="layout" content="navbar"/>
</head>

<body>
<g:each in="${topics}">
    <table class="table table-bordered table-dark">
        <col width="50">
        <col width="300">
        <col width="400">
        <col width="200">

        <thead>
        <tr>
            <th scope="col">Id</th>
            <th scope="col">Name</th>
            <th scope="col">CreatedBy</th>
            <th scope="col">Visibility</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>${it.id}</td>
            <td>${it.name}</td>
            <td>${it.createdBy.userName}</td>
            <td>${it.visibility}</td>
        </tr>
        </tbody>
    </table>
</g:each>

</body>
</html>
