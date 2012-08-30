/**
 * Created with JetBrains RubyMine.
 * User: mhasani
 * Date: 8/29/12
 * Time: 2:22 PM
 * To change this template use File | Settings | File Templates.
 */

function vote(amnt){

    $.ajax({
        type: "GET",
        url: "/vote",
        data: "lesson_id=1&vote_val=" + amnt,
        dataType: "json",
        success: function(amnt){
            $('#current-rating').width(amnt * 25);
//            $('#current-rating-result').html(amnt);
            alert(amnt + " saved!");
        }
});
}
