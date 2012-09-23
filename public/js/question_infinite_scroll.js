/**
 * Created with JetBrains RubyMine.
 * User: mhasani
 * Date: 8/12/12
 * Time: 12:42 PM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function () {
    var item = $('.QAbody').first().clone();
    $('.QAbody').first().html("");
    initInfiniScroll($('.items'), function (page) {
        return "/lesson/" + $('.script:first').attr('lesson_id') + "/question/page/" + page;
    }, function (data) {
            $(data).each(function () {
                item.clone()
                    .find(".question").find(".id").html(this.question.user.name).end().end()
                    .find(".question").find("p").html(this.question.question).end().end()
                    .find(".answer").find(".id").html(this.question.answered_by).end().end()
                    .find(".answer").find("p").html(this.question.answer).end().end()
                    .find(".rating").html(getTags_question_rating(this.question.id, this.question.rating_average * 25)).end()
                    .appendTo($(".items"));
            });
    });
});
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

