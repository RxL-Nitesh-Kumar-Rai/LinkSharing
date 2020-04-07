var subscribe=function (topicId,seriousness) {
    $.ajax({
        url:"/dashBoard/subscribe",
        type:"POST",
        data:{"sub":topicId,"seriousness":seriousness},
        success:function(data){
            if(data.success==true){
                $("#hidden-field-success").attr("hidden",false).text("Subscribed successfully").fadeToggle(3000).fadeOut(3000,function () {
                    location.reload();
                });
            }
            else{
                $("#hidden-field-fail").attr("hidden",false).text("Unable to subscribe").fadeToggle(3000).fadeOut(3000);
            }
        },
        error:function () {
            $("#hidden-field-fail").attr("hidden", false).text("Login first").fadeToggle(3000).fadeOut(3000)
        },
    });

};

var unsubscribe=function (topicId) {
    $.ajax({
        url:"/dashBoard/unsubscribe",
        type:"POST",
        data:{"sub":topicId},
        success:function(data){
            if(data.success==true){
                $("#hidden-field-success").attr("hidden",false).text("Unsubscribed successfully").fadeToggle(3000).fadeOut(3000,function () {
                    location.reload();
                });
            }
            else{
                $("#hidden-field-fail").attr("hidden",false).text("Unable to unsubscribe").fadeToggle(3000).fadeOut(3000);
            }
        },
        error:function () {
            $("#hidden-field-fail").attr("hidden", false).text("Login first").fadeToggle(3000).fadeOut(3000)
        },
    });
};

var changeTopicSeriousness=function (topicId,topicSeriousness) {
    $.ajax({
        url:"/dashBoard/changeTopicSeriousness",
        type:"POST",
        data:{"topicId":topicId,"topicSeriousness":topicSeriousness},
        success:function(data){
            if(data.success==true){
                $("#hidden-field-success").attr("hidden",false).text("Changed seriousness successfully").fadeToggle(3000).fadeOut(3000,function () {
                    location.reload();
                });
            }
            else{
                $("#hidden-field-fail").attr("hidden",false).text("Unable to change seriousness").fadeToggle(3000).fadeOut(3000);
            }
        },
        error:function () {
            $("#hidden-field-fail").attr("hidden", false).text("Login first").fadeToggle(3000).fadeOut(3000)
        },
    });
};

var markAsReadPost=function (postId) {
    $.ajax({
        url:"/resources/markAsReadPost",
        type:"POST",
        data:{"postId":postId},
        success:function(data){
            if(data.success==true){
                $("#hidden-field-success").attr("hidden",false).text("Post has been marked").fadeToggle(3000).fadeOut(3000,function () {
                    location.reload();
                });
            }
            else{
                $("#hidden-field-fail").attr("hidden",false).text("You don't have access to do it").fadeToggle(3000).fadeOut(3000);
            }

        },
        error:function () {
            $("#hidden-field-fail").attr("hidden",false).text("You don't have access to do it").fadeToggle(3000).fadeOut(3000);
        }
    });

};

$(document).ready(function(){
    $('.topicUsersTable').DataTable();
    $('.topicPostsTable').DataTable();
$('#link1').click(function(){
    var topicId=$(this).parent().children(".topicId").text();
    unsubscribe(topicId)
    });

    $('#link2').click(function(){
        var topicId=$(this).parent().children(".topicId").text();
        var seriousness='casual';
        subscribe(topicId,seriousness)

    });
    $("#seriousness2").change(function () {
        var topicId=$(this).parent().siblings().eq(4).children(".topicId").text();
        var topicSeriousness=$(this).val();
        changeTopicSeriousness(topicId,topicSeriousness)
    });
    $(".btn.markAsReadPost").click(function () {
        var postId=$(this).prev().text();
        // alert(postId)
        markAsReadPost(postId)
    });
    $("#topicInvite").click(function () {
        $("#inputGroupSelect03").val($(this).prev().text()).attr('disabled',true);
        $("#navInvite").trigger("click");
    });
});

