// 29 - 7 - 2011 --- true false & complete code - takis
//MOD:29/6/11 - removed playRight/Wrong answer definition - moved to UNITS
//MOD:27/6/11 - Init at AS mod - NK

stop();
//justifications
/*

*/

var myNamesArray = new Array("a", "b", "c", "d", "e", "f");
function i_mc_onRelease() {
	if (!this.pressed) {
		for (i=0; i<theMovie.theRightArray.length; i++) {
			theMovie["i"+i+"_mc"].pressed = false;
			theMovie["info"+i+"_mc"]._visible = false;
			theTextPointer["justification"+i+"_mc"]._visible = false;
			// Read the array for Scroll steps of Justification
			theTextPointer["justification"+i+"_mc"].mySteps = theMovie.theStepsJustificationArray[i]
			// Read the array for Scroll steps of Justification
		}
		this.pressed = true;
		//this.gotoAndStop(2);
		theMovie["info"+this.myNo+"_mc"]._visible = true;
		theMovie.text_1_mc._visible = true;
		theTextPointer["justification"+this.myNo+"_mc"]._visible = true;
		theMovie._parent.showText_mc.clicked = 1;
		theMovie._parent.showText_mc.gotoAndPlay(3);
		// Move Scrollbar
		theTextPointer._parent.UpdateScrollBar(this.myNo)
		_root.showXCanvas("ShowText");
		// Move Scrollbar		
	} else {
		this.pressed = false;
		theMovie["info"+this.myNo+"_mc"]._visible = false;
		theTextPointer["justification"+this.myNo+"_mc"]._visible = false;
		theMovie._parent.showText_mc.clicked = 0;
		theMovie._parent.showText_mc.gotoAndPlay(1);
		_root.hideXCanvas("ShowText");
	}
}
//
function buttonReleaseOutside() {
	this.gotoAndStop(1);
}
//
function buttonRelease() {
	for (i=0; i<this.myItems; i++) {
		for (m=0; m<myNamesArray.length; m++) {
			myButLetter = myNamesArray[m];
			if (theMovie[myButLetter+i+"_mc"].myNo == this.myNo and theMovie[myButLetter+i+"_mc"]._name<>this._name) {
				if (typeof (theRightArray[this.myNo]) == "string") {
					theMovie[myButLetter+i+"_mc"].gotoAndStop(1);
					theMovie[myButLetter+i+"_mc"].enabled = true;
				}
			}
		}
	}
	if (this._currentframe == 1) {
		this.gotoAndStop(2);
		if (typeof (theRightArray[this.myNo]) == "string") {
			theMovie.myArray[this.myNo] = this.myName;
			this.enabled = false;
		} else {
			theMovie.myArray[this.myNo][m] = this.myName;
		}
	} else {
		if (typeof (theRightArray[this.myNo]) == "string") {
			//theMovie.myArray[this.myNo] = 0;
		} else {
			this.gotoAndStop(1);
			theMovie.myArray[this.myNo][m] = 0;
		}
	}

	var checkDownButton = 0;
	theMovie._parent.checkAll_mc.clicked = 1;
	theMovie._parent.checkAll_mc.gotoAndStop(2);
	theMovie._parent.checkAll_mc.enabled = false;
	for (i=0; i<this.myItems; i++) {
		for (m=0; m<myNamesArray.length; m++) {
			myButLetter = myNamesArray[m];
			if (theMovie[myButLetter+i+"_mc"]._currentframe != 1) {
				checkDownButton = 1;
			}
		}
	}
	if (checkDownButton == 0) {
		theMovie["check"+this.myNo+"_mc"].clicked =1;
		theMovie["check"+this.myNo+"_mc"].gotoAndStop(3);
		theMovie["check"+this.myNo+"_mc"].enabled = false;
	} else {
		theMovie["check"+this.myNo+"_mc"].clicked = 0;
		theMovie["check"+this.myNo+"_mc"].gotoAndStop(1);
		theMovie["check"+this.myNo+"_mc"].enabled = true;
		theMovie._parent.checkAll_mc.clicked = 0;
		theMovie._parent.checkAll_mc.gotoAndStop(1);
		theMovie._parent.checkAll_mc.enabled = true;
	}
}
//
function buttonPress() {
	//this.gotoAndStop(2);
}
//
function initTrueFalse(numOfItems, myChoices, myParameter) {
	for (i=0; i<numOfItems; i++) {
		for (m=0; m<myNamesArray.length; m++) {
			myButLetter = myNamesArray[m];
			theMovie[myButLetter+i+"_mc"].gotoAndStop(1);
			theMovie[myButLetter+i+"_mc"].onRelease = buttonRelease;
			if (myParameter<>2) {
				theMovie[myButLetter+i+"_mc"].onPress = buttonPress;
				theMovie[myButLetter+i+"_mc"].onReleaseOutside = buttonReleaseOutside;
			}
			theMovie[myButLetter+i+"_mc"].clicked = 0;
			theMovie[myButLetter+i+"_mc"].myNo = i;
			theMovie[myButLetter+i+"_mc"].myItems = numOfItems;
			theMovie[myButLetter+i+"_mc"].myName = myButLetter;
			theMovie[myButLetter+i+"_mc"].myState = 0; //------for showAll
		}

		//---------------------------
		theMovie["check"+i+"_mc"].myNum = i;
		theMovie["check"+i+"_mc"].clicked = 0;
		theMovie["check"+i+"_mc"].gotoAndStop(3);
		theMovie["check"+i+"_mc"].enabled = false;
		theMovie["check"+i+"_mc"].onRelease = checkOneAnswer;
		//----------------------------
		theMovie["i"+i+"_mc"].onRelease = i_mc_onRelease;
		theMovie["i"+i+"_mc"].myNo = i;
		theMovie["i"+i+"_mc"].pressed = false;
		theMovie["i"+i+"_mc"]._visible = false;
		theMovie["info"+i+"_mc"]._visible = false;
		theMovie.theTextPointer["justification"+i+"_mc"]._visible = false;
	}
	//
	theMovie._parent.checkAll_mc.gotoAndStop(2);
	theMovie._parent.checkAll_mc.enabled = false;
	theMovie._parent.checkAll_mc.clicked = 0;
	theMovie._parent.checkAll_mc.onRelease = check_answers;
	//
	theMovie._parent.showAll_mc.gotoAndStop(1);
	theMovie._parent.showAll_mc.enabled = true;
	theMovie._parent.showAll_mc.clicked = 0;
	theMovie._parent.showAll_mc.onRelease = showAll_answers;
}

