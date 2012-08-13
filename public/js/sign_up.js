$(document).ready(function() {

    var sign_up_form_options = {
        success: function() {
            $('#sign_up_form_wrapper').hide();
            $('#sign_up_thanks').show();
            $('#mask, .window').delay(800).fadeOut(200);
        }
    };

    $('#sign_up_form').ajaxForm(sign_up_form_options);
});