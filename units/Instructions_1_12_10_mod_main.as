//MOD:27/6/11 - Init at AS mod - NK

function instructions_mc_onEnterFrame() {
//	//trace("enterframe")
	this.counter++;
	if (this.counter >= 60) {
		this._alpha-= 10;
		if (this._alpha <= 0) {
			//this.swapDepths(2000);
			delete this.onEnterFrame;
			this._visible=false
		}
	}
}
//
function instructions_mc_onRelease(){
	delete theMovie.instructions_mc.onEnterFrame
	//this.swapDepths(2000);
	this._visible=false
}
//
function initInstructions(myType:String){
	theMovie.instructions_mc.instructionText_mc.instructionText_txt_0.text = "";
	theMovie.instructions_mc.instructionText_mc.instructionText_txt_1.text = "";
	theMovie.instructions_mc.instructionText_mc.instructionText_txt_2.text = "";
	theMovie.instructions_mc.instructionText_mc.gotoAndStop(1);
	delete theMovie.instructions_mc.onEnterFrame;
	theMovie.instructions_mc._visible=false;
	// Extra functionality for Word Definition (applied globally)
	if((theMovie.showUnit_mc.showText == 1)||(theMovie.showUnit_mc.showPlayer == 1)||(theMovie.showUnit_mc.speakers == 1)||(theMovie.showUnit_mc.ComicStrip == 1)||(myType == "WD")){
		if(myType == "WD"){
			if(theMovie.showUnit_mc.showText == 1){
				theMovie.instructions_mc.instructionText_mc.gotoAndStop(2);
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_0.text = "Use the show more button to view more information.";
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_1.text = "Click on the word definition button to see the definition of words.";
				theMovie.instructions_mc.instructionIcons_mc.gotoAndStop(9);
			} else if(theMovie.showUnit_mc.showPlayer == 1){
				theMovie.instructions_mc.instructionText_mc.gotoAndStop(2);
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_0.text = "Click on the word definition button to see the definition of words.";
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_1.text = "Use the audio controls to listen!";
				theMovie.instructions_mc.instructionIcons_mc.gotoAndStop(10);
			} else {
				theMovie.instructions_mc.instructionText_mc.instructionText_txt.text = "Click on the word definition button to see the definition of words.";
				theMovie.instructions_mc.instructionIcons_mc.gotoAndStop(8);
			}		
		} else if(theMovie.showUnit_mc.showText == 1){
			if(theMovie.showUnit_mc.showPlayer == 1){
				if(theMovie.showUnit_mc.speakers == 1){
				theMovie.instructions_mc.instructionText_mc.gotoAndStop(3);
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_0.text = "Use the show more button to view more information.";
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_1.text = "Use the audio controls to listen!";
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_2.text = "Click on the headphones to listen!";
				theMovie.instructions_mc.instructionIcons_mc.gotoAndStop(11);
			}else{
				theMovie.instructions_mc.instructionText_mc.gotoAndStop(2);
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_0.text = "Use the show more button to view more information.";
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_1.text = "Use the audio controls to listen!";
				theMovie.instructions_mc.instructionIcons_mc.gotoAndStop(4);
			}
			} else if(theMovie.showUnit_mc.speakers == 1){
				theMovie.instructions_mc.instructionText_mc.gotoAndStop(2);
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_0.text = "Use the show more button to view more information.";
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_1.text = "Click on the headphones to listen!";
				theMovie.instructions_mc.instructionIcons_mc.gotoAndStop(5);
			} else {
				theMovie.instructions_mc.instructionText_mc.instructionText_txt.text = "Use the show more button to view more information.";
				theMovie.instructions_mc.instructionIcons_mc.gotoAndStop(1);
			}
		} else if(theMovie.showUnit_mc.showPlayer == 1){
			if(theMovie.showUnit_mc.speakerNames == 1){
				theMovie.instructions_mc.instructionText_mc.gotoAndStop(2);
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_0.text = "Click on the names to listen!";
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_1.text = "Use the audio controls to listen!";
				theMovie.instructions_mc.instructionIcons_mc.gotoAndStop(7);	
			}else{
			if(theMovie.showUnit_mc.speakers == 1){
				theMovie.instructions_mc.instructionText_mc.gotoAndStop(2);
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_0.text = "Click on the headphones to listen!";
				theMovie.instructions_mc.instructionText_mc.instructionText_txt_1.text = "Use the audio controls to listen!";
				theMovie.instructions_mc.instructionIcons_mc.gotoAndStop(6);			
			} else if(theMovie.showUnit_mc.ComicStrip == 1){
					theMovie.instructions_mc.instructionText_mc.gotoAndStop(2);
					theMovie.instructions_mc.instructionText_mc.instructionText_txt_0.text = "Click on the frames to zoom and click on the dialogue lines to listen.";
					theMovie.instructions_mc.instructionText_mc.instructionText_txt_1.text = "Use the audio controls to listen!";
					theMovie.instructions_mc.instructionIcons_mc.gotoAndStop(7);
			} else {
					theMovie.instructions_mc.instructionText_mc.gotoAndStop(1);
					theMovie.instructions_mc.instructionText_mc.instructionText_txt.text = "Use the audio controls to listen!";
					theMovie.instructions_mc.instructionIcons_mc.gotoAndStop(2);
			}
			}
		} else if(theMovie.showUnit_mc.speakers == 1){
			theMovie.instructions_mc.instructionText_mc.instructionText_txt.text = "Click on the headphones to listen!";
			theMovie.instructions_mc.instructionIcons_mc.gotoAndStop(3);
		}
		//
		////trace("hereeeeeee")
		theMovie.instructions_mc._alpha=100
		theMovie.instructions_mc.counter=0;
		theMovie.instructions_mc.onEnterFrame=instructions_mc_onEnterFrame;
		theMovie.instructions_mc.onRelease=instructions_mc_onRelease;
		theMovie.instructions_mc._visible=true
	
	}
}

