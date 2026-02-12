//MOD - 18/11/11 - NK
// Grammar Ref button is disabled if no relevant grammar .swf is found
// added support for variable pointer to gram ref. swf
var theMovie = this
var mclListenerGrammarRef:Object = new Object();
var mcLoaderGrammarRef:MovieClipLoader = new MovieClipLoader();
var mclListenerGrammarAnim:Object = new Object();
var mcLoaderGrammarAnim:MovieClipLoader = new MovieClipLoader();
//-------------------------------------
function mclListenerGrammarAnim_onLoadInit(mc:MovieClip) {
	theMovie.grMenu_mc.grammarAnim_mc.enabled = true;
	theMovie.showGrammarAnim_mc._visible = false;
	trace("showGrammarAnim_mc load")
}
function mclListenerGrammarRef_onLoadInit(mc:MovieClip) {
	theMovie.grMenu_mc.grammarRef_mc.enabled = true;
	theMovie.showGrammarRef_mc._visible = false;
	trace("showGrammarRef_mc load")
}

function stringToNum(dec_input:String) { 
	var sum:Number = 0;
	var dec_length:Number = dec_input.length; 
	var expCnt:Number = dec_length - 1;
	for (var i = 0; i <= dec_length-1; i++) { 
		var dec_value:Number = (dec_input.charCodeAt(i) - 48); 
		dec_value *= (Math.pow(10, expCnt)); 
		sum += dec_value; 
		expCnt -= 1; 
	}
	return sum;
}
String.prototype.replace = function(searchStr, replaceStr):String {	
    var arr:Array = this.split(searchStr);
    return arr.join(replaceStr);
};


function extractLessonNum(folder, criterion):String{
	var theresult = Number;
	theresult = stringToNum(folder.substr(criterion.length, folder.length)) + 1;
	return theresult;
}

//-------------------------------------------------
function checkMyGrammarReferencePath():String {
	var tempPathGrammarReference:String = "";
	var theMovieUnitFolderName = theMovie.UnitFolderName;
	var theMovieLessonFolderName = theMovie.LessonFolderName;
	tempPathGrammarReference = "units/"+theMovieUnitFolderName+"/vocabulary/vocabulary.swf";
	trace("tempPathGrammarReference  "+tempPathGrammarReference);
	return tempPathGrammarReference;
}

