//define the level at which the movieclips are
theMovie.theTextPointer = theMovie.theTextPointer == undefined?theMovie : theMovie.theTextPointer;

//define variables
tMObj.highlightObj = theTextPointer.highlighter_mc;
tMObj.karObjMCQualifier = "k";
//ArrayIndexIsContainerMovieClip	: Ο αριθμος του πλαισιου :)
//ArrayIndexIsVerse					: Η γραμμη του τραγουδιου
tMObj.trapped = false;			//boolean to make sure the highlight will remain visible when a container changes
tMObj.extraHeightIndex = 0;		//keeps the index of the extraHeight array changes
tMObj.extraSpaceIndex = 0;		//keeps the index of the extaSpace array changes
tMObj.currentDefaultDistance = 0;	//the default height of the highlight for the current container
tMObj.stepsScrollIndex = 0;		//keeps track of the array with the simulated clicks that scroll

function drawLine() {
	this.createEmptyMovieClip("line_mc", 1);
	with(line_mc){
		lineStyle(5, 0x000000, 50, true, "normal", "square", "miter", 1);
		moveTo(0, 0);
		lineTo(150, 0);
		_x=100;
		_y=150;
	}
}
//debug func
function addDebug(TheText){
	if (this._parent.status_txt.text == undefined) {
		this._parent.createTextField("status_txt", 999, 0, 0, 100, 100);
		this._parent.status_txt.autoSize = "left";
		this._parent.status_txt.multiline = true;
	} else {
	//this._parent.status_txt.text = "DEBUG TEXT\n"
		this._parent.status_txt.text += TheText + "\n";
	}
}

function debug(arglist, verseIndex){
	theMovie.theTextPointer.myStyleText1 = "Current Sound:"+SoundPlaybackPosition;
//	theMovie.theTextPointer.myStyleText2 = "Next Line Change At:"+arglist[tMObj.ArrayIndexIsContainerMovieClip][tMObj.ArrayIndexIsVerse+1][0];
	if ((tMObj.ArrayIndexIsVerse == 0) && (SoundPlaybackPosition <= arglist[tMObj.ArrayIndexIsContainerMovieClip][tMObj.ArrayIndexIsVerse][0])){
		mpla = arglist[tMObj.ArrayIndexIsContainerMovieClip][tMObj.ArrayIndexIsVerse][0];
	} else {
		mpla = arglist[tMObj.ArrayIndexIsContainerMovieClip][tMObj.ArrayIndexIsVerse+1][0];
	}
	theMovie.theTextPointer.myStyleText2 = "Next Line Change At:"+mpla;
	theMovie.theTextPointer.myStyleText3 = "Movie Clip:"+tMObj.ArrayIndexIsContainerMovieClip + "			Line(index of array):" + verseIndex ;
	theMovie.theTextPointer.myStyleText4 = "Last position change:"+arglist[tMObj.ArrayIndexIsContainerMovieClip][tMObj.ArrayIndexIsVerse][0];
	theMovie.theTextPointer.myStyleText5 = "Next highlight hiding at:" + arglist[tMObj.ArrayIndexIsContainerMovieClip][tMObj.ArrayIndexIsVerse][1];
}


//positioning offset on the vertical axis
function checkForVerticalOffset():Number{
	var theReturnOffset = 0;
	if (SoundPlaybackPosition == tMObj.extraSpaceArray[tMObj.extraSpaceIndex][0]){
		theReturnOffset = tMObj.extraSpaceArray[tMObj.extraSpaceIndex][1];
		tMObj.extraSpaceIndex++;
	}
	return theReturnOffset;
}

//make the frame bigger in height if necessary
//this is now obsolete, as it is just underline with no height
function setHighlightExtraDistance(){
	var theReturnedVerticalOffset = tMObj.currentDefaultDistance;
	if (SoundPlaybackPosition == tMObj.extraHeightArray[tMObj.extraHeightIndex][0]){
		theReturnedVerticalOffset = tMObj.currentDefaultDistance + tMObj.extraHeightArray[tMObj.extraHeightIndex][1];
		tMObj.extraHeightIndex++;
	}
	return theReturnedVerticalOffset;	
}

//when you reach the element of the array, scroll the bar to the desired position.
function simulateClickToScrollbar(theSteps) {
	theMovie.theTextPointer._parent.InitScrollBar();
	for(h=0; h<theSteps; h++){
		theMovie.theTextPointer._parent.sVDTree_mc_onRelease();
	}
	tMObj.stepsScrollIndex++;
}

//set the initial (for every container movieclip) position
//determine the default height for the current container
function setHighlightStartingPoint (theHighlighterMovieClipReference, theContainerMovieClip, theNumberOfLines) {
	theHighlighterMovieClipReference._width = theContainerMovieClip._width;
//	theHighlighterMovieClipReference._height = theContainerMovieClip._height / theNumberOfLines;
	theHighlighterMovieClipReference._distance = theContainerMovieClip._height / theNumberOfLines;
	tMObj.currentDefaultDistance = theHighlighterMovieClipReference._distance;
	theHighlighterMovieClipReference._x = theContainerMovieClip._x + theContainerMovieClip._width /2;
	theHighlighterMovieClipReference._y = theContainerMovieClip._y  + theHighlighterMovieClipReference._distance;
	trace("theContainerMovieClip :"+theContainerMovieClip);
	trace("new X: " + theHighlighterMovieClipReference._x);
	trace("new Y: " + theHighlighterMovieClipReference._y);	
	trace("distance " + theHighlighterMovieClipReference._distance);
	theHighlighterMovieClipReference._visible = false;
}


function setHighlightCurrentPoint(theHighlighterMovieClipReference, thePreviousPoint){
	//using the extraSpaceArray moves the highlight more down or up if you use negative numbers
	theHighlighterMovieClipReference._y +=  theHighlighterMovieClipReference._distance + checkForVerticalOffset();
}

function addkaraoke(arglist){
	SoundPlaybackPosition = Math.floor(this._parent.sound_obj.position/100);
	debug(arglist, tMObj.ArrayIndexIsVerse);
	//keep the last line of a movie clip visible till the next change
	if (tMObj.trapped) {
		if (SoundPlaybackPosition >= arglist[tMObj.ArrayIndexIsContainerMovieClip][tMObj.ArrayIndexIsVerse][0]){
			tMObj.trapped = false;
			setHighlightStartingPoint(theMovie.tMObj.highlightObj, theTextPointer[theMovie.tMObj.karObjMCQualifier + tMObj.ArrayIndexIsContainerMovieClip + "_mc"], arglist[tMObj.ArrayIndexIsContainerMovieClip].length);
		}
	}
	
	/*********highlight positioning control****************/
	//display the highlight
	if (SoundPlaybackPosition >= arglist[tMObj.ArrayIndexIsContainerMovieClip][tMObj.ArrayIndexIsVerse + 1][0]){
		//adjust the height if necessary
//		theMovie.tMObj.highlightObj._distance = setHighlightExtraDistance(); //see comment on function
		setHighlightCurrentPoint(theMovie.tMObj.highlightObj, arglist[tMObj.ArrayIndexIsContainerMovieClip][tMObj.ArrayIndexIsVerse][1]);
		tMObj.ArrayIndexIsVerse++;
	} else if (SoundPlaybackPosition == arglist[tMObj.ArrayIndexIsContainerMovieClip][tMObj.ArrayIndexIsVerse][0]) {
			theMovie.tMObj.highlightObj._visible = true;
	} 
	//if the next element is undefined, then trap the highlight and move on to the next movie clip
//	trace("the length of array " + arglist[tMObj.ArrayIndexIsContainerMovieClip] + " is " + arglist[tMObj.ArrayIndexIsContainerMovieClip].length);
	if (arglist[tMObj.ArrayIndexIsContainerMovieClip].length > 1) {
		if (arglist[tMObj.ArrayIndexIsContainerMovieClip][tMObj.ArrayIndexIsVerse + 1][0] == undefined) {
//			trace("as normal, it should skip stuff, because this is the last element of a non-singular array");
			tMObj.ArrayIndexIsContainerMovieClip++;
			tMObj.ArrayIndexIsVerse = 0;
			tMObj.trapped = true;
		}
	} else {
		trace("the length is one, do something here!!");
	}
	
	//second argument optional, but if it exist it will hide the highlight
	if (arglist[tMObj.ArrayIndexIsContainerMovieClip][tMObj.ArrayIndexIsVerse][1] != undefined){
		if (SoundPlaybackPosition >= arglist[tMObj.ArrayIndexIsContainerMovieClip][tMObj.ArrayIndexIsVerse][1]) {
			theMovie.tMObj.highlightObj._visible = false;
		}
	} else {
		theMovie.tMObj.highlightObj._visible  = true;
	}
	if (tMObj.ArrayIndexIsContainerMovieClip > tMObj.karaokeArray.length){
		delete theMovie.onEnterFrame;
		theMovie.tMObj.highlightObj._visible = false;
	}
	
	//scroll down bar 
	if ((SoundPlaybackPosition >= tMObj.stepsArray[tMObj.stepsScrollIndex][0]) && (SoundPlaybackPosition < tMObj.stepsArray[tMObj.stepsScrollIndex][0] + 2)) {
		simulateClickToScrollbar(tMObj.stepsArray[tMObj.stepsScrollIndex][1]);
	}
}


function songEnterFrame(){
	addkaraoke(tMObj.karaokeArray)
}

//this is LAAAAMEEEE!!!
function fixFirstElementBug(){
	tMObj.karaokeArray[0][0][1] = tMObj.karaokeArray[0][0][1] == undefined?tMObj.karaokeArray[0][1][0] : tMObj.karaokeArray[0][0][1];
}

function resetSong(resetState) {
	tMObj.ArrayIndexIsContainerMovieClip = 0;
	tMObj.ArrayIndexIsVerse = 0;
	tMObj.extraHeightIndex = 0;
	tMObj.extraSpaceIndex = 0;
	tMObj.stepsScrollIndex = 0;	
	setHighlightStartingPoint(theMovie.tMObj.highlightObj, theTextPointer[theMovie.tMObj.karObjMCQualifier + "0" + "_mc"], tMObj.karaokeArray[tMObj.ArrayIndexIsContainerMovieClip].length)
	if (resetState != "init") {
		delete theMovie.onEnterFrame;
	}
}

fixFirstElementBug();
resetSong("init");
trace("new movie width " + theMovie._width);
trace("new movie height " + theMovie._height);