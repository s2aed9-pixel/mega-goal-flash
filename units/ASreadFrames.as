//11/11/11 - MOD: Made for Grivas. - Added extra button that plays the whole frame dialogue
//15/9/11 - MOD: Added playAudio property to determine whether the dialogue audio will be played (not when the text is hidden)
//29/6/11 - MOD: Added text showing/hiding PER frame, PER dialogue - NK
//TODO#Issue1: Clean up, make modular
//TODO#Issue2: DO NOT USE SEPARATE ARRAY  USE 1, AND THE OTHER DOUBLE VARIABLE!!!
//TODO#Issue3: Add prediction for no dialogue in a frame, to make visible/invisible..
//TODO#Issue4: Change the colour of the On/Off text.

tMovie = this;
//identifiers. They correspond to the movie clip names. If there is a change there, a change is necessary here

//the name of the movie clip that has all
var theStoryMCName = "story_mc";

//The name of the controller (adding "_mc") that is ALWAYS present and also the qualifier for the dynamically added. 
//NOTE: Though not literally, the name of this controller is implied to have "0" in its name. So, its not tc0_mc, though it could be
//Eg, for a story with 3 dialogues tc_mc, tc1_mc, tc2_mc will be on stage
var theControllerName = "tc";//the  starter controller and the pattern for all controls

//the qualifier of the movie clip that controls visibility of all dialogues. Add "_mc" for the movie clip name
var theVisibilityController = "textAll";

//the qualifier for the movie clip names of the dialogues. 
//NOTE: ALL the dialogue movie clips are wrapped inside a movie clip with the name of the qualifier + "s_mc" as the plural of the theTextsMCName.
//so, each dialogue is named "sd0_mc", "sd1_mc" etc, and all are inside the "sds_mc" movie clip.
var theTextsMCName = "sd";

//object that holds properties corresponding to the number of dialogues in Text. This should be initialised with number of objects exactly the number of dialogues. 
//dialogues to our reckoning is the group of items that with be visible/invisible and NOT according to the sounds.
var AllTheTexts = {Text0:{is_on:1}, Text1:{is_on:1}, Text2:{is_on:1}, Text3:{is_on:1}, Text4:{is_on:1}, Text5:{is_on:1}, Text6:{is_on:1}, Text7:{is_on:1}, Text8:{is_on:1}, Text9:{is_on:1}, Text10:{is_on:1}, Text11:{is_on:1}, Text12:{is_on:1}, Text13:{is_on:14}, Text15:{is_on:1}, Text16:{is_on:1}, Text17:{is_on:1}, Text18:{is_on:1}, Text19:{is_on:1}, Text20:{is_on:1}, Text21:{is_on:1}};

//initial state
tMovie[theControllerName + "_mc"]._visible = false;
//keep the position to reset
tMovie[theControllerName + "_mc"].originalY = tMovie[theControllerName + "_mc"]._y;//396.4;
//tMovie.[theVisibilityController + "_mc"]_mc._visible = false;

//property that keeps the state of the hide/show all button
tMovie[theVisibilityController + "_mc"].playAudio = 1;
//addDebug("tMovie[theVisibilityController + _mc].playAudio" + tMovie[theVisibilityController + "_mc"].playAudio);
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

//toggle the visibility of the [index] and sets the is_on property of Text.[index] of AllTexts object
function toggleText(index){
	for (i=0; i<index.length; i++){
		var theCurrentMC = tMovie[theStoryMCName][theTextsMCName + "s_mc"][theTextsMCName + index[i] + "_mc"];
		var theCurrentObject = "Text" + index[i];
		var theCurrentVisibility = Math.abs(AllTheTexts[theCurrentObject].is_on - 2) - 1;

		theCurrentMC._visible = theCurrentVisibility;
		AllTheTexts[theCurrentObject].is_on = theCurrentVisibility;
//		addDebug(theCurrentMC);
//		addDebug(theCurrentObject);
	}
}

function clickOnTextController(toHandle) {
	toggleText([toHandle]);
}

function textControlRelease(theItem){
	clickOnTextController(theItem.data_txt.text - 1);
	theItem.status_txt.text = translate(AllTheTexts["Text"+(theItem.data_txt.text - 1)].is_on);
}

//tMovie[theControllerName + "_mc"].onRelease = function () {textControlRelease(this);}
/*function () {
	clickOnTextController(this.data_txt.text - 1);
//	this.status_txt.textColor = rgb(255,0,0);
//	toggleTextColor(this);
	this.status_txt.text = translate(AllTheTexts["Text"+(this.data_txt.text - 1)].is_on);
}*/

/*
tMovie[theVisibilityController + "_mc"].onRelease = function () {
	this.gotoAndStop((Math.abs(this._currentframe - 2) + 1));
	
	var theCurrenMC = tMovie[theStoryMCName][theTextsMCName + "s_mc"]; //reference
	
	if (theCurrenMC._visible == true) {
		theCurrenMC._visible = false;
		tMovie[theControllerName + "_mc"]._visible = false;
		for (i=0; i<theMovie._dialFrames_array[zoomNo].length; i++) {
			tMovie[theControllerName + i + "_mc"]._visible = false;
		}
	} else {
		if (theMovie.zoomNo != -1){
			tMovie[theControllerName + "_mc"]._visible = true;
		}
		theCurrenMC._visible = true;
		for (i=0; i<theMovie._dialFrames_array[zoomNo].length; i++) {
			tMovie[theControllerName + i + "_mc"]._visible = true;
		}

	}
}*/

function toggleLineTextAudio(theState){
	if (theState == true) {
		enableAudio();
	} else {
		disableAudio();
	}
}

//the control of the show/hide all function
tMovie[theVisibilityController + "_mc"].onRelease = function () {
	//change frame
//	addDebug("clickli");
	this.gotoAndStop((Math.abs(this._currentframe - 2) + 1));
//	tMovie[theVisibilityController + "_mc"].playAudio = !tMovie[theVisibilityController + "_mc"].playAudio;
//	addDebug("tMovie[theVisibilityController + _mc].playAudio" + tMovie[theVisibilityController + "_mc"].playAudio);
	var theCurrenMC = tMovie[theStoryMCName][theTextsMCName + "s_mc"]; //reference to the wrapper text mc
//	theCurrenMC._visible = Math.abs(theCurrenMC._visible - 1);
//	toggleLineTextAudio(theCurrenMC._visible);

//	addDebug("theCurrenMC._visible:"+theCurrenMC._visible);
	//toggle the visibility of controls and text dialogues.
	if (this._currentframe == 2) {
//		theCurrenMC._visible = false;
		//this is now optional, since ALL text is hidden individually
//		tMovie[theControllerName + "_mc"]._visible = false;
		//reset the text on the zero controller, perhaps TODO#Issue3
//		tMovie[theControllerName + "_mc"].status_txt.text = translate(0);
		//now hide and reset the text/property of all texts
		for (i=0; i<theMovie._dialFrames_array.length; i++) {
//			tMovie[theControllerName + i + "_mc"]._visible = false;
			tMovie[theStoryMCName][theTextsMCName + "s_mc"][theTextsMCName + i + "_mc"]._visible = false;
			AllTheTexts["Text"+i].is_on = 0;
//			tMovie[theControllerName + i + "_mc"].status_txt.text = translate(0);
		}
	} else {
		//dont make the zero text controller visible in zoom out mode
//		if (theMovie.zoomNo != -1){
//			tMovie[theControllerName + "_mc"]._visible = true;
//		}
		//same as above, but make everything correspond to visible.
		//this is now optional, since ALL text is hidden individually		
//		theCurrenMC._visible = true;
		//reset the text on the zero controller, perhaps TODO#Issue3
//		tMovie[theControllerName + "_mc"].status_txt.text = translate(1);
		//now show and reset the text/property of all texts		
		for (i=0; i<theMovie._dialFrames_array.length; i++) {
//			tMovie[theControllerName + i + "_mc"]._visible = true;
			tMovie[theStoryMCName][theTextsMCName + "s_mc"][theTextsMCName + i + "_mc"]._visible = true;
			AllTheTexts["Text"+i].is_on = 1;
//			tMovie[theControllerName + i + "_mc"].status_txt.text = translate(1);
		}
	}
}

//Translates true/false to on/off so it can be displayed.
function translate(theOriginal):String {
	var theTranslated = ""
	if (theOriginal == 0) {
		theTranslated = "Off";
	} else {
		theTranslated = "On";
	}
	return theTranslated
}

//sets the status, data text of the controller.TODO
function setTheControllerText() {
	
}
//this is to change the text according to the clicks. 
//The complication is that the text must change according to
//the status. SO ITS NOT USED AT THE MO.Issue#4
function toggleTextColor(theItem){
//	addDebug(theItem);
//	addDebug(theItem.status_txt.textColor);
	
	if (theItem.status_txt.textColor == "#FFFFFF"){
		theItem.status_txt.textColor = "#DDDDDD";
	} else {
		theItem.status_txt.textColor = "#FFFFFF";
	};
}


//this gets call by ALL actions that will begin the viewing. 
function fillTheTextControls(myLevel){
/*	
	//first of all, remove the controls from the previous frame. If there is
	//only one dialogue, this won't execute
	for (i=1; i<theMovie._dialFrames_array[zoomNo].length; i++){
		tMovie[theControllerName + i +"_mc"].removeMovieClip();
		delete tMovie[theControllerName + i +"_mc"].onRelease;
	}
	//then, restore the initial control's location. TODO#Issue3
	tMovie[theControllerName + "_mc"]._y = tMovie[theControllerName + "_mc"].originalY;
	//move higher, so the last element has a fixed position
	tMovie[theControllerName + "_mc"]._y -= tMovie[theControllerName + "_mc"]._height * (theMovie._dialFrames_array[myLevel].length -1);
	//set the original controller's properties
	tMovie[theControllerName + "_mc"].data_txt.text = theMovie._dialFrames_array[myLevel][0] + 1;
	tMovie[theControllerName + "_mc"].status_txt.text = translate(AllTheTexts["Text"+myLevel].is_on);
	
	//now, start filling the just entered frame's controls, assign properties + functions
	for (i=1; i<theMovie._dialFrames_array[myLevel].length; i++) {
		var tc:MovieClip;
		//controller_text0 refers to the library item. Attach can be by reference to the item on stage also.
		tc = this.attachMovie("controller_text0", theControllerName + i +"_mc", 0, {_x:tMovie[theControllerName + "_mc"]._x, _y:tMovie[theControllerName + "_mc"]._y + tMovie[theControllerName + "_mc"]._height * i});
		tMovie[theControllerName + i + "_mc"].swapDepths(tMovie[theControllerName + "_mc"].getNextHighestDepth() + i);
		tMovie[theControllerName + i + "_mc"].data_txt.text = theMovie._dialFrames_array[myLevel][i] + 1;
		tMovie[theControllerName + i + "_mc"].status_txt.text = translate(AllTheTexts["Text"+myLevel].is_on);
		tMovie[theControllerName + i + "_mc"].onRelease = function () {textControlRelease(this);}
		//dont display the controls if the hide all is enabled. TODO#Use a property for this(?)
		if (tMovie[theStoryMCName][theTextsMCName + "s_mc"]._visible == false) {
			tMovie[theControllerName + i +"_mc"]._visible = false;
			tMovie[theControllerName + "_mc"]._visible = false;
		}
	}*/
}

//end of text control functions.

function disableAudio() {
	for (var i = 0; i < theMovie.dialogues; i++) {
		theMovie.story_mc["dial" + i + "_mc"].enabled = false;
	}
}
/*

*/
function enableAudio() {
	if (tMovie[theVisibilityController + "_mc"].playAudio == 1 ) {
		for (var i = 0; i < theMovie.dial_array[theMovie.zoomNo].length; i++) {
			theMovie.story_mc["dial" + theMovie.dial_array[theMovie.zoomNo][i] + "_mc"].enabled = true;
		}
	}
}
/*

*/
function listenSound_onSoundComplete(that) {
	that.gotoAndStop(1);
}

/*

*/
function restoreAllHeadPhones() {
	//trace("resetting icons");
	for (i=0; i<theMovie._dialFrames_array.length; i++){
		for (j=0; j<theMovie._dialFrames_array[i].length; j++){
			//trace("reset " + "theMovie.story_mc[f" + theMovie._dialFrames_array[i][j] + "_mc]");
			theMovie.story_mc["f" + theMovie._dialFrames_array[i][j] + "_mc"].gotoAndStop(1);
		}
	}
}

function story_mc_dialX_mc_onRelease(isFrameAudio) {
	var localObjectCopy = this;
//	theMovie._parent.InitPlayer(theMovie.soundsPath + "audio.mp3");
	theMovie._parent.pauseit();
	restoreAllHeadPhones();
	soundPlay = theMovie.soundsPath + String((this.myType == "f"?"f":"") + this.myNo + ".mp3");
//	addDebug(soundPlay);
//	addDebug(soundPlay);
	listenSound.loadSound(soundPlay,true);
	if (localObjectCopy.myType == "f"){
//		localObjectCopy.normalStateFrame = localObjectCopy._currentframe;
		localObjectCopy.gotoAndStop(2);
	}
	listenSound.onSoundComplete =function() {
		if (localObjectCopy.myType == "f"){
			listenSound_onSoundComplete(localObjectCopy)
		}
		//trace("mySoundID completed");
	};
}
/*

*/
function resetZoom_mc_onRelease() {
	theMovie.zoomNo = -1;
	theMovie.story_mc._xscale = initial_xscale;
	theMovie.story_mc._yscale = initial_yscale;
	theMovie.story_mc._x = initial_x;
	theMovie.story_mc._y = initial_y;
}
/*

*/
function zoomStraightIntoPlace() {
	/*
	final_x = theMovie.story_mc["zoom"+theMovie.zoomNo+"_mc"]._x + initial_x
	final_y = theMovie.story_mc["zoom"+theMovie.zoomNo+"_mc"]._y + initial_y
	*/
	
	var bounds_obj:Object = theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"].getBounds(theMovie);
	for (var i in bounds_obj) {
		//trace(i + " --> " + bounds_obj[i]);
	}
	if ((bounds_obj.xMin < theMovie.movieLeft) || (bounds_obj.yMin < theMovie.movieTop) || (bounds_obj.xMax > theMovie.movieRight) || (bounds_obj.yMax > theMovie.movieBottom)) {
		theMovie.story_mc._xscale = theMovie.story_mc._xscale - 10;
		theMovie.story_mc._yscale = theMovie.story_mc._yscale - 10;
		var myPoint:Object = {x:theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._x, y:theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._y};
		theMovie.story_mc.localToGlobal(myPoint);
		theMovie.story_mc._x = theMovie.story_mc._x + theMovie.movieCenterX - myPoint.x;
		theMovie.story_mc._y = theMovie.story_mc._y + theMovie.movieCenterY - myPoint.y;
		bounds_obj = theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"].getBounds(theMovie);
		if ((bounds_obj.xMin >= theMovie.movieLeft) && (bounds_obj.yMin >= theMovie.movieTop) && (bounds_obj.xMax <= theMovie.movieRight) && (bounds_obj.yMax <= theMovie.movieBottom)) {
			theMovie.enableAudio();
			delete this.onEnterFrame;
		}
	}
	else if (((bounds_obj.xMin - theMovie.movieLeft > 5) && (bounds_obj.yMin - theMovie.movieTop > 5)) || ((theMovie.movieRight - bounds_obj.xMax > 5) && (theMovie.movieBottom - bounds_obj.yMax > 5))) {
		theMovie.story_mc._xscale = theMovie.story_mc._xscale + 10;
		theMovie.story_mc._yscale = theMovie.story_mc._yscale + 10;
		var myPoint:Object = {x:theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._x, y:theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._y};
		theMovie.story_mc.localToGlobal(myPoint);
		theMovie.story_mc._x = theMovie.story_mc._x + theMovie.movieCenterX - myPoint.x;
		theMovie.story_mc._y = theMovie.story_mc._y + theMovie.movieCenterY - myPoint.y;
	}
	else {
		theMovie.enableAudio();
		delete this.onEnterFrame;
	}
}
/*

*/
function moveStraightToFrame() {
	var myPoint:Object = {x:theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._x, y:theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._y};
	theMovie.story_mc.localToGlobal(myPoint);
	theMovie.story_mc._x = theMovie.story_mc._x + theMovie.movieCenterX - myPoint.x;
	theMovie.story_mc._y = theMovie.story_mc._y + theMovie.movieCenterY - myPoint.y;
	delete this.onEnterFrame;
	//trace("ENTERFRAME");
	this.onEnterFrame = zoomStraightIntoPlace;
}
/*

*/
function zoomIntoPlace() {
	/*
	final_x = theMovie.story_mc["zoom"+theMovie.zoomNo+"_mc"]._x + initial_x
	final_y = theMovie.story_mc["zoom"+theMovie.zoomNo+"_mc"]._y + initial_y
	*/
	var bounds_obj:Object = theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"].getBounds(theMovie);
	for (var i in bounds_obj) {
		//trace(i + " --> " + bounds_obj[i]);
	}
	if ((bounds_obj.xMin < theMovie.movieLeft) || (bounds_obj.yMin < theMovie.movieTop) || (bounds_obj.xMax > theMovie.movieRight) || (bounds_obj.yMax > theMovie.movieBottom)) {
		theMovie.story_mc._xscale = theMovie.story_mc._xscale - 5;
		theMovie.story_mc._yscale = theMovie.story_mc._yscale - 5;
		var myPoint:Object = {x:theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._x, y:theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._y};
		theMovie.story_mc.localToGlobal(myPoint);
		theMovie.story_mc._x = theMovie.story_mc._x + theMovie.movieCenterX - myPoint.x;
		theMovie.story_mc._y = theMovie.story_mc._y + theMovie.movieCenterY - myPoint.y;
		bounds_obj = theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"].getBounds(theMovie);
		if ((bounds_obj.xMin >= theMovie.movieLeft) && (bounds_obj.yMin >= theMovie.movieTop) && (bounds_obj.xMax <= theMovie.movieRight) && (bounds_obj.yMax <= theMovie.movieBottom)) {
			theMovie.enableAudio();
			delete this.onEnterFrame;
		}
	}
	else if (((bounds_obj.xMin - theMovie.movieLeft > 5) && (bounds_obj.yMin - theMovie.movieTop > 5)) || ((theMovie.movieRight - bounds_obj.xMax > 5) && (theMovie.movieBottom - bounds_obj.yMax > 5))) {
		theMovie.story_mc._xscale = theMovie.story_mc._xscale + 5;
		theMovie.story_mc._yscale = theMovie.story_mc._yscale + 5;
		var myPoint:Object = {x:theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._x, y:theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._y};
		theMovie.story_mc.localToGlobal(myPoint);
		theMovie.story_mc._x = theMovie.story_mc._x + theMovie.movieCenterX - myPoint.x;
		theMovie.story_mc._y = theMovie.story_mc._y + theMovie.movieCenterY - myPoint.y;
	}
	else {
		theMovie.enableAudio();
		delete this.onEnterFrame;
	}
}
/*

*/
function moveToFrame() {
	var inPlaceX = false;
	var inPlaceY = false;
	/*
	final_x = theMovie.story_mc["zoom"+theMovie.zoomNo+"_mc"]._x + initial_x
	final_y = theMovie.story_mc["zoom"+theMovie.zoomNo+"_mc"]._y + initial_y
	*/
	//final_x = theMovie.movieCenterX - theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._x * (theMovie.story_mc._xscale / 100);
	//final_y = theMovie.movieCenterY - theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._y * (theMovie.story_mc._yscale / 100);
	//trace("final_x = " + final_x);
	//trace("final_y = " + final_y);
	var myPoint:Object = {x:theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._x, y:theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._y};
	theMovie.story_mc.localToGlobal(myPoint);
	if (myPoint.x != theMovie.movieCenterX) {
		var currDiff = theMovie.movieCenterX - myPoint.x;
		//trace("currDiffX = " + currDiff);
		theMovie.story_mc._x = theMovie.story_mc._x + (currDiff > 0 ? 10 : -10);
		myPoint.x = theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._x;
		myPoint.y = theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._y;
		theMovie.story_mc.localToGlobal(myPoint);
		var currDiffNew = theMovie.movieCenterX - myPoint.x;
		//trace("currDiffNewX = " + currDiffNew);
		if (((currDiff > 0) && (currDiffNew < 0)) || ((currDiff < 0) && (currDiffNew > 0))) {
			theMovie.story_mc._x = theMovie.story_mc._x + theMovie.movieCenterX - myPoint.x;
			inPlaceX = true;
		}
	}
	else {
		inPlaceX = true;
	}
	if (myPoint.y != theMovie.movieCenterY) {
		var currDiff = theMovie.movieCenterY - myPoint.y;
		//trace("currDiffY = " + currDiff);
		theMovie.story_mc._y = theMovie.story_mc._y + (currDiff > 0 ? 10 : -10);
		myPoint.x = theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._x;
		myPoint.y = theMovie.story_mc["zoom" + theMovie.zoomNo + "_mc"]._y;
		theMovie.story_mc.localToGlobal(myPoint);
		var currDiffNew = theMovie.movieCenterY - myPoint.y;
		//trace("currDiffNewY = " + currDiffNew);
		if (((currDiff > 0) && (currDiffNew < 0)) || ((currDiff < 0) && (currDiffNew > 0))) {
			theMovie.story_mc._y = theMovie.story_mc._y + theMovie.movieCenterY - myPoint.y;
			inPlaceY = true;
		}
	}
	else {
		inPlaceY = true;
	}
	//trace(inPlaceX + "@" + inPlaceY + "@" + zoomOK);
	if ((inPlaceX) && (inPlaceY)) {
		delete this.onEnterFrame;
		//trace("ENTERFRAME");
		this.onEnterFrame = zoomIntoPlace;
	}
}
/*

*/
function doubleClickOnRelease() {
//	toggleText(theMovie.dial_array[zoomNo]);
	fillTheTextControls(zoomNo);
	delete this.onEnterFrame;
	delete this.onRelease;
	theMovie.story_mc.onEnterFrame = moveStraightToFrame;
	theMovie.next_mc.onRelease = next_mc_onRelease;
	theMovie.next_mc.onRollOver = buttons_mc_onRollOver;
	theMovie.next_mc.onRollOut = buttons_mc_onRollOut;
	theMovie.next_mc.enabled = true;
	theMovie.next_mc.gotoAndStop(1);
	theMovie.previous_mc.onRelease = previous_mc_onRelease;
	theMovie.previous_mc.onRollOver = buttons_mc_onRollOver;
	theMovie.previous_mc.onRollOut = buttons_mc_onRollOut;
	theMovie.previous_mc.enabled = true;
	theMovie.previous_mc.gotoAndStop(1);
	if (theMovie.zoomNo == 0) {
		theMovie.previous_mc.enabled = false;
		theMovie.previous_mc.gotoAndStop(2);
		theMovie.next_mc.enabled = true;
		theMovie.next_mc.gotoAndStop(1);
	}
	if (theMovie.zoomNo == theMovie.totalZoomNo - 1) {
		theMovie.previous_mc.gotoAndStop(1);
		theMovie.previous_mc.enabled = true;
		theMovie.next_mc.gotoAndStop(2);
		theMovie.next_mc.enabled = false;
	}
}
/*

*/
function controlClicks() {
	this.myCounter++;
	if (this.myCounter == 6) {
		theMovie.story_mc.onEnterFrame = moveToFrame;
		theMovie.next_mc.onRelease = next_mc_onRelease;
		theMovie.next_mc.onRollOver = buttons_mc_onRollOver;
		theMovie.next_mc.onRollOut = buttons_mc_onRollOut;
		theMovie.next_mc.enabled = true;
		theMovie.next_mc.gotoAndStop(1);
		theMovie.previous_mc.onRelease = previous_mc_onRelease;
		theMovie.previous_mc.onRollOver = buttons_mc_onRollOver;
		theMovie.previous_mc.onRollOut = buttons_mc_onRollOut;
		theMovie.previous_mc.enabled = true;
		theMovie.previous_mc.gotoAndStop(1);
		if (theMovie.zoomNo == 0) {
			theMovie.previous_mc.enabled = false;
			theMovie.previous_mc.gotoAndStop(2);
			theMovie.next_mc.enabled = true;
			theMovie.next_mc.gotoAndStop(1);
		}
		if (theMovie.zoomNo == theMovie.totalZoomNo - 1) {
			theMovie.previous_mc.gotoAndStop(1);
			theMovie.previous_mc.enabled = true;
			theMovie.next_mc.gotoAndStop(2);
			theMovie.next_mc.enabled = false;
			if (theMovie.totalZoomNo == 1)
			{
				theMovie.previous_mc.enabled = false;
				theMovie.previous_mc.gotoAndStop(2);
			}
		}
	}
}
/*

*/
function buttons_mc_onRollOver() {
	//trace("rollOver")
	if (this._currentframe == 1) {
		this.gotoAndPlay(3);
	}
	if (this._currentframe == 2) {
		this.gotoAndPlay(30);
	}
}
function buttons_mc_onRollOut() {
	if ((this._currentframe < 30) && (this._currentframe > 2)) {
		this.gotoAndPlay(1);
	}
	if (this._currentframe >= 30) {
		this.gotoAndPlay(2);
	}
}
//--------------------------
function previous_mc_onRelease() {
	if (theMovie.zoomNo > 0) {
		theMovie.disableAudio();
		theMovie.zoomNo--;
		this.myCounter = 0;
		delete this.onRelease;
		this.onRelease = doubleClickOnRelease;
		this.onEnterFrame = controlClicks;
	}
	fillTheTextControls(zoomNo);
}
/*

*/
function next_mc_onRelease() {
	if (theMovie.zoomNo < theMovie.totalZoomNo - 1) {
		theMovie.disableAudio();
		theMovie.zoomNo++;
		this.myCounter = 0;
		delete this.onRelease;
		this.onRelease = doubleClickOnRelease;
		this.onEnterFrame = controlClicks;
	}
	fillTheTextControls(zoomNo);
}
/*

*/
function picX_mc_onRelease() {
	for (var i = 0; i < theMovie.totalZoomNo; i++) {
		theMovie["pic" + i + "_mc"]._visible = false;
	}
	theMovie.next_mc._visible = true;
	theMovie.previous_mc._visible = true;
	theMovie.buttonBorder_mc._visible = true;
	theMovie.next_mc.gotoAndStop(1);
	theMovie.previous_mc.gotoAndStop(1);
	theMovie.next_mc.enabled = true;
	theMovie.previous_mc.enabled = true;
	theMovie.zoomNo = this.myNo;
	fillTheTextControls(zoomNo);
/*	if (tMovie.story_mc.sds_mc._visible == false){
		tMovie[theControllerName + "_mc"]._visible = false;
	} else {
		tMovie[theControllerName + "_mc"]._visible = true;
	}*/
//	tMovie.[theVisibilityController + "_mc"]_mc._visible = true;
	if (theMovie.zoomNo == 0) {
		theMovie.previous_mc.enabled = false;
		theMovie.previous_mc.gotoAndStop(2);
		theMovie.next_mc.enabled = true;
		theMovie.next_mc.gotoAndStop(1);
	}
	if (theMovie.zoomNo == theMovie.totalZoomNo - 1) {
		theMovie.previous_mc.gotoAndStop(1);
		theMovie.previous_mc.enabled = true;
		theMovie.next_mc.gotoAndStop(2);
		theMovie.next_mc.enabled = false;
		if (theMovie.totalZoomNo == 1)
		{
			theMovie.previous_mc.enabled = false;
			theMovie.previous_mc.gotoAndStop(2);
		}
	}
	if (theMovie.totalZoomNo == 1)
	{
		theMovie.previous_mc.enabled = false;
		theMovie.previous_mc.gotoAndStop(2);
	}
	theMovie.story_mc.onEnterFrame = moveToFrame;
}
