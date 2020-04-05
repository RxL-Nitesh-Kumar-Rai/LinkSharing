$(document).ready(function() {
    $('.profileTopicsTable1').DataTable();
    $('.profileTopicsTable2').DataTable();
    $('.profileSubscriptionsTable').DataTable();
    $('.profilePostsTable').DataTable();
    $(".topicEdit").click(function () {
        $(this).parent().siblings().eq(1).children(".topicName").attr("disabled",false);
        $(this).parent().siblings().eq(2).children(".topicSave").attr("disabled",false);
        $(this).parent().siblings().eq(2).children(".topicCancel").attr("disabled",false);
        $(this).parent().siblings().eq(8).children(".topicSeriousness").attr("disabled",false);
        $(this).parent().siblings().eq(9).children(".topicVisibility").attr("disabled",false);
    });
    $(".topicCancel").click(function () {
        $(this).parent().siblings().eq(1).children(".topicName").attr("disabled",true);
        $(this).prev().attr("disabled",true);
        $(this).attr("disabled",true);
        $(this).parent().siblings().eq(7).children(".topicSeriousness").attr("disabled",true);
        $(this).parent().siblings().eq(8).children(".topicVisibility").attr("disabled",true)
    });
    $(".topicSave").click(function () {
        var topicName=$(this).parent().siblings().eq(1).children(".topicName").val();
        var topicId=$(this).next().next().text();
        var topicType=$(this).parent().siblings().eq(8).children(".topicVisibility").val();
        editTopic(topicName,topicId,topicType);
    });
    $(".topicDelete").click(function () {
        var topicId=$(this).parent().siblings().eq(2).children(".topicId").text();
        deleteTopic(topicId);
    });
    $(".topicSeriousness").change(function () {
        var topicId=$(this).parent().siblings().eq(2).children(".topicId").text();
        var topicSeriousness=$(this).val();
        changeTopicSeriousness(topicId,topicSeriousness);
    });

    $(".topicSeriousness2").change(function () {
        var topicId=$(this).prev().text();
        var topicSeriousness=$(this).val()
        changeTopicSeriousness(topicId,topicSeriousness);
    });
    $(".topicInvite").click(function () {
        $("#inputGroupSelect03").val($(this).prev().text()).attr('disabled',true);
        $("#navInvite").trigger("click");
    });
    $(".userProfileMarkAsRead").click(function () {
        var postId=$(this).next().text();
        markAsReadPost(postId);
    });
});