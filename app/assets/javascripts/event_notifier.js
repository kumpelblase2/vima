function sendEvent(videoId, eventName, callbackOrData, callback) {
    if(typeof callbackOrData === "function") {
        callback = callbackOrData;
        callbackOrData = {};
    }

    const data = { event: eventName };
    if(callbackOrData) {
        data.data = callbackOrData;
    }
    $.ajax({
        url: `/events/${videoId}.json`,
        method: 'POST',
        data: data,
        success: () => {
            if(callback) {
                callback();
            }
        }
    });
}