function checkMyGrammarAnimationPath():String {
	var tempPathGrammarAnimation:String = "";
	var theMovieUnitFolderName = theMovie.UnitFolderName;
	var theMovieLessonFolderName = theMovie.LessonFolderName;
	tempPathGrammarAnimation = "units/irregularVerbs/irregularVerbs.swf";
	trace("tempPathGrammarAnimation  "+tempPathGrammarAnimation);
	return tempPathGrammarAnimation;
}
theMovie.grMenu_mc.grammarRef_mc.onRelease = function() {
	theMovie.grMenu_mc.grammarRef_mc.gotoAndStop(1);
	theMovie.grMenu_mc.grammarAnim_mc.gotoAndStop(1);
	if (theMovie.showGrammarRef_mc._visible == false) {
		hideAllExtraMenu()
		//stopAllSounds();
		//disableAudioPlayer()
		this.gotoAndStop(3);
		_root.showXCanvas("GrammarRef")		
		theMovie.showGrammarRef_mc._visible = true;
		theMovie.grMenu_mc._visible = false;
		theMovie.settings_mc.gotoAndStop(3)
	} else {
		//stopAllSounds();
		//enableAudioPlayer()
		this.gotoAndStop(1);
		theMovie.showGrammarRef_mc._visible = false;
		_root.hideXCanvas("GrammarRef");
		theMovie.settings_mc.gotoAndStop(1)
	}
	//delete thePlayerMc.onEnterFrame;
	//***********************************
};
theMovie.grMenu_mc.grammarAnim_mc.onRelease = function() {
	theMovie.grMenu_mc.grammarRef_mc.gotoAndStop(1);
	theMovie.grMenu_mc.grammarAnim_mc.gotoAndStop(1);
	if (theMovie.showGrammarAnim_mc._visible == false) {
		hideAllExtraMenu()
		trace("showGrammarAnim_mc - true")
		//stopAllSounds();
		//disableAudioPlayer()
		this.gotoAndStop(3);
		_root.showXCanvas("Grammar");
		theMovie.showGrammarAnim_mc._visible = true;
		theMovie.showGrammarAnim_mc.gotoAndStop(2);
		theMovie.grMenu_mc._visible = false;
		theMovie.settings_mc.gotoAndStop(3)
	} else {
		trace("showGrammarAnim_mc - false")
		//stopAllSounds();
		//enableAudioPlayer()
		this.gotoAndStop(1);
		_root.hideXCanvas("Grammar");
		theMovie.showGrammarAnim_mc._visible = false;
		theMovie.showGrammarAnim_mc.gotoAndStop(1);
		theMovie.settings_mc.gotoAndStop(1)
	}
	//delete thePlayerMc.onEnterFrame;
	//***********************************
};
theMovie.settings_mc.onRelease = function() {
	if (theMovie.grMenu_mc._visible) {
		theMovie.grMenu_mc._visible = false;		
	} else {
		_root.hideXCanvas("Grammar");
		_root.hideXCanvas("GrammarRef");
		//enableAudioPlayer()
		theMovie.grMenu_mc._visible = true;
		grammarRefPath = checkMyGrammarReferencePath();
		grammarExists=new LoadVars();
		grammarExists._parent=this;
		grammarExists.onLoad=function(success) {
			if (success) {
				theMovie.grMenu_mc.grammarRef_mc.gotoAndStop(1);
				theMovie.grMenu_mc.grammarRef_mc.enabled = true;
				mcLoaderGrammarRef.loadClip(grammarRefPath,theMovie.showGrammarRef_mc);
				theMovie.showGrammar_mc._visible = false;
			} else {
				trace("no grammar");
				theMovie.grMenu_mc.grammarRef_mc.gotoAndStop(2);
				theMovie.grMenu_mc.grammarRef_mc.enabled = false;
			}
		}
		grammarExists.load(grammarRefPath);	
		grammarAnimPath = checkMyGrammarAnimationPath()
		mcLoaderGrammarAnim.loadClip(grammarAnimPath,theMovie.showGrammarAnim_mc);
		theMovie.grMenu_mc.grammarAnim_mc.gotoAndStop(1);
	}
	if ((this._currentframe==3)||(this._currentframe>=31)) {
		trace("settings_reset")
		this.gotoAndStop(1)		
		theMovie.showGrammarRef_mc._visible = false;
		theMovie.showGrammarAnim_mc._visible = false;
		resetExtraButtons()
	}
};
function hideAllExtraMenu() {
	//stopAllSounds();
	//enableAudioPlayer();
	trace("video "+theMovie.showVideo_mc._visible);
	trace("grammarRef "+theMovie.showGrammarRef_mc._visible);
	trace("grammarAnim "+theMovie.showGrammarAnim_mc._visible);
	trace("Definition "+theMovie.showDefinition_mc._visible);
	//----closeVideo
	if (theMovie.showVideo_mc._visible == true) {
		theMovie.showVideo_mc._visible = false;
		theMovie.videos_mc.gotoAndStop(1);
		theMovie.showVideo_mc.resetVideo();
		theMovie.showVideo_mc._visible = false;
		_root.hideXCanvas("Video");
	}
	//----closeDefinition   
	if (theMovie.showDefinition_mc._visible == true) {
		theMovie.showDefinition_mc._visible = false;
		theMovie.definition_mc.gotoAndStop(1);
		_root.hideXCanvas("Wordlist");
	}
	//----closeGrammarRef   
	theMovie.grMenu_mc._visible = false;
	if (theMovie.showUnit_mc.showGrammar == 1) {
		if (theMovie.showGrammarRef_mc._visible == true) {
			theMovie.grMenu_mc.grammarRef_mc.gotoAndStop(1);
			_root.hideXCanvas("GrammarRef");
			theMovie.showGrammarRef_mc._visible = false;
			theMovie.settings_mc.gotoAndStop(1);
			theMovie.grMenu_mc._visible = false;
		}
		//----closeGrammarAnim  
		if (theMovie.showGrammarAnim_mc._visible == true) {
			theMovie.grMenu_mc.grammarAnim_mc.gotoAndStop(1);
			_root.hideXCanvas("Grammar");
			theMovie.showGrammarAnim_mc._visible = false;
			theMovie.settings_mc.gotoAndStop(1);
			theMovie.grMenu_mc._visible = false;
		}
	}
	//PLAYER RESET ENTERFRAME!!!!!!!!CDEv  
	//delete thePlayerMc.onEnterFrame;
}
//-----------------------
function buttonTooltip_mcExers_onRollOver() {
	theMovie.toolCheck_mc.gotoAndStop(1);
	theMovie.toolShowAll_mc.gotoAndStop(1);
	if (this._currentframe == 1) {
		this.gotoAndPlay(4);
	}
	if (this._currentframe == 3) {
		this.gotoAndPlay(31);
	}
}
function buttonTooltip_mc_onRollOut() {
	if ((this._currentframe<31) && (this._currentframe>3)) {
		this.gotoAndPlay(1);
	}
	if (this._currentframe>=31) {
		this.gotoAndPlay(3);
	}
}
//----------------------------------------------------------------
function resetExtraButtons() {
	if ((theMovie.UnitFolderName.substr(0, 5) == "expan")||(theMovie.UnitFolderName.substr(0, 4) == "unit")){
	theMovie.settings_mc.gotoAndStop(1);
		theMovie.settings_mc._visible=true
	}else{
		theMovie.settings_mc._visible=false
		}
	theMovie.grMenu_mc._visible = false;
	theMovie.grMenu_mc.grammarAnim_mc.gotoAndStop(1);
	theMovie.grMenu_mc.grammarRef_mc.gotoAndStop(1);
	//-----------------------
	theMovie.showGrammarRef_mc._visible = false;
	theMovie.showGrammarAnim_mc._visible = false;
	mcLoaderGrammarAnim.unloadClip(theMovie.showGrammarAnim_mc);
	mcLoaderGrammarRef.unloadClip(theMovie.showGrammarRef_mc);
}
function startGrammarButtons(){
	theMovie.settings_mc.onRollOver = buttonTooltip_mcExers_onRollOver;
	theMovie.settings_mc.onRollOut = buttonTooltip_mc_onRollOut;
	theMovie.grMenu_mc.grammarAnim_mc.onRollOver = buttonTooltip_mcExers_onRollOver;
	theMovie.grMenu_mc.grammarAnim_mc.onRollOut = buttonTooltip_mc_onRollOut;
	theMovie.grMenu_mc.grammarRef_mc.onRollOver = buttonTooltip_mcExers_onRollOver;
	theMovie.grMenu_mc.grammarRef_mc.onRollOut = buttonTooltip_mc_onRollOut;
	trace("HEREEE????")
	mclListenerGrammarAnim.onLoadInit = mclListenerGrammarAnim_onLoadInit;
	mcLoaderGrammarAnim.addListener(mclListenerGrammarAnim);
	mclListenerGrammarRef.onLoadInit = mclListenerGrammarRef_onLoadInit;
	mcLoaderGrammarRef.addListener(mclListenerGrammarRef);
	trace("HEREEE????")
	theMovie.showGrammarRef_mc._visible = false;
	theMovie.showGrammarAnim_mc._visible = false;
	resetExtraButtons()
}
startGrammarButtons()