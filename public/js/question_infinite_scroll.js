/**
 * Created with JetBrains RubyMine.
 * User: mhasani
 * Date: 8/12/12
 * Time: 12:42 PM
 * To change this template use File | Settings | File Templates.
 */

var question_page = 1;

var ended = false;

$(document).ready(function () {

    function lastAddedLiveFunc() {

        question_page = question_page +1;

        if (!ended) {
            //alert("hello");
            $('div#lastPostsLoader').html('<img src="/images/bigLoader.gif">');

            $.get(window.location.href + "/question/page/" + String(question_page), function (data) {
                if (data.trim() != "") {
                    //console.log('add data..');

                    $(".items").append(data);

                }
                else

                    ended = true;

                $('div#lastPostsLoader').empty();

            });
        }
    }

    ;

//lastAddedLiveFunc();
    $(window).scroll(function () {


        var wintop = $(window).scrollTop(),
            docheight = $(document).height(),
            winheight = $(window).height();
        var scrolltrigger = 0.98;

        var qaIsSelected = $('#qa').hasClass("ui-tabs-selected");

        if (((wintop / (docheight - winheight)) > scrolltrigger)
             && qaIsSelected && !ended) {

            lastAddedLiveFunc();
        }
    });
});