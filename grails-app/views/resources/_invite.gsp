<%@ page contentType="text/html;charset=UTF-8" %>
<html>
%{--<head>--}%
%{--    <style>--}%
%{--        .btn{--}%
%{--            max-height: 30px;--}%
%{--            max-width: 30px;--}%
%{--        }--}%
%{--    </style>--}%
%{--</head>--}%
<body>
<!-- Button trigger modal -->
<button type="button" class="btn" data-toggle="modal" data-target="#staticBackdrop">
    <g:img dir="images"  file="invite.png" height="30px" width="30px" class="subscriptionInvite1" title="Click to invite"/>
</button>

<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <g:uploadForm name="shareLink" id="form1" controller="resources" action="sendInvitation" target="parent" >

                    <div class="modal-body" >
                        <pre>Email*:       <input type="email" name="emailInvite" required size="33" required/></pre>
                        Topic*:
                        <div class="input-group mb-3">
                            <g:select class="custom-select" id="modalInvite" name="emailTopic" value="" from="${Topic.createCriteria().list()}" optionKey="id" optionValue="name" required="true" disabled="true"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary" value="submit">Invite</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </g:uploadForm>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Understood</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>