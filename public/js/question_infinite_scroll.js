/**
 * Created with JetBrains RubyMine.
 * User: mhasani
 * Date: 8/12/12
 * Time: 12:42 PM
 * To change this template use File | Settings | File Templates.
 */

var question_page = 0;

var ended = false;

$(document).ready(function () {

    function lastAddedLiveFunc() {

        if (ended) {
        } else {

            $('div#lastPostsLoader').html('<img src="/images/bigLoader.gif">');

            $.getJSON(window.location.href + "/question/page/" + String(question_page), addTags_question_row);

        }
        question_page = question_page +1;
    };
    lastAddedLiveFunc();
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


function addTags_question_row(data) {

    var txt,i=0;

    // Load data rows.And create question And answer in javascript.
    for (var row in data) {

        i++;

        txt = '<div class="QAbody"><div class="question"><span class="id">' + data[row]["user_name"] + '</span><p>' + data[row]["question"] + '</p></div>';

        txt = txt + '<div class="answer"><span class="id">' + data[row]["answered_by"] + '</span><p>' + data[row]["answer"] + '</p></div></div>';

        $(".items").append(txt);

    }

    // This code is for end of load the new page.Because we need end the new page.
    if(i<1)
    {
        ended=true;
    }

    $('div#lastPostsLoader').empty();

}
