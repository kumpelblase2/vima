function sendEvent(videoId, eventName) {
    $.ajax({
        url: `/events/${videoId}.json`,
        method: 'POST',
        data: {
            event: eventName
        }
    });
}
