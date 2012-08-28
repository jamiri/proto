/**
 * Created with JetBrains RubyMine.
 * User: mhasani
 * Date: 8/12/12
 * Time: 12:42 PM
 * To change this template use File | Settings | File Templates.
 */

var question_page = 1;

var ended = false;
alert("sssssssssss");
$(document).ready(function () {

    function lastAddedLiveFunc() {

        question_page = question_page +1;
        if (!ended) {



            $('div#lastPostsLoader').html('<img src="/images/bigLoader.gif">');

            //$.getJSON(window.location.href + "/question/page/" + String(question_page), addTags);

        }
    };

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
function addTags(data) {

    var sub_data;

    var txt;

    data=JSON.parse(data);

    for (var row in data) {

        var sub_data = data[row];

           txt = '<div class="QAbody"><div class="question"><span class="id">' + sub_row.user_name + '</span><p>' + sub_row.question + '</p></div>';

           txt = txt + <div class="answer"><span class="id">' + sub_row.answered_by + '</span><p>' + sub_row.answer + '</p></div></div>';

           $(".items").append(data);

    }

    $('div#lastPostsLoader').empty();

}
