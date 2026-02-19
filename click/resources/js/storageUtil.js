


function storageAvailable() {

	if( ('localStorage' in window) && window['localStorage'] !== null) {
		console.log("현재 브라우저는 WebStorage를 지원합니다");
		return true;
	}
	else{
		console.log("현재 브라우저는 WebStorage를 지원하지 않습니다");
		return false;
	}
}

function setLocalStorage(key, value) {
	if(!storageAvailable())
		return ;
	
	window.localStorage[key] = value;
}

function getLocalStorage(key) {
	return window.localStorage[key];
}
