$(function() {
    $(".datepicker").datepicker({ dateFormat: 'yy-mm-dd' });
    $( "#anim" ).change(function() {
        $( "#course_course_date" ).datepicker( "option", "showAnim", $( this ).val() );
    });
});

var CHEMCERT = CHEMCERT || {};

CHEMCERT.utils = {};

CHEMCERT.utils.ch_message = {
    add:function(msg, type, action, time, divid){
        var msg_id = "global-message";
        if(divid != undefined){
            msg_id = divid;
        }
        //type can be : 'error', 'done', 'info'
        if(action == undefined || action == ""){
            $("#"+msg_id).removeClass().addClass("line msg "+type).empty().text(msg);
        }else if(action == "append"){
            $("#"+msg_id).removeClass().addClass("line msg "+type).append(msg);
        }
        if(time != undefined && time != ""){
            if(divid != undefined){
                $("#"+msg_id).show().fadeOut(time);
            }else{
                $("#"+msg_id).hide().fadeIn(time);
            }
        }
    },
    clear:function(divid){
        var msg_id = "global-message";
        if(divid != undefined){
            msg_id = divid;
        }
        $("#"+msg_id).empty();
    }
};

