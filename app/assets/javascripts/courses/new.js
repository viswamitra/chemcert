$(function() {
    $(".datepicker").datepicker();
    $( "#anim" ).change(function() {
        $( "#course_course_date" ).datepicker( "option", "showAnim", $( this ).val() );
    });
});

