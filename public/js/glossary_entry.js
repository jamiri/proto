
$(window).ready(function () {

        // get the lesson id from lesson_id attribute of an element with "lesson_script" id
        var lesson_id = document.getElementById("lesson_script").getAttribute("lesson_id");

        // get all the words with their respective meanings from the server in Json format
//        $.getJSON("/lesson/" + lesson_id + "/lookup_words", addTags);

    }

);

function addTags(data) {

    // get the script of lesson
    var lesson_script = document.getElementById("lesson_script").innerHTML;


    for (var word in data) {


        // replace all apostrophes in the definition with their respecting code
        var escaped_definition = data[word].replaceAll("'", "&#39;");

        // replace all double quotations in the definition with their respecting code
        escaped_definition = escaped_definition.replaceAll('"', '&quot;');

        // enclose all occurences of a word inside lesson script with a tag
        lesson_script = lesson_script.replaceAll
            (word, "<a href='/glossary/"+ word + "' class='glossary_entry' title='"
                + escaped_definition + "'>" + word + "</a>");

    }

    // replace lesson script with new content consisting of span tags
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