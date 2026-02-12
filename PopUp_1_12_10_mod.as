//MOD:29/6/11 - removed playRight/Wrong answer definition - moved to UNITS
//MOD:27/6/11 - Init at AS mod - NK
/*MOD:10/11/11 - CD
1. Correct and wrong sounds added when global check is pressed.
*/

stop();
var numOfGaps:Number;
var numOfWords:Number;
//

function popCheckAllRelease() {
	//MOD:10/11/11 
	var checkAllOK = 1;
	
	if (this.pressed == false) {
		this.pressed = true;
		this.gotoAndStop(3);
		for (i=0; i<numOfGaps; i++) {
			theMovie["pop"+i+"_mc"].enabled = false;
			//
			debug3.text = theMovie["popCheck"+i]._currentframe
			if (theMovie["popCheck"+i]._currentframe == 1) {
				theMovie["popCheck"+i].pressed = true;
				if(theMovie["pop"+i+"_mc"].text_txt.text == theMovie.popCorrect_array[i]){
					theMovie["popCheck"+i].gotoAndStop(4);
				} else {
					theMovie["popCheck"+i].gotoAndStop(5);
					//MOD:10/11/11 
					checkAllOK = 0;
				}
			}
		}
		
		//MOD:10/11/11 
		//End of Check Final Results
		//When Activity Completed:
		if (checkAllOK) {
			//playRightAnswer();
		} else {
			//playWrongAnswer();
		}
	} else {
		this.pressed = false;
		this.gotoAndStop(1);
		for (i=0; i<numOfGaps; i++) {
			theMovie["pop"+i+"_mc"].enabled = true;
			//
			debug3.text = theMovie["popCheck"+i]._currentframe
			if (theMovie["popCheck"+i]._currentframe != 3) {
				theMovie["popCheck"+i].pressed = 0;
				theMovie["popCheck"+i].gotoAndStop(1);
			}
		}
	}
}
// Individual Check Button
function popIndCheckRelease() {
	if (!this.pressed){
		debug1.text = theMovie["pop"+this.myID+"_mc"].text_txt.text
		debug2.text = theMovie.popCorrect_array[this.myID]
		this.pressed = true;
		if(theMovie["pop"+this.myID+"_mc"].text_txt.text == theMovie.popCorrect_array[this.myID]){
			this.gotoAndStop(4);
			playRightAnswer();
		} else {
			this.gotoAndStop(5);
			playWrongAnswer();
		}
		theMovie["pop"+this.myID+"_mc"].enabled = false;
	} else {
		this.pressed = false;
		theMovie["pop"+this.myID+"_mc"].enabled = true;
		this.gotoAndStop(1);
	}
	var checkDownButton = 0;
	for (i=0; i<numOfGaps; i++) {
		if (theMovie["popCheck"+i]._currentframe == 1) {
			checkDownButton = 1;
		}
	}
	if (checkDownButton == 0) {
		theMovie._parent.checkAll_mc.pressed = 1;
		theMovie._parent.checkAll_mc.gotoAndStop(3);
	} else {
		theMovie._parent.checkAll_mc.pressed = 0;
		theMovie._parent.checkAll_mc.gotoAndStop(1);
	}
	
}


// When a gap is pressed
function popPhrasesRelease() {
	if (!this.pressed) {
		for (i=0; i<numOfGaps; i++) {
			theMovie["pop"+i+"_mc"].pressed = false;
			theMovie["popUpMenu_"+i]._visible = false;
		}
		//
		for (k=0; k<numOfWords; k++) {
			theMovie["popUpMenu_"+this.myID]["phraseBox_"+k]._visible = false;
		}
		theMovie["popUpMenu_"+this.myID]._visible = true;
		//
		theMovie["popUpMenu_"+this.myID]._alpha = 0;
		this.onEnterFrame = function(){
			theMovie["popUpMenu_"+this.myID]._alpha += 20;
			if(theMovie["popUpMenu_"+this.myID]._alpha>90){
				theMovie["popUpMenu_"+this.myID]._alpha =100;
				for (b=0; b<numOfWords; b++) {
					theMovie["popUpMenu_"+this.myID]["phraseBox_"+b]._visible = true;
				}
				delete this.onEnterFrame;
			}
		}
		this.pressed = true;
	} else {
		for (i=0; i<numOfGaps; i++) {
			theMovie["pop"+i+"_mc"].pressed = false;
			theMovie["popUpMenu_"+i]._visible = false;
		}
	}
}
// When a choice is made in the pop up box
function popBoxRelease() {
	theMovie["pop"+this.myGroup+"_mc"].gotoAndStop(2);
	theMovie["pop"+this.myGroup+"_mc"].text_txt.text = this.text_txt.text;
	theMovie["pop" +this.myGroup+ "_mc"].myCurrent =this.text_txt.text;
	theMovie["pop"+this.myGroup+"_mc"].pressed = false;
	this._parent._visible = false;
	//
	theMovie["popCheck"+this.myGroup].gotoAndStop(1);
	theMovie["popCheck"+this.myGroup].onRelease = popIndCheckRelease;
	//
	theMovie._parent.checkAll_mc.gotoAndStop(1);
	theMovie._parent.checkAll_mc.enabled = true;
	theMovie._parent.checkAll_mc.pressed = 0;
}

//solution

function solutionPoPup(){
	if (this.pressed == 0) {
		this.pressed = 1;
		this.gotoAndStop(3);
		theMovie._parent.checkAll_mc.rightframe = theMovie._parent.checkAll_mc._currentframe;
		theMovie._parent.checkAll_mc.gotoAndStop(2)
        for (var i = 0; i < theMovie.popCorrect_array.length; i++) {
			theMovie["pop" +i + "_mc"].gotoAndStop(2)
			theMovie["popCheck"+i].goframe = theMovie["popCheck"+i]._currentframe;
			theMovie["popCheck"+i].gotoAndStop(3)
			theMovie["pop" +i + "_mc"].text_txt.text=theMovie["pop" +i + "_mc"].myCorrect
			theMovie["pop"+i+"_mc"].enabled=false;
			theMovie["popCheck"+i].enabled=false;
			
			
			
		
		}

	} else {
		this.pressed = 0;
		this.gotoAndStop(1);
		theMovie._parent.checkAll_mc.enabled = true;
		theMovie._parent.checkAll_mc.gotoAndStop(theMovie._parent.checkAll_mc.rightframe)
        theMovie._parent.showAll_mc.enabled = true;
        for (var i = 0; i < theMovie.popCorrect_array.length; i++) {
			theMovie["pop" +i + "_mc"].text_txt.text=theMovie["pop" +i + "_mc"].myCurrent
			theMovie["pop"+i+"_mc"].enabled=true;
			theMovie["popCheck"+i].gotoAndStop(theMovie["popCheck"+i].goframe);
			theMovie["popCheck"+i].enabled=true;
			
			}
		
	}
	}

// INIT **************************************************
function initPopUp() {	
	numOfGaps = popUp_array.length;
	numOfWords = theMovie.popCorrect_array.length;
	//	
	for(i=0; i<numOfGaps; i++){
		theMovie["pop" +i + "_mc"].myCorrect=theMovie.popCorrect_array[i];
		theMovie["pop" +i + "_mc"].myCurrent = "";
		
		for(j=0; j<numOfWords; j++){
			theMovie["popUpMenu_"+i]["phraseBox_"+j].text_txt.text = theMovie.popUp_array[j]
			theMovie["popUpMenu_"+i]["phraseBox_"+j].myID = j;
			theMovie["popUpMenu_"+i]["phraseBox_"+j].myGroup = i;
			theMovie["popUpMenu_"+i]["phraseBox_"+j].onRelease = popBoxRelease;
			
			
		}
		theMovie["popUpMenu_"+i]._visible = false;
		theMovie["popUpMenu_"+i].myID = i;
		//
		theMovie["pop"+i+"_mc"].onRelease = popPhrasesRelease;
		theMovie["pop"+i+"_mc"].pressed = false;
		theMovie["pop"+i+"_mc"].myID = i;
		//
		
		theMovie["popCheck"+i].gotoAndStop(3);
		theMovie["popCheck"+i].pressed = false;
		theMovie["popCheck"+i].myID = i;
		
		
	}	
	//
	//
	theMovie._parent.showAll_mc.gotoAndStop(2);
	theMovie._parent.showAll_mc.enabled = true;
	theMovie._parent.showAll_mc.onRelease = solutionPoPup;
	theMovie._parent.showAll_mc.pressed=0;

	
	//
	theMovie._parent.checkAll_mc.gotoAndStop(2);
	theMovie._parent.checkAll_mc.enabled = false;
	theMovie._parent.checkAll_mc.pressed = 0;
	theMovie._parent.checkAll_mc.onRelease = popCheckAllRelease;
}

initPopUp();