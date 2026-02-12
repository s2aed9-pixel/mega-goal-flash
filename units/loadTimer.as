//---------------------------
//showTimer_mc
var theMovie= this
var mclListenerTimer:Object = new Object(theMovie);
var mcLoaderTimer:MovieClipLoader = new MovieClipLoader(theMovie);
//---------------------------
theMovie.timerGame_mc.onRelease = function() {
	if (theMovie.showTimer_mc._visible == false) {
		theMovie.showTimer_mc._visible = true;
		this.gotoAndStop(3);
	} else {
		this.gotoAndStop(1);
		theMovie.showTimer_mc.myTimer_mc.resetCounting();
		theMovie.showTimer_mc._visible = false;
	}
	//***********************************
};
//-------------------------------------
function mclListenerTimer_onLoadInit(mc:MovieClip) {
	theMovie.timer_mc.enabled = true;
	theMovie.showTimer_mc._visible = false;
	mc._visible = false;
	theMovie.showTimer_mc.swapDepths(theMovie.getNextHighestDepth())
	mc.myTimer_mc.bgTimer_mc.onPress = function() {
		theMovie.showTimer_mc.swapDepths(theMovie.getNextHighestDepth())
		this._parent.startDrag(false);
	};
	mc.myTimer_mc.bgTimer_mc.onRelease = mc.myTimer_mc.bgTimer_mc.onReleaseOutside=function () {
		this._parent.stopDrag();
	};
}
//-------------------------------------
mclListenerTimer.onLoadComplete = mclListenerTimer_onLoadComplete;
mclListenerTimer.onLoadInit = mclListenerTimer_onLoadInit;
mcLoaderTimer.addListener(mclListenerTimer);
//-------------------------------------------------
function loadTimer(){
	timerPath = "units/timer/timer.swf";
	mcLoaderTimer.loadClip(timerPath,theMovie.showTimer_mc);
}
loadTimer()