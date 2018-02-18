function get_selected_videoids() {
    const selectedVideos = $('.video-card.is-selected-video');
    const ids = [];
    selectedVideos.each(function () {
        ids.push($(this).data('video-id'));
    });
    return ids;
}
