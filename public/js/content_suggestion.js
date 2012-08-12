$(document).ready(function() {

    var feedback_form_options = {
        success: function() {
            $('#cs_form_wrapper').hide()
            $('#content_suggestion_thanks').show();
            $('#mask, .window').delay(800).fadeOut(200);
        }
    };

    $('#content_suggestion_form').ajaxForm(feedback_form_options);

});