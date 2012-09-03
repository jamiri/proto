/**
 * Created with JetBrains RubyMine.
 * User: mhasani
 * Date: 8/29/12
 * Time: 2:22 PM
 * To change this template use File | Settings | File Templates.
 */

function question_vote(question_id , amnt){
    $.ajax({
        type: "GET",
        url: document.URL + "/question/" + question_id + "/rating/" + amnt,
        dataType: "json",
        success: function(amnt){

            $("ul#li#star-rating-question" + question_id).width(amnt * 25);

        }
});
}
