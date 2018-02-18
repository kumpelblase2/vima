function create_playlist(name, videoIds) {
    $.ajax({
        url: '/playlists',
        method: 'POST',
        data: {
            name: name
        },
        success: (id) => {
            add_videos_to_playlist(id, videoIds);
        }
    })
}

function add_videos_to_playlist(id, videosIds) {
    $.ajax({
        url: `/playlists/${id}/videos`,
        method: 'POST',
        data: {
            videos: videosIds
        }
    });
}
