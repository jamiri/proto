//----------------------------- created By meghdad hasani //-----------------------------------------

/*$(document).ready(function() {
    $('#signinbutton').click(function(e)
    {
        alert('hello');
    } );
    var login_form_options = {
        success: function() {
            //$('#loginform').css('display', 'none');
            //$('#sign_up_thanks').show();
            $('#loginform').delay(800).fadeOut(200);
        },

        beforeSerialize: function(form, options) {
            $('#loginform input[name="login[url]"]').val(document.URL);
        }
    };

    $('#loginform').ajaxForm(login_form_options);
});
