<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
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
        <col width="20">
        <col width="500">
        <col width="500">
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
        <g:each in="${topics}">
        <tr>
            <td>${it.id}</td>
            <td>
                <g:link controller='dashBoard' action="searchtopic" params="[searchtopic: it.id]">
                    ${it.name}
                </g:link>
            </td>
            <td>${it.createdBy.userName}</td>
            <td>${it.visibility}</td>
        </tr>
        </g:each>
        </tbody>
    </table>


</body>
</html>