function showAll_answers() {

	if (this.clicked == 0) {
		this.clicked = 1;
		this.gotoAndStop(3);
		// complete
		for (var i=0; i<numberOfPhrases; i++) {
			theMovie["p"+i+"_mc"].gotoAndStop(2);
			theMovie["p"+i+"_mc"].pressed = true;
			theMovie["phrase"+i+"_mc"].gotoAndStop(2);
			theMovie["phrase"+i+"_mc"].text_txt.text = theMovie["p"+i+"_mc"].myText;
			theMovie["phrase"+i+"_mc"].background_mc._visible = true;	
			// AUDIOScript Justification
			theMovie["audioJustify_"+i]._visible = true;
			theMovie["audioJustify_"+i].gotoAndStop(1);
			theMovie["audioJustify_"+i].pressed = false;
			// ShowText Justification
			theMovie["i"+i+"_mc"]._visible = true;
			theMovie["i"+i+"_mc"].gotoAndStop(1);
			theMovie["i"+i+"_mc"].pressed = false;
		}
		//
			theMovie._parent.checkAll_mc.myRightFrame = theMovie._parent.checkAll_mc._currentframe
			theMovie._parent.checkAll_mc.enabled=false
			theMovie._parent.checkAll_mc.gotoAndStop(2);
			//---------------------------		
		for (i = 0; i < theMovie.myArray.length; i++) {
			for (m = 0; m < myNamesArray.length; m++) {
				myButLetter = myNamesArray[m];
				theMovie[myButLetter + i + "_mc"].myState = 0				
				theMovie[myButLetter + i + "_mc"].enabled = false;
				theMovie["i"+i+"_mc"]._visible = true;
				if (typeof (theRightArray[i]) == "string") {
					if ((theMovie[myButLetter + i + "_mc"]._currentframe == 1) and (theMovie[myButLetter + i + "_mc"].myName == theMovie.theRightArray[i])) {
						trace("1")
						theMovie[myButLetter + i + "_mc"].myState = 0
						theMovie[myButLetter + i + "_mc"].gotoAndStop(4);
					}
					if ((theMovie[myButLetter + i + "_mc"]._currentframe == 2) and (theMovie[myButLetter + i + "_mc"].myName == theMovie.theRightArray[i])) {
						trace("2")
						theMovie[myButLetter + i + "_mc"].myState = 1
						theMovie[myButLetter + i + "_mc"].gotoAndStop(4);
					}
					if ((theMovie[myButLetter + i + "_mc"]._currentframe == 2) and (theMovie[myButLetter + i + "_mc"].myName <> theMovie.theRightArray[i])) {
						trace("3")
						theMovie[myButLetter + i + "_mc"].myState = 1
						theMovie[myButLetter + i + "_mc"].gotoAndStop(1);
					}
				} else {
					var clickedWrongSingle = 0
					for (k = 0; k < myNamesArray.length; k++) {
						if ((theMovie[myButLetter + i + "_mc"]._currentframe == 1) and (theMovie[myButLetter + i + "_mc"].myName == theMovie.theRightArray[i][k])) {
							trace("4")
							theMovie[myButLetter + i + "_mc"].myState = 0
							theMovie[myButLetter + i + "_mc"].gotoAndStop(4);
						}
						if ((theMovie[myButLetter + i + "_mc"]._currentframe == 2) and (theMovie[myButLetter + i + "_mc"].myName == theMovie.theRightArray[i][k])) {
							trace("5")
							clickedWrongSingle = 1
							theMovie[myButLetter + i + "_mc"].myState = 1
							theMovie[myButLetter + i + "_mc"].gotoAndStop(4);
						}
					}
					if ((theMovie[myButLetter + i + "_mc"]._currentframe == 2)&&(clickedWrongSingle == 0)) {
							trace("5")
							theMovie[myButLetter + i + "_mc"].myState = 1
							theMovie[myButLetter + i + "_mc"].gotoAndStop(1);
					}
				}
			}
			theMovie["check" + i + "_mc"].myRightFrame = theMovie["check" + i + "_mc"]._currentframe
			theMovie["check" + i + "_mc"].enabled=false
			theMovie["check" + i + "_mc"].gotoAndStop(3);
			// AUDIOScript Justification
			theMovie["audioJustify_"+i]._visible = true;
			theMovie["audioJustify_"+i].gotoAndStop(1);
			theMovie["audioJustify_"+i].pressed = false;
		}
	} else {
		this.clicked = 0;
		this.gotoAndStop(1);
		// complete
		for (var i=0; i<numberOfPhrases; i++) {
			theMovie["p"+i+"_mc"].gotoAndStop(1);
			theMovie["p"+i+"_mc"].pressed = false;
			theMovie["phrase"+i+"_mc"].gotoAndStop(1);
			theMovie["phrase"+i+"_mc"].text_txt.text = "";
			theMovie["phrase"+i+"_mc"].background_mc._visible = false;	
			// AUDIOScript Justification
			theMovie["audioJustify_"+i]._visible = false;
			theMovie["audioJustify_"+i].gotoAndStop(1);
			theMovie["audioJustify_"+i].pressed = false;
			// ShowText Justification
			theMovie["i"+i+"_mc"]._visible = false;
			theMovie["i"+i+"_mc"].gotoAndStop(1);
			theMovie["i"+i+"_mc"].pressed = false;
		}
		//--------------
		theMovie._parent.checkAll_mc.gotoAndStop(theMovie._parent.checkAll_mc.myRightFrame);	
		if (theMovie._parent.checkAll_mc._currentframe!=2){
			theMovie._parent.checkAll_mc.enabled=true
		}
		//--------------
		for (i = 0; i < theMovie.myArray.length; i++) {
			//theMovie["i" + i + "_mc"]._visible = false;
			theMovie["check" + i + "_mc"].gotoAndStop(theMovie["check" + i + "_mc"].myRightFrame);			
			if (theMovie["check" + i + "_mc"]._currentframe!=3){
				theMovie["check" + i + "_mc"].enabled=true
			}
			
			theMovie["i"+i+"_mc"]._visible = false;

			for (m = 0; m < myNamesArray.length; m++) {
				
				myButLetter = myNamesArray[m];
				if (theMovie[myButLetter + i + "_mc"].myState == 1) {
					theMovie[myButLetter + i + "_mc"].gotoAndStop(2)
				}else{
					theMovie[myButLetter + i + "_mc"].gotoAndStop(1)
				}
				
				
				if ((theMovie["check" + i + "_mc"]._currentframe!=4)&&(theMovie["check" + i + "_mc"]._currentframe!=5)){
					if (typeof (theRightArray[i]) == "string") {
					} else {
						theMovie[myButLetter+i+"_mc"].enabled = true;
					}
					if (theMovie[myButLetter + i + "_mc"].myState == 0) {
						theMovie[myButLetter + i + "_mc"].enabled = true;
					}
					// AUDIOScript Justification
					theMovie["audioJustify_"+i]._visible = false;
					theMovie["audioJustify_"+i].gotoAndStop(1);
					theMovie["audioJustify_"+i].pressed = false;
				/*
				if (theMovie[myButLetter+i+"_mc"].clicked == 1) {
					theMovie[myButLetter+i+"_mc"].enabled = true;
				}
				if (theMovie[myButLetter+i+"_mc"].clicked == 0) {
					theMovie[myButLetter+i+"_mc"].enabled = true;
				}
				*/
				} else {
					theMovie["i"+i+"_mc"]._visible = true;					
				}	//IF		
			} //for
		} //For (2)
	} // IF 1st
}


