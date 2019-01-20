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

function updatePlaylistOrder() {
    const videoIds = Array.from(document.querySelectorAll('.video-card')).map(elem => elem.getAttribute('data-video-id'));
    const pathElements = window.location.pathname.split('/');
    const playlistId = pathElements[pathElements.length - 1];
    $.ajax({
        url: `/playlists/${playlistId}/videos`,
        method: 'PATCH',
        data: {
            videos: videoIds
        }
    });
}

let dragVideo = null;

function playlistDragOver(event) {
    event.preventDefault();
    event.dataTransfer.dropEffect = 'move';
    return false;
}

function playlistDragStart(event) {
    dragVideo = this;
    event.dataTransfer.effectAllowed = 'move';
    event.dataTransfer.setData('text/html', this.innerHTML);
}

function playlistDragEnter(event) {
    const parent = this.closest('.video-column');
    if (parent !== dragVideo) {
        parent.classList.add('drag-over');
    }
}

function playlistDragLeave(event) {
    const parent = this.closest('.video-column');
    if (parent !== dragVideo) {
        parent.classList.remove('drag-over');
    }
}

function playlistDragDrop(event) {
    event.stopPropagation();

    if (this === dragVideo) {
        dragVideo = null;
        return false;
    }

    if (dragVideo != null) {
        dragVideo.parentNode.removeChild(dragVideo);
        this.parentNode.insertBefore(dragVideo, this);
        updatePlaylistOrder();
        dragVideo = null;
    }

    return false;
}

function playlistDragEnd(e) {

}


function enableDragAndDrop(elements) {
    elements.forEach(element => {
        element.addEventListener('dragstart', playlistDragStart);
        element.addEventListener('dragover', playlistDragOver);
        element.addEventListener('dragenter', playlistDragEnter);
        element.addEventListener('dragleave', playlistDragLeave);
        element.addEventListener('drop', playlistDragDrop);
        element.addEventListener('dragend', playlistDragEnd);
    });
}
