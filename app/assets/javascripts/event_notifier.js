function sendEvent(videoId, eventName, callback) {
    $.ajax({
        url: `/events/${videoId}.json`,
        method: 'POST',
        data: {
            event: eventName
        },
        success: () => {
            if(callback) {
                callback();
            }
        }
    });
}