function check_answers() {
	if (this.clicked == 0) {
		this.clicked = 1;
		this.gotoAndStop(3);
		for (i=0; i<theMovie.myArray.length; i++) {
			var checkWrong = 0;
			for (m=0; m<myNamesArray.length; m++) {
				myButLetter = myNamesArray[m];
				if (theMovie["check"+i+"_mc"]._currentframe != 3) {
					theMovie[myButLetter+i+"_mc"].enabled = false;
				}
				if (typeof (theRightArray[i]) == "string") {
					if ((theMovie[myButLetter+i+"_mc"]._currentframe == 1) and (theMovie[myButLetter+i+"_mc"].myName == theMovie.theRightArray[i])) {
						//------wrong!
						checkWrong = 1;
						theMovie[myButLetter+i+"_mc"].clicked = 1;
					}
					if ((theMovie[myButLetter+i+"_mc"]._currentframe == 2) and (theMovie[myButLetter+i+"_mc"].myName == theMovie.theRightArray[i])) {
						//------correct!
						theMovie[myButLetter+i+"_mc"].clicked = 2;
					}
					if ((theMovie[myButLetter+i+"_mc"]._currentframe == 2) and (theMovie[myButLetter+i+"_mc"].myName<>theMovie.theRightArray[i])) {
						//------wrong!
						checkWrong = 1;
						theMovie[myButLetter+i+"_mc"].clicked = 2;
					}
				} else {
					var findCorrect = 0;
					for (k=0; k<myNamesArray.length; k++) {
						if ((theMovie[myButLetter+i+"_mc"]._currentframe == 1) and (theMovie[myButLetter+i+"_mc"].myName == theMovie.theRightArray[i][k])) {
							checkWrong = 1;
							theMovie[myButLetter+i+"_mc"].clicked = 1;
						}
						if ((theMovie[myButLetter+i+"_mc"]._currentframe == 2) and (theMovie[myButLetter+i+"_mc"].myName == theMovie.theRightArray[i][k])) {
							findCorrect = 1;
							theMovie[myButLetter+i+"_mc"].clicked = 2;
						}
					}
					if ((theMovie[myButLetter+i+"_mc"]._currentframe == 2) and (findCorrect == 0)) {
						checkWrong = 1;
						theMovie[myButLetter+i+"_mc"].clicked = 2;
					}
				}
			}
			if (theMovie["check"+i+"_mc"]._currentframe == 1) {
				if (checkWrong == 0) {
					theMovie["check"+i+"_mc"].clicked = 1;
					theMovie["check"+i+"_mc"].gotoAndStop(4);
				} else {
					theMovie["check"+i+"_mc"].clicked = 1;
					theMovie["check"+i+"_mc"].gotoAndStop(5);
				}
				theMovie["i"+i+"_mc"]._visible = true;
				// AUDIOScript Justification
				theMovie["audioJustify_"+i]._visible = true;
				theMovie["audioJustify_"+i].gotoAndStop(1);
				theMovie["audioJustify_"+i].pressed = false;
			}
		}
		if (checkWrong == 0) {
			playRightAnswer();
		} else {
			playWrongAnswer();
		}
	} else {
		this.clicked = 0;
		this.gotoAndStop(1);
		for (i=0; i<theMovie.myArray.length; i++) {
			theMovie["i"+i+"_mc"]._visible = false;
			for (m=0; m<myNamesArray.length; m++) {
				myButLetter = myNamesArray[m];
				if (typeof (theRightArray[i]) == "string") {
				} else {
					theMovie[myButLetter+i+"_mc"].enabled = true;
				}
				if (theMovie[myButLetter+i+"_mc"].clicked == 1) {
					theMovie[myButLetter+i+"_mc"].enabled = true;
				}
				if (theMovie[myButLetter+i+"_mc"].clicked == 0) {
					theMovie[myButLetter+i+"_mc"].enabled = true;
				}
				if (theMovie[myButLetter+i+"_mc"].clicked == 2) {
					theMovie[myButLetter+i+"_mc"].clicked = 0;
				}
			}

			if (theMovie["check"+i+"_mc"]._currentframe != 3) {
				theMovie["check"+i+"_mc"].clicked = 0;
				theMovie["check"+i+"_mc"].gotoAndStop(1);
				theMovie["check"+i+"_mc"].enabled = true;
				//---------------------------------------
				theMovie._parent.checkAll_mc.clicked = 0;
				theMovie._parent.checkAll_mc.gotoAndStop(1);
				theMovie._parent.checkAll_mc.enabled = true;
				// AUDIOScript Justification
				theMovie["audioJustify_"+i]._visible = false;
				theMovie["audioJustify_"+i].gotoAndStop(1);
				theMovie["audioJustify_"+i].pressed = false;
			}
		}
	}
}

function checkOneAnswer() {
	var i = this.myNum;
	var checkAll = 0;
	if (this.clicked == 0) {
		this.clicked = 1;
		//this.gotoAndStop(2);
		var checkWrong = 0;
		for (m=0; m<myNamesArray.length; m++) {
			myButLetter = myNamesArray[m];
			theMovie[myButLetter+i+"_mc"].enabled = false;
			if (typeof (theRightArray[i]) == "string") {
				if ((theMovie[myButLetter+i+"_mc"]._currentframe == 1) and (theMovie[myButLetter+i+"_mc"].myName == theMovie.theRightArray[i])) {
					//------wrong!
					checkWrong = 1;
					theMovie[myButLetter+i+"_mc"].clicked = 1;
				}
				if ((theMovie[myButLetter+i+"_mc"]._currentframe == 2) and (theMovie[myButLetter+i+"_mc"].myName == theMovie.theRightArray[i])) {
					//------correct!
					theMovie[myButLetter+i+"_mc"].clicked = 2;
				}
				if ((theMovie[myButLetter+i+"_mc"]._currentframe == 2) and (theMovie[myButLetter+i+"_mc"].myName<>theMovie.theRightArray[i])) {
					//------wrong!
					checkWrong = 1;
					theMovie[myButLetter+i+"_mc"].clicked = 2;
				}
			} else {
				var findCorrect = 0;
				for (k=0; k<myNamesArray.length; k++) {
					if ((theMovie[myButLetter+i+"_mc"]._currentframe == 1) and (theMovie[myButLetter+i+"_mc"].myName == theMovie.theRightArray[i][k])) {
						//------wrong!
						checkWrong = 1;
						theMovie[myButLetter+i+"_mc"].clicked = 1;
					}
					if ((theMovie[myButLetter+i+"_mc"]._currentframe == 2) and (theMovie[myButLetter+i+"_mc"].myName == theMovie.theRightArray[i][k])) {
						findCorrect = 1;
						theMovie[myButLetter+i+"_mc"].clicked = 2;
					}
				}
				if ((theMovie[myButLetter+i+"_mc"]._currentframe == 2) and (findCorrect == 0)) {
					checkWrong = 1;
					theMovie[myButLetter+i+"_mc"].clicked = 2;
				}
			}
		}

		if (checkWrong == 0) {
			playRightAnswer();
			this.gotoAndStop(4);
		} else {
			playWrongAnswer();
			this.gotoAndStop(5);
		}
		theMovie["i"+i+"_mc"]._visible = true;
		var checkAllState = 0
		for (i=0; i<theMovie.myArray.length; i++) {
			if (theMovie["check"+i+"_mc"]._currentframe == 1) {
				checkAllState = 1
			}
		}
		trace("checkAllState " +checkAllState)
		if (checkAllState == 0){
			theMovie._parent.checkAll_mc.clicked = 1;
			theMovie._parent.checkAll_mc.gotoAndStop(3);
			theMovie._parent.checkAll_mc.enabled = true;
		}
		// AUDIOScript Justification
		theMovie["audioJustify_"+this.myNum]._visible = true;
		theMovie["audioJustify_"+this.myNum].gotoAndStop(1);
		theMovie["audioJustify_"+this.myNum].pressed = false;
	} else {
		this.clicked = 0;
		this.gotoAndStop(1);
		//theMovie._parent.checkAll_mc.clicked = 0;
		//theMovie._parent.checkAll_mc.gotoAndStop(1)
		//for (i = 0; i < theMovie.myArray.length; i++) {
		theMovie["i"+i+"_mc"]._visible = false;
		for (m=0; m<myNamesArray.length; m++) {
			myButLetter = myNamesArray[m];
			if (typeof (theRightArray[i]) == "string") {
			} else {
				theMovie[myButLetter+i+"_mc"].enabled = true;
			}
			if (theMovie[myButLetter+i+"_mc"].clicked == 1) {
				theMovie[myButLetter+i+"_mc"].enabled = true;
			}
			if (theMovie[myButLetter+i+"_mc"].clicked == 0) {
				theMovie[myButLetter+i+"_mc"].enabled = true;
			}
			if (theMovie[myButLetter+i+"_mc"].clicked == 2) {
				theMovie[myButLetter+i+"_mc"].clicked = 0;
			}
		}

		trace("checkAllState " +checkAllState)
		theMovie._parent.checkAll_mc.clicked = 0;
		theMovie._parent.checkAll_mc.gotoAndStop(1);
		theMovie._parent.checkAll_mc.enabled = true;
		// AUDIOScript Justification
		theMovie["audioJustify_"+this.myNum]._visible = false;
		theMovie["audioJustify_"+this.myNum].gotoAndStop(1);
		theMovie["audioJustify_"+this.myNum].pressed = false;
		
	}

}
// ------------------------------------------ show text ----------------------------------------------------
function initShowText() {
	theMovie._parent.showText_mc.clicked = 0;
	theMovie._parent.showText_mc.onRelease = showMyText;
	theMovie.text_1_mc._visible = false;
	theMovie.text_1_mc.white_mc.useHandCursor = false;
	theMovie.text_1_mc.white_mc.onPress = function() {
	};
}
//
function showMyText() {
	theTextPointer._parent.InitScrollBar();
	if (this.clicked == 0) {
		this.clicked = 1;
		theMovie._parent.showText_mc.gotoAndPlay(3);
		theMovie.text_1_mc._visible = true;
		for (i=0; i<theMovie.theRightArray.length; i++) {
			theMovie.theTextPointer["justification"+i+"_mc"]._visible = false;
		}
		_root.showXCanvas("ShowText");
	} else {
		this.clicked = 0;
		theMovie._parent.showText_mc.gotoAndPlay(1);
		theMovie.text_1_mc._visible = false;
		for (i=0; i<theMovie.theRightArray.length; i++) {
			theMovie["i"+i+"_mc"].pressed = false;
		}
		_root.hideXCanvas("ShowText");
	}
}

//--------------------------------------------------------------
initTrueFalse(theMovie.theRightArray.length, theMovie.numOfChoices, theMovie.isTrueFalse);
initShowText();
// --------------------------------------------------------- complete -------------------------------------------------------------------------
//MOD:27/6/11 - Init at AS mod - NK

/**************
telitses complete
-----------------
Stin askisi orizoume tis parakatw metavlites:
var complete_array:Array=new Array("blah", "blah blah", "blah");
var numPhrases = complete_array.length;*****μεταφερθηκε εδω... υπαρχει λογος να ειναι στην ασκηση;;;
var unlockCheckAllNo = 3;

to complete_arrays periexei ta keimena twn protasewn
to numPhrases einai o arithmos twn protasewn
to unlockCheckAllNo einai apo poio antikeimeno kai panw na exoume to checkAll

This as also has audio justification on the left side.

++++ A new parameter "completeSingle" if true can hide all before showing single.
**************/

var numberOfPhrases = theMovie.complete_array.length;

if ((theMovie.numPhrases != null) || (theMovie.numPhrases != undefined)){
	numberOfPhrases = theMovie.numPhrases;
} else {
	nothing;
}


function checkPhrases() {
	//this.enabled = false;
	if (this._currentframe == 1) {
		this.gotoAndStop(3);
		for (var i=0; i<numberOfPhrases; i++) {
			theMovie["p"+i+"_mc"].gotoAndStop(2);
			theMovie["p"+i+"_mc"].pressed = true;
			theMovie["phrase"+i+"_mc"].gotoAndStop(2);
			theMovie["phrase"+i+"_mc"].text_txt.text = theMovie["p"+i+"_mc"].myText;
			theMovie["phrase"+i+"_mc"].background_mc._visible = true;	
			// AUDIOScript Justification
			theMovie["audioJustify_"+i]._visible = true;
			theMovie["audioJustify_"+i].gotoAndStop(1);
			theMovie["audioJustify_"+i].pressed = false;
			// ShowText Justification
			theMovie["i"+i+"_mc"]._visible = true;
			theMovie["i"+i+"_mc"].gotoAndStop(1);
			theMovie["i"+i+"_mc"].pressed = false;
		}
	} else {
		this.gotoAndStop(1);
		for (var i=0; i<numberOfPhrases; i++) {
			theMovie["p"+i+"_mc"].gotoAndStop(1);
			theMovie["p"+i+"_mc"].pressed = false;
			theMovie["phrase"+i+"_mc"].gotoAndStop(1);
			theMovie["phrase"+i+"_mc"].text_txt.text = "";
			theMovie["phrase"+i+"_mc"].background_mc._visible = false;	
			// AUDIOScript Justification
			theMovie["audioJustify_"+i]._visible = false;
			theMovie["audioJustify_"+i].gotoAndStop(1);
			theMovie["audioJustify_"+i].pressed = false;
			// ShowText Justification
			theMovie["i"+i+"_mc"]._visible = false;
			theMovie["i"+i+"_mc"].gotoAndStop(1);
			theMovie["i"+i+"_mc"].pressed = false;
		}
	}
}
/*

*/
function showPhrase() {
	if (!this.pressed) {
		if (completeSingle) {
			for (var i=0; i<numberOfPhrases; i++) {
				theMovie["p"+i+"_mc"].gotoAndStop(1);
				theMovie["p"+i+"_mc"].pressed = false;
				theMovie["phrase"+i+"_mc"].gotoAndStop(1);
				theMovie["phrase"+i+"_mc"].text_txt.text = "";
				theMovie["phrase"+i+"_mc"].background_mc._visible = false;	
				// AUDIOScript Justification
				theMovie["audioJustify_"+i]._visible = false;
				theMovie["audioJustify_"+i].gotoAndStop(1);
				theMovie["audioJustify_"+i].pressed = false;
				// ShowText Justification
				theMovie["i"+i+"_mc"]._visible = false;
				theMovie["i"+i+"_mc"].gotoAndStop(1);
				theMovie["i"+i+"_mc"].pressed = false;
			}
		}
		theMovie["phrase"+this.idNumber+"_mc"].gotoAndStop(2);
		theMovie["phrase"+this.idNumber+"_mc"].text_txt.text = this.myText;
		theMovie["phrase"+this.idNumber+"_mc"].background_mc._visible = true;	
		theMovie["p"+this.idNumber+"_mc"].gotoAndStop(2);
		this.pressed = true;
		// AUDIOScript Justification
		theMovie["audioJustify_"+this.idNumber]._visible = true;
		theMovie["audioJustify_"+this.idNumber].gotoAndStop(1);
		theMovie["audioJustify_"+this.idNumber].pressed = false;
		// ShowText Justification
		theMovie["i"+this.idNumber+"_mc"]._visible = true;
		theMovie["i"+this.idNumber+"_mc"].gotoAndStop(1);
		theMovie["i"+this.idNumber+"_mc"].pressed = false;
	} else {
		theMovie["phrase"+this.idNumber+"_mc"].gotoAndStop(1);
		theMovie["p"+this.idNumber+"_mc"].gotoAndStop(1);
		this.pressed = false;
		theMovie["phrase"+this.idNumber+"_mc"].text_txt.text = "";
		theMovie["phrase"+this.idNumber+"_mc"].background_mc._visible = false		
		// AUDIOScript Justification
		theMovie["audioJustify_"+this.idNumber]._visible = false;
		theMovie["audioJustify_"+this.idNumber].gotoAndStop(1);
		theMovie["audioJustify_"+this.idNumber].pressed = false;
		// ShowText Justification
		theMovie["i"+this.idNumber+"_mc"]._visible = false;
		theMovie["i"+this.idNumber+"_mc"].gotoAndStop(1);
		theMovie["i"+this.idNumber+"_mc"].pressed = false;
	}	
	if (theMovie._parent.showAll_mc._currentframe != 2){
		theMovie._parent.showAll_mc.gotoAndStop(1);
		theMovie._parent.showAll_mc.clicked = 0;
	}	
}

function initPhrases() {
	for (var i = 0; i<numberOfPhrases; i++) {
		theMovie["p"+i+"_mc"].idNumber = i;
		theMovie["p"+i+"_mc"].myText = theMovie.complete_array[i];
		theMovie["p"+i+"_mc"].pressed = false;
		theMovie["p"+i+"_mc"].onRelease = showPhrase;
		//
		theMovie["phrase"+i+"_mc"].text_txt.text = "";
		theMovie["phrase"+i+"_mc"].background_mc._visible = false;
		
	}
	//
	/*
	if (numberOfPhrases >= theMovie.unlockCheckAllNo) {
		theMovie.showAll = 1;
		theMovie._parent.showAll_mc.enabled = true;
		theMovie._parent.showAll_mc.gotoAndStop(1);
		theMovie._parent.showAll_mc.onRelease = checkPhrases;
	}
	*/
	
}

initPhrases();
/**************
telitses complete
**************/