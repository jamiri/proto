
// Please observe that the code in this file is not optimized nor it handles all occassions
// rather this is done to make a quick and dirty prototype

$(window).ready(function () {

        var lesson_id = document.getElementById("lesson_script").getAttribute("lesson_id");
        $.getJSON("/lesson/" + lesson_id + "/lookup_words", addTags);

    }

);

function addTags(data) {

    var lesson_script = document.getElementById("lesson_script").innerHTML;

    for (var word in data) {

        lesson_script = lesson_script.replaceAll
            (word, "<a href='/glossary/"+ word + "' class='glossary_entry' title='"
                + data[word] + "'>" + word + "</a>");

    }

    document.getElementById("lesson_script").innerHTML = lesson_script;

    addTooltips(data);

}


function addTooltips(data) {

    $(".glossary_entry").tipTip({defaultPosition:"top"});


}


/**
 * ReplaceAll by Fagner Brack (MIT Licensed)
 * Replaces all occurrences of a substring in a string
 */
String.prototype.replaceAll = function (token, newToken, ignoreCase) {
    var str, i = -1, _token;
    if ((str = this.toString()) && typeof token === "string") {
        _token = ignoreCase === true ? token.toLowerCase() : undefined;
        while ((i = (
            _token !== undefined ?
                str.toLowerCase().indexOf(
                    _token,
                    i >= 0 ? i + newToken.length : 0
                ) : str.indexOf(
                token,
                i >= 0 ? i + newToken.length : 0
            )
            )) !== -1) {
            str = str.substring(0, i)
                .concat(newToken)
                .concat(str.substring(i + token.length));
        }
    }
    return str;
};