$(document).ready(function() {

    //select all the a tag with name equal to modal
    $('a[name=modal]').click(function(e) {
        //Cancel the link behavior
        e.preventDefault();
        //Get the A tag
        var id = $(this).attr('href');

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
        $(id).css('top',  winH/2-$(id).height()/2);
        $(id).css('left', winW/2-$(id).width()/2);

        //transition effect
        $(id).fadeIn(200);

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

    var sign_up_form_options = {
        success: function() {
            $('#sign_up_form, #sign_up_txt, #sign_up_h').css('display', 'none');
            $('#sign_up_thanks').show();
            $('#mask, .window').delay(800).fadeOut(200);
        },

        beforeSerialize: function(form, options) {
            $('#sign_up_form input[name="sign_up[url]"]').val(document.URL);
        }
    };

    $('#sign_up_form').ajaxForm(sign_up_form_options);
});