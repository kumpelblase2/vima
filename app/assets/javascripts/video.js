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
        path: 'nav.pagination a[rel=next]',
        append: '.video-column',
        hideNav: '.pagination'
    });

    scroll.on('append', (response, path, items) => {
        document.querySelectorAll('.metadata-toggle').forEach(toggle => {
            const name = toggle.dataset.metadataName;
            items.forEach(videoCard => {
                videoCard.querySelectorAll('.metadata-display-' + name).forEach(display => {
                    $(display).toggleClass('is-hidden', !toggle.checked);
                });
            });
        });
        $('.lazy').Lazy();
    });
});
