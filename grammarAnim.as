theMovie = this;
stop();

function restorePlay() {
	theMovie.play_f_mc.gotoAndStop(1);
}

function beginPlay() {
	theMovie.play_f_mc.gotoAndStop(2);
}

function runthis(){
	if (theMovie._totalframes == 2) {
		theMovie.prevgr_mc.gotoAndStop(2);
		theMovie.nextgr_mc.gotoAndStop(2);
		theMovie.prevgr_mc.enabled = false;
		theMovie.nextgr_mc.enabled = false;
	} else {
		if (theMovie._currentframe == 2) {
			theMovie.prevgr_mc.gotoAndStop(2);
			theMovie.nextgr_mc.gotoAndStop(1);
			theMovie.nextgr_mc.enabled = true;
		    theMovie.prevgr_mc.enabled = false;
		} else if (theMovie._currentframe == theMovie._totalframes) {
			theMovie.prevgr_mc.gotoAndStop(1);
			theMovie.nextgr_mc.gotoAndStop(2);
			theMovie.nextgr_mc.enabled = false;
		    theMovie.prevgr_mc.enabled = true;
		} else {
			theMovie.prevgr_mc.gotoAndStop(1);
			theMovie.nextgr_mc.gotoAndStop(1);
			theMovie.nextgr_mc.enabled = true;
			theMovie.prevgr_mc.enabled = true;
		}
	}
	beginPlay();
}

theMovie.prevgr_mc.onRelease = function () {
	theMovie.gotoAndStop(theMovie._currentframe -1);
	runthis();
}


theMovie.nextgr_mc.onRelease = function () {
	theMovie.gotoAndStop(theMovie._currentframe + 1);
	runthis();
}

theMovie.play_f_mc.onRelease = function () {
	beginPlay();
	var current = theMovie._currentFrame;
	gotoAndStop(current - 1);
	gotoAndStop(current);
}

runthis();