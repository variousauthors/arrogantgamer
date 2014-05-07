
$(document).ready(function () {

    // when the overlay is clicked, send them to the article
    $("[data-article-preview]").on("click", function (e) {
        e.preventDefault()

        var href = $(this).data("href");
        window.location = href;
    });
});
