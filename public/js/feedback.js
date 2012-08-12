$(document).ready(function() {

    var feedback_form_options = {
        success: function() {
            $('#feedback_form_wrapper').hide();
            $('#feedback_thanks').show();
            $('#mask, .window').delay(800).fadeOut(200);
        },

        beforeSerialize: function(form, options) {
            $('#feedback_form input[name="feedback[url]"]').val(document.URL);
        }
    };

    $('#feedback_form').ajaxForm(feedback_form_options);

});