$(document).ready(function () {
    $("#jquery_jplayer_1").jPlayer({
        ready:function () {


            var audio_path = document.getElementById("Podcast").getAttribute("audio_path");

            $(this).jPlayer("setMedia", {
                mp3: audio_path
            });
        },
        swfPath:"/js",
        supplied:"mp3"
    });
});
