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
        question_page = question_page + 1;
    }

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

    var  i = 0;
    var txt="";

    // Load data rows.And create question And answer in javascript.
    for (var row in data) {

        i++;
        txt = txt + '<div class="QAbody">' + getTags_question_rating(row , (data[row]["rate_avg"]) * 25 ) + '<div class="question"><span class="id">' +
            data[row]["user_name"] + '</span><p>' + data[row]["question"] + '</p></div>';

        txt = txt + '<div class="answer"><span class="id">' + data[row]["answered_by"] + '</span><p>' +
            data[row]["answer"] + '</p></div></div>';
        $(".items").append(txt);
        txt="";

    }

    // This code is for end of load the new page.Because we need end the new page.
    if (i < 1) {
        ended = true;
    }

    $('div#lastPostsLoader').empty();

}
function getTags_question_rating(id_question , average_value)
{
    var tx='';
    txt = '<ul class="star-rating-question" id="star-rating-question' + id_question + '" style="background: url(/images/alt_star.png) ;">';
    txt =  txt + '<li class="current-rating-question" id="current-rating-question' + id_question + '" style="width: ' + average_value + 'px"></li>';
    txt =  txt + '<li><a href="#" onclick="question_vote(' + id_question + ', 1); return false;"';
    txt =  txt + ' title="1 star out of 5" class="one-star">1</a></li>';
    txt =  txt + '<li><a href="#" onclick="question_vote(' + id_question + ' , 2); return false;"';
    txt =  txt + 'title="2 star out of 5" class="two-stars">2</a></li>';
    txt =  txt + '<li><a href="#" onclick="question_vote(' + id_question + ' , 3); return false;"';
    txt =  txt + ' title="3 star out of 5" class="three-stars">3</a></li>';
    txt =  txt + ' <li><a href="#" onclick="question_vote(' + id_question + ' , 4); return false;"';
    txt =  txt + ' title="4 star out of 5" class="four-stars">4</a></li>';
    txt =  txt + '<li><a href="#" onclick="question_vote(' + id_question + ', 5); return false;"';
    txt =  txt + ' title="5 star out of 5" class="five-stars">5</a></li></ul>';
    return txt;
}

