var editTopic=function (topicName,topicId,topicType) {
    $.ajax({
        url:"/dashBoard/editTopic",
        type:"POST",
        data:{"topicId":topicId,"topicName":topicName,"topicType":topicType},
        success:function(data){
            if(data.success==true){
                $("#hidden-field-success").attr("hidden",false).text("Topic edited").fadeToggle(3000).fadeOut(3000,function () {
                    location.reload();
                });
            }
            else{
                $("#hidden-field-fail").attr("hidden",false).text("You don't have access to do it").fadeToggle(3000).fadeOut(3000);
            }
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
                $("#hidden-field-success").attr("hidden",false).text("Seriousness changed").fadeToggle(3000).fadeOut(3000);
            }
            else{
                $("#hidden-field-fail").attr("hidden",false).text("You don't have access to do it").fadeToggle(3000).fadeOut(3000);
            }
        },
    });

};

var deleteTopic=function (topicId) {
    $.ajax({
        url:"/dashBoard/deleteTopic",
        type:"POST",
        data:{"topicId":topicId},
        success:function(data){
            if(data.success==true){
                $("#hidden-field-success").attr("hidden",false).text("Topic has been deleted").fadeToggle(3000).fadeOut(3000,function () {
                    location.reload();
                });
            }
            else{
                $("#hidden-field-fail").attr("hidden",false).text("You don't have access to do it").fadeToggle(3000).fadeOut(3000);
            }
        },
        error:function () {
            $("#hidden-field-fail").attr("hidden", false).text("Unable to do it").fadeToggle(3000).fadeOut(3000)
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
                $("#hidden-field-success").attr("hidden",false).text("Post has been marked as read").fadeToggle(3000).fadeOut(3000,function () {
                    location.reload();
                });
            }
            else{
                $("#hidden-field-fail").attr("hidden",false).text("You don't have access to do it").fadeToggle(3000).fadeOut(3000);
            }

        },
    });

};

$(document).ready(function(){
    $('.inboxReadingItems').DataTable();
    $('.dashboardSubscriptionsTable').DataTable();
       $(".subscriptionEdit").click(function () {
           $(this).parent().siblings().eq(1).children().attr('hidden',true);
           $(this).parent().siblings().eq(1).children("input.subscriptionTopic").attr('hidden',false);
           $(this).parent().siblings().eq(2).children("input.btn.btn-primary.subscriptionSave").attr('hidden',false);
           $(this).parent().siblings().eq(2).children("input.btn.btn-secondary.subscriptionCancel").attr('hidden',false );
           $(this).parent().siblings().eq(9).children().attr('disabled',false );

    });
    $(".subscriptionSave").click(function () {
        var topicName=$(this).parent().siblings().eq(1).children("input.subscriptionTopic").val()
        var topicId=$(this).prev().text()
        var topicType=$(this).parent().siblings().eq(8).children(".subscriptionTopicType").val()
        editTopic(topicName,topicId,topicType)


    });
    $(".subscriptionCancel").click(function () {
        $(this).parent().siblings().eq(1).children("input.subscriptionTopic").attr('hidden',true)
        $(this).parent().siblings().eq(8).children(".subscriptionTopicType").attr("disabled",true)
        $(this).parent().siblings().eq(8).children(".subscriptionTopicSeriousness").attr("disabled",true)
        $(this).prev().attr("hidden",true)
        $(this).attr("hidden",true)
        $(this).parent().siblings().eq(1).children(".subscriptionTopicName").attr('hidden',false);
    });
    $(".subscriptionTopicSeriousness").change(function () {
        var topicId=$(this).parent().siblings().eq(2).children(".topicId").text();
        var topicSeriousness=$(this).val();
        changeTopicSeriousness(topicId,topicSeriousness);

    });
    $(".subscriptionDelete").click(function () {
        var topicId=$(this).parent().siblings().eq(2).children(".topicId").text();
        deleteTopic(topicId);
    });

    $(".markReadPost").click(function () {
        var postId=$(this).next().text();
        markAsReadPost(postId);
    });

    $(".trendingTopicEdit").click(function () {
        $(this).parent().siblings().eq(1).children(".trendingTopicNameLink").attr('hidden',true);
        $(this).parent().siblings().eq(1).children("input.trendingTopicName").attr('hidden',false);
        $(this).parent().siblings().eq(2).children("button.btn.btn-primary.saveTrendingTopic").attr('hidden',false);
        $(this).parent().siblings().eq(3).children("button.btn.btn-secondary.cancelTrendingTopic").attr('hidden',false );
        $(this).parent().siblings().eq(10).children(".trendingTopicSeriousness").attr('disabled',false );
        $(this).parent().siblings().eq(11).children(".trendingTopicType").attr('disabled',false );

    });

    $(".saveTrendingTopic").click(function () {
        var topicName=$(this).parent().siblings().eq(1).children("input.trendingTopicName").val()
        var topicId=$(this).parent().siblings().eq(1).children(".trendingTopicId").text()
        var topicType=$(this).parent().siblings().eq(10).children(".trendingTopicType").val()
        editTopic(topicName,topicId,topicType)
    });
    $(".cancelTrendingTopic").click(function () {
        $(this).parent().siblings().eq(1).children(".trendingTopicNameLink").attr('hidden',false);
        $(this).parent().siblings().eq(1).children("input.trendingTopicName").attr('hidden',true);
        $(this).parent().siblings().eq(2).children("button.btn.btn-primary.saveTrendingTopic").attr('hidden',true);
        $(this).attr("hidden",true)
        $(this).parent().siblings().eq(9).children(".trendingTopicSeriousness").attr('disabled',true );
        $(this).parent().siblings().eq(10).children(".trendingTopicType").attr('disabled',true );
    });

    $(".trendingTopicSeriousness").change(function () {
        var topicId=$(this).parent().siblings().eq(1).children(".trendingTopicId").text();
        var topicSeriousness=$(this).val();
        changeTopicSeriousness(topicId,topicSeriousness);
    });

    $(".trendingTopicDelete").click(function () {
        var topicId=$(this).parent().siblings().eq(1).children(".trendingTopicId").text();
        deleteTopic(topicId);
    });
    $(".subscriptionInvite").click(function () {
        $("#inputGroupSelect03").val($(this).prev().text()).attr('disabled',true);
        $("#navInvite").trigger("click");

    });

    $(".trendingTopicInvite").click(function () {
        // openInviteTemplate()
        $("#inputGroupSelect03").val($(this).prev().text()).attr('disabled',true);
        $("#navInvite").trigger("click");
    });
    $(".subscriptionsUnsubscribe").click(function () {
        var topicId=$(this).next().text();
        unsubscribe(topicId);
    });
    $(".trendingTopicLink1").click(function () {
        var topicId=$(this).next().text();
        unsubscribe(topicId);
    });
    $(".trendingTopicLink2").click(function () {
        var topicId=$(this).next().text();
        var seriousness='casual';
        subscribe(topicId,seriousness);
    });
});

