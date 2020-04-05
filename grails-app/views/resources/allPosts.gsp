<%--
  Created by IntelliJ IDEA.
  User: nitesh
  Date: 05/04/20
  Time: 5:08 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>All posts</title>
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
    <col width="20">
    <col width="500">
    <col width="500">
    <col width="200">

    <thead>
    <tr>
        <th scope="col">Id</th>
        <th scope="col">Topic name</th>
        <th scope="col">Description</th>
        <th scope="col">View post</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${posts}">
        <tr>
            <td>${it.id}</td>
            <td>
                <g:link controller='dashBoard' action="searchtopic" params="[searchtopic: it.resource.topic.id]">
                    ${it.resource   .topic.name}
                </g:link>
            </td>
            <td>${it.description}</td>
            <td>
                <g:link controller='resources' action="viewPost" params="[postId: it.id]">
                    View post
                </g:link>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>


</body>
</html>