var scrolltrigger = 0.95;

function initInfiniScroll(elem, url, callback) {
    if (!elem) return false;
    if (!(elem instanceof jQuery)) {
        elem = $(elem);
    }

    elem.page = 1;
    elem.fetching = false;

    $(window).scroll(function () {

        if (elem.is(':visible')) {
            var wintop = $(window).scrollTop(),
                docheight = $(document).height(),
                winheight = $(window).height();

            if (((wintop / (docheight - winheight)) > scrolltrigger) && !elem.fetching) {

                elem.fetching = true;
                $('div#lastPostsLoader').show();

                $.getJSON(url(elem.page), function(data) {
                    callback(data);
                    elem.fetching = false;
                    $('div#lastPostsLoader').hide();

                    if ($(data).length > 0) {
                        elem.page += 1;
                    }
                });
            }
        }

    });

    return true;
}