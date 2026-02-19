function sleep(milliSeconds) {
        var startTime = new Date().getTime(); // get the current time
        while (new Date().getTime() < startTime + milliSeconds); // hog cpu
}


addEventListener('message', function (event) {
	
	if(event.data == "")
		return ;
	
    var message_data = event.data.buffer;
    postMessage(message_data);

});
