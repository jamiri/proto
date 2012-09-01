$(document).ready(function () {

        // get the lesson id from lesson_id attribute of an element with "lesson_script" id
        var lesson_id = $("#lesson_script").attr("lesson_id");

        // get all the words with their respective meanings from the server in Json format
        $.getJSON("/lesson/" + lesson_id + "/lookup_words", addTags);
    }

);

function htmlEntities(str) {
    return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}

function addTags(data) {

    $(data).each(function() {
        var ge = this.glossary_entry;

        $("#lesson_script_body")
            .contents()
            .filter(function() {

                return this.nodeType === 3; // this.nodeType === TextNode

            }).replaceWith(function() {

                return this.nodeValue.replace(new RegExp(["(\\s)", "(", ge.name, ")", "(\\s)"].join(''), "ig"),
                    function(match, p1, p2, p3) {
                        return [p1, "<a href='#' class='glossary_entry' title='", htmlEntities(ge.short_definition),
                            "'>", p2, "</a>", p3].join('');
                    }
                );

            });
    });

    $(".glossary_entry").tipTip({defaultPosition:"top"});
}




/**
 * ReplaceAll by Fagner Brack (MIT Licensed)
 * Replaces all occurrences of a substring in a string
 */
/*
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
*/