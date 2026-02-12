/**************************************
VERSION 2
**************************************/
//04-01-2012 [McGraw] Updated onComplete to be the same as "stop"
//17-03-2011 [Grv] Added but disable different note for TAPESCRIPT : _root.hideXCanvas/_root.showXCanvas("Tapescript")
//MOD: 24/2/2011 (nk-GRV]return sp0 to first frame not frame 1
// Disable Audio Player Bar in Songs [!ExercisePath.songEnterFrame] + Reset of songs execues here(AudioObjectComplete)
// Sets the states of teh stop/pause buttons similar to Video Player.

theMovie = this;
var sound_obj:Sound = new Sound(theMovie);
//
//Array for name of Movies included
theMovie.nameOfControls = ["play_btn", "stop_btn", "pause_btn", "dragbar", "bar_sample_mc", "bar_mc"];
//Frame to go for second state
State2 = 2;
//Variables****************************
//Name of Controls
get_play_btn = nameOfControls[0];
get_stop_btn = nameOfControls[1];
get_pause_btn = nameOfControls[2];
//Control for playing/paused
audioIsPlaying = false;
audioIsPaused = false;
//************************************
// Sound Object
function SoundObject(pathfile) {
	//sound_obj = new Sound();
	sound_obj.loadSound(pathfile, true);
	sound_obj.stop();
}
function AudioObjectComplete() {
	
	//debug1.text = "STOPPED";
	position = 0;
	theMovie.audioIsPlaying = false;
	//
	thePlayerMc[get_play_btn].gotoAndStop(1);
	thePlayerMc[get_play_btn].enabled = true;
	thePlayerMc[get_pause_btn].gotoAndStop(3);
	thePlayerMc[get_pause_btn].enabled = false;
	thePlayerMc[get_stop_btn].gotoAndStop(3);
	thePlayerMc[get_stop_btn].enabled = false;
	//
	theMovie[dragbar_var_mc].enabled = false;
	theMovie[bar_var_mc].enabled = false;
	//
	theMovie.mybarSample._width = 0;
	theMovie[dragbar_var_mc]._x = 0;
	//
	delete thePlayerMc.onEnterFrame;
	// ********** SONG *******************
	ExercisePath.resetSong();
}
// play button function
function playit() {
	stopAllSounds();
	theMovie.showUnit_mc.restoreAllHeadPhones();
	theMovie.sound_obj.start(position);
	//theMovie.sound_obj.start();
	//
	thePlayerMc[get_play_btn].gotoAndStop(State2);
	thePlayerMc[get_play_btn].enabled = false;
	//this.gotoAndStop(State2);
	//this.enabled = false;
	thePlayerMc[get_pause_btn].gotoAndStop(1);
	thePlayerMc[get_pause_btn].enabled = true;
	thePlayerMc[get_stop_btn].gotoAndStop(1);
	thePlayerMc[get_stop_btn].enabled = true;
	//
	
	// SONGS DISABLE ******************************
	if(!ExercisePath.songEnterFrame){
			theMovie[dragbar_var_mc].enabled = true;
			theMovie[bar_var_mc].enabled = true;
	} else {
			theMovie[dragbar_var_mc].enabled = false;
			theMovie[bar_var_mc].enabled = false;
	}
	// Reset HeadPhones Frames 
	for (f=0; f<50; f++){
		ExercisePath["sp"+f+"_mc"].pressed=0;
		ExercisePath["sp"+f+"_mc"].gotoAndStop(1);
	}
	/*mod 24-2-11*/
/*	if (ExercisePath["sp0_mc"].pressed == 1) {
		ExercisePath["sp0_mc"].origFrame = ExercisePath["sp0_mc"].origFrame == undefined?0 : ExercisePath["sp0_mc"].origFrame;
		ExercisePath["sp0_mc"].gotoAndStop(ExercisePath["sp0_mc"].origFrame);
		ExercisePath["sp0_mc"].pressed=0;
	}
	/*mod 24-2-11*/
	//
	theMovie.audioIsPlaying = true;
	//
	thePlayerMc.onEnterFrame = checkEnterFrame;
	theMovie.mybarSample._width = theMovie.original_width;
	// ********** SONG *******************
	//ExercisePath.resetSong();
}
//pause button function
function pauseit() {
	ExercisePath.debug1.text = "audioIsPlaying: "+audioIsPlaying
	ExercisePath.debug2.text = "Frame Play: "+thePlayerMc[get_play_btn]._currentframe
	ExercisePath.debug3.text = "Frame Pause: "+thePlayerMc[get_pause_btn]._currentframe
	ExercisePath.debug4.text = ""
	
	position = theMovie.sound_obj.position/1000;
	if (audioIsPlaying && (thePlayerMc[get_play_btn]._currentframe == 2 || (thePlayerMc[get_play_btn]._currentframe >=31 && thePlayerMc[get_play_btn]._currentframe <=57))) {
		
		ExercisePath.debug1.text = "AudioPlaying 1 true: "+audioIsPlaying
		
		theMovie.sound_obj.stop();
		theMovie.audioIsPlaying = false;
		theMovie.audioIsPaused = true;
		//
		theMovie[dragbar_var_mc].enabled = false;
		theMovie[bar_var_mc].enabled = false;
		//
		thePlayerMc[get_pause_btn].gotoAndStop(State2);
		thePlayerMc[get_pause_btn].enabled = false;
		thePlayerMc[get_play_btn].gotoAndStop(1);
		thePlayerMc[get_play_btn].enabled = true;
	} /*else if (thePlayerMc[get_pause_btn]._currentframe ==2 || (thePlayerMc[get_pause_btn]._currentframe >=31 && thePlayerMc[get_pause_btn]._currentframe <=57)) {
		
		ExercisePath.debug1.text = "AudioPlaying 2 false: "+audioIsPlaying
		
		theMovie.sound_obj.start(position);
		theMovie.audioIsPlaying = true;
		theMovie.audioIsPaused = false;
		//
		theMovie[dragbar_var_mc].enabled = true;
		theMovie[bar_var_mc].enabled = true;
		//
		thePlayerMc[get_pause_btn].gotoAndStop(1);
		//thePlayerMc[get_play_btn].gotoAndStop(State2);
		//thePlayerMc[get_play_btn].enabled = false;
	}*/
	// ********** SONG *******************
	theMovie.mySongPos = sound_obj.position;
}
//stop button function 
function stopit() {
	theMovie.sound_obj.stop();
	position = 0;
	theMovie.audioIsPlaying = false;
	//
	thePlayerMc[get_stop_btn].gotoAndStop(3);
	thePlayerMc[get_stop_btn].enabled = false;
	thePlayerMc[get_play_btn].gotoAndStop(1);
	thePlayerMc[get_play_btn].enabled = true;
	thePlayerMc[get_pause_btn].gotoAndStop(3);
	thePlayerMc[get_pause_btn].enabled = false;
	//
	theMovie[dragbar_var_mc].enabled = false;
	theMovie[bar_var_mc].enabled = false;
	//
	theMovie.mybarSample._width = 0;
	theMovie[dragbar_var_mc]._x = 0;
	delete thePlayerMc.onEnterFrame;
	// ********** SONG *******************
	ExercisePath.resetSong();
}
function stopitPress() {
	thePlayerMc[get_stop_btn].gotoAndStop(State2);
}
// **************************************************
// *************** DRAG SLIDER **********************
// **************************************************
theMovie.mybarSample = theMovie[nameOfControls[4]];
theMovie.original_width = theMovie.mybarSample._width;
//
dragbar_var_mc = theMovie.nameOfControls[3];
bar_var_mc = theMovie.nameOfControls[5];
// *********** FUNCTIONS *********************************
function slidebar_position() {
	if (theMovie.audioIsPlaying) {
		theMovie.mybarSample._width = _xmouse-theMovie.mybarSample._x;
		per2 = (theMovie.mybarSample._width/theMovie.original_width)*100;
		per3 = ((per2*theMovie.sound_obj.duration)/100)/1000;
		theMovie.sound_obj.stop();
		theMovie.sound_obj.start(per3);
	}
}
//************************
function slidebar_drag() {
	if (theMovie.audioIsPlaying) {
		delete thePlayerMc.onEnterFrame;
		startDrag(this, true, theMovie.mybarSample._x, this._y, theMovie.mybarSample._x+theMovie.original_width, this._y);
		this._alpha = 40;
	}
}
//
function slidebar_position_Release() {
	if (theMovie.audioIsPlaying) {
		this.stopDrag();
		this._alpha = 100;
		thePlayerMc.onEnterFrame = checkEnterFrame;
		theMovie.mybarSample._width = this._x-theMovie.mybarSample._x;
		per4 = (theMovie.mybarSample._width/theMovie.original_width)*100;
		per5 = ((per4*theMovie.sound_obj.duration)/100)/1000;
		theMovie.sound_obj.duration.stop();
		theMovie.sound_obj.start(per5);
	}
}
//**************************************
function checkEnterFrame() {
	if (theMovie.audioIsPlaying && !ExercisePath.songEnterFrame) {
		theMovie.mybarSample._width = (((theMovie.sound_obj.position/theMovie.sound_obj.duration)*100)*theMovie.original_width)/100;
		theMovie[dragbar_var_mc]._x = theMovie.mybarSample._width+theMovie.mybarSample._x;
	} else {
		// SONGS //
		ExercisePath.songEnterFrame();
	}
}
//
function tapeScript_Release() {
	if (!theMovie.showUnit_mc.tapescript_mc._visible) {
		theMovie.showUnit_mc.tapescript_mc._visible = true;
		theTapeScriptMc._visible = true;
		_root.showXCanvas("Tapescript")
		//this.gotoAndStop(2);
		theMovie.bg_player_mc.tapesc_btn.gotoAndStop(2);
	} else {
		theMovie.showUnit_mc.tapescript_mc._visible = false;
		theTapeScriptMc._visible = false;
		_root.hideXCanvas("Tapescript")
		//this.gotoAndStop(1)
		theMovie.bg_player_mc.tapesc_btn.gotoAndStop(1);
		//AudioScript Justification
		theMovie.showUnit_mc.resetAudioScriptButtons();
	}
}
//
function tapeScriptResize(myTapeScriptMovie) {
		theMovie.showUnit_mc.tapescript_text_mc._y = theMovie.showUnit_mc.tapescript_text_mc._y-20;
	//NEW WIDTH
	myInitWidth = theMovie.showUnit_mc.tapescript_mc._width;
	myNewWidth = (thePlayerMc._x+thePlayerMc._width)-myTapeScriptMovie._x+10;
	//NEW HEIGHT
	myInitHeight = theMovie.showUnit_mc.tapescript_mc._height;
	myNewHeight = (thePlayerMc._y+thePlayerMc._height)-myTapeScriptMovie._y+10;
	//
	if (myInitWidth<myNewWidth || myInitHeight<myNewHeight) {
		theMovie.showUnit_mc.tapescript_mc._width = myNewWidth;
		theMovie.showUnit_mc.tapescript_mc._height = myNewHeight;
		//debug.text = "thePlayerMc._x:"+thePlayerMc._y+"   thePlayerMc._height:"+thePlayerMc._width;
		theMovie.showUnit_mc.tapescript_mc._x = myTapeScriptMovie._x-10;
		theMovie.showUnit_mc.tapescript_mc._y = myTapeScriptMovie._y-10;
	}
}
//*********************************************************************************************************
//***************************************** TAPESCRIPT ****************************************************
//*********************************************************************************************************
//*********************************************************************************************************
//*********************************************************************************************************
//*********************************************************************************************************
//******************************************** INIT *******************************************************
//*********************************************************************************************************
//*********************************************************************************************************
function InitPlayer(myvar) {
	
	if(!ExercisePath.songEnterFrame){
		theMovie[dragbar_var_mc]._visible = true;
		theMovie[bar_var_mc]._visible = true;
		theMovie.mybarSample._visible = true;
	} else {
		// SONGS DISABLE ******************************
		theMovie[dragbar_var_mc]._visible = false;
		theMovie[bar_var_mc]._visible = false;
		theMovie.mybarSample._visible = false;		
	}
	
	
	
	
	theTapeScriptMc = theMovie.showUnit_mc.tapescript_text_mc;
	// INIT SOUND OBJECT
	position = 0;
	SoundObject(myvar);
	// SOUND COMPLETE
	sound_obj.onSoundComplete = AudioObjectComplete;
	//  PLAYER EVENTS  
	thePlayerMc[get_play_btn].onRelease = playit;
	thePlayerMc[get_play_btn].enabled = true;
	thePlayerMc[get_play_btn].gotoAndStop(1);
	thePlayerMc[get_pause_btn].onRelease = pauseit;
	thePlayerMc[get_pause_btn].enabled = false;
	thePlayerMc[get_pause_btn].gotoAndStop(3);
	thePlayerMc[get_stop_btn].onPress = stopitPress;
	thePlayerMc[get_stop_btn].onRelease = thePlayerMc[get_stop_btn].onReleaseOutside=stopit;
	thePlayerMc[get_stop_btn].enabled = false;
	thePlayerMc[get_stop_btn].gotoAndStop(3);
	//////////////////////////////////////////////////////
	// SLIDER CONTROLS  + EVENTS ////////////////////////
	//////////////////////////////////////////////////////
	theMovie[bar_var_mc].onRelease = slidebar_position;
	theMovie[dragbar_var_mc].onPress = slidebar_drag;
	theMovie[dragbar_var_mc].onRelease = theMovie[dragbar_var_mc].onReleaseOutside=slidebar_position_Release;
	//
	theMovie[dragbar_var_mc].enabled = false;
	theMovie[bar_var_mc].enabled = false;
	//
	theMovie.mybarSample._width = 0;
	theMovie[dragbar_var_mc]._x = 0;
	// TAPESCRIPT *****************************************
	thePlayerMc.tapesc_btn.onRelease = tapeScript_Release;
	tapeScriptResize(theTapeScriptMc);
	theMovie.showUnit_mc.tapescript_mc.useHandCursor = false;
	theMovie.showUnit_mc.tapescript_mc.onRelease = function() {
	};
	theMovie.showUnit_mc.tapescript_mc._visible = false;
	theTapeScriptMc._visible = false;
}
