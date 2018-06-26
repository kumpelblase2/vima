function create_playlist(name, videoIds) {
    $.ajax({
        url: '/playlists',
        method: 'POST',
        dataType: 'json',
        data: {
            playlist: {
                name: name
            }
        },
        success: (playlist) => {
            add_videos_to_playlist(playlist.id, videoIds);
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
