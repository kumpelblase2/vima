function get_selected_videoids() {
    const selectedVideos = $('.video-card.is-selected-video');
    const ids = [];
    selectedVideos.each(function () {
        ids.push($(this).data('video-id'));
    });
    return ids;
}

$(document).ready(() => {
    const collection = document.querySelector("#video-collection");
    const scroll = new InfiniteScroll(collection, {
        path: '/videos.js?path={{#}}',
        append: '.videos',
        prefill: true,
        responseType: 'text'
    });

    scroll.on('load', (doc, path) => {
        eval(doc);
        $('.lazy').Lazy();
    });
});
