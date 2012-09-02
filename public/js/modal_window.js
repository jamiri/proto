$(document).ready(function() {

    //select all the a tag with name equal to modal
    $('a[name=modal]').click(function(e) {
        //Cancel the link behavior
        e.preventDefault();
        //Get the A tag
        var id = $(this).attr('href');

        showModal(id);
    });

    //if close button is clicked
    $('.window .close').click(function (e) {
        //Cancel the link behavior
        e.preventDefault();
        $('#mask, .window').fadeOut(200);
    });

    //if mask is clicked
    $('#mask').click(function () {
        $(this).fadeOut(200);
        $('.window').fadeOut(100);
    });
});

function showModal(window_id) {
    //Get the screen height and width
    var maskHeight = $(document).height();
    var maskWidth = $(window).width();

    //Set height and width to mask to fill up the whole screen
    $('#mask').css({'width':maskWidth,'height':maskHeight});

    //transition effect
    $('#mask').fadeIn(100);
    $('#mask').fadeTo("slow",0.8);

    //Get the window height and width
    var winH = $(window).height();
    var winW = $(window).width();

    //Set the popup window to center
    $(window_id).css('top',  winH/2-$(window_id).height()/2);
    $(window_id).css('left', winW/2-$(window_id).width()/2);

    //transition effect
    $(window_id).fadeIn(200);
}