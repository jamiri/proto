$(document).ready(function () {
    // enable comment dialogs for microblogs
    $('.microblog_comment').dialog({
        autoOpen: false,
        width: 600
    });

    $('.post .comments a').click(function (ev) {
        ev.preventDefault();
        $($(this).attr('href')).dialog('open');
    });

    // init auto scrolling for microblogs
    initInfiniScroll($('.MicroBlog').get(0), function(page) {
        return "/lesson/" + $('.script:first').attr('lesson_id') + "/microblog/" + page;
    }, function(data) {
        $(data).each(function() {

            var blogElem = $('.post.proto').clone().removeClass('proto').show();
            blogElem.find('h2')
                        .html(this.blog_post.title)
                        .end()
                    .find('.date')
                        .html('posted on ' + new Date(this.blog_post.posted_on).strftime('%B %d, %Y'))
                        .end()
                    .find('.comments a')
                        .attr('href',"#dialog" + this.blog_post.id)
                        .html(this.blog_post.comments.length + " comments")
                        .click(function (ev) {
                            ev.preventDefault();
                            $($(this).attr('href')).dialog('open');
                        })
                        .end()
                    .find('p')
                        .html(this.blog_post.content);

            var comWrprElem = $('.microblog_comment.proto').clone().removeClass('proto').hide();
            comWrprElem.attr('id', "dialog" + this.blog_post.id)
                       .attr('title', "Comments on " + this.blog_post.title);

            comWrprElem.appendTo(blogElem);

            if (this.blog_post.comments.length > 0) {
                $(this.blog_post.comments).each (function() {
                    var commentElem = $('.comment_post.proto').clone().removeClass('proto');
                    commentElem.find('.id')
                                   .html(this.user.name)
                                   .end()
                               .find('p')
                                   .html(this.comment);

                    commentElem.appendTo(comWrprElem);
                });

                comWrprElem.dialog({
                    autoOpen: false,
                    width: 600
                });
            }

            blogElem.appendTo($('.MicroBlog'))
        });
    });
});