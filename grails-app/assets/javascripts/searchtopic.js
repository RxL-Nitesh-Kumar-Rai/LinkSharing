$(document).ready(function(){
$('#link1').click(function(){

    var li="/dashBoard/unsubscribe/link1?"+$('#seriousness2').val()
    $('#link1').attr("href",li)
    });

    $('#link2').click(function(){
        var li="/dashBoard/subscribe/link2?"+$('#seriousness2').val()
        $('#link2').attr("href",li)

    });
});

