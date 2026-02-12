//Crude modification of TF to work as circle/underline. Can include the no-option-selected option...
//MOD:29/6/11 - removed playRight/Wrong answer definition - moved to UNITS
//MOD:27/6/11 - Init at AS mod - NK

stop();
//justifications
/*

*/

circleRightFrame = 4;
underlineRightFrame = 7;


function i_mc_onRelease() {
	if (! this.pressed) {
		for (i=0; i<theMovie.theRightArray.length; i++) {
			theMovie["i"+i+"_mc"].pressed=false;
			theMovie["info"+i+"_mc"]._visible=false;
			theTextPointer["justification"+i+"_mc"]._visible=false;
			// Read the array for Scroll steps of Justification
			theTextPointer["justification"+i+"_mc"].mySteps=theMovie.theStepsJustificationArray[i];
			// Read the array for Scroll steps of Justification
		}
		this.pressed=true;
		//this.gotoAndStop(2);
		theMovie["info"+this.myNo+"_mc"]._visible=true;
		theMovie.text_1_mc._visible=true;
		theTextPointer["justification"+this.myNo+"_mc"]._visible=true;
		theMovie._parent.showText_mc.clicked=1;
		theMovie._parent.showText_mc.gotoAndPlay(3);
		// Move Scrollbar
		theTextPointer._parent.UpdateScrollBar(this.myNo);
		// Move Scrollbar
	} else {
		this.pressed=false;
		theMovie["info"+this.myNo+"_mc"]._visible=false;
		theTextPointer["justification"+this.myNo+"_mc"]._visible=false;
		theMovie._parent.showText_mc.clicked=0;
		theMovie._parent.showText_mc.gotoAndPlay(1);
	}
}
//
function buttonReleaseOutside() {
	this.gotoAndStop(1);
}
//
function buttonRelease() {
	for (i=0; i<this.myItems; i++) {
		myButLetter="cu";
		if (theMovie[myButLetter+i+"_mc"].myNo==this.myNo&&theMovie[myButLetter+i+"_mc"]._name!=this._name) {
			if (typeof theRightArray[this.myNo]=="string") {
				theMovie[myButLetter+i+"_mc"].gotoAndStop(1);
				theMovie[myButLetter+i+"_mc"].enabled=true;
			}
		}
	}
	if (this._currentframe==1) {
		this.gotoAndStop(2);
		if (typeof theRightArray[this.myNo]=="string") {
			theMovie.myArray[this.myNo]=this.myName;
//			this.enabled=false;
		} else {
			theMovie.myArray[this.myNo][m]=this.myName;
		}
		this.gotoAndStop(2);
	} else if (this._currentframe == 2) {
		this.gotoAndStop(5);
	} else if (this._currentframe ==  5){
		this.gotoAndStop(2);
	} else {
		if (typeof theRightArray[this.myNo]=="string") {
			//theMovie.myArray[this.myNo] = 0;
		} else {
			this.gotoAndStop(1);
			theMovie.myArray[this.myNo][m]=0;
		}
	}

	var checkDownButton=0;
	theMovie._parent.checkAll_mc.clicked=1;
	theMovie._parent.checkAll_mc.gotoAndStop(2);
	theMovie._parent.checkAll_mc.enabled=false;
	for (i=0; i<this.myItems; i++) {
		myButLetter="cu";
		if (theMovie[myButLetter+i+"_mc"]._currentframe!=1) {
			checkDownButton=1;
		}
	}
	if (checkDownButton==0) {
		theMovie["check"+this.myNo+"_mc"].clicked=1;
		theMovie["check"+this.myNo+"_mc"].gotoAndStop(3);
		theMovie["check"+this.myNo+"_mc"].enabled=false;
	} else {
		theMovie["check"+this.myNo+"_mc"].clicked=0;
		theMovie["check"+this.myNo+"_mc"].gotoAndStop(1);
		theMovie["check"+this.myNo+"_mc"].enabled=true;
		theMovie._parent.checkAll_mc.clicked=0;
		theMovie._parent.checkAll_mc.gotoAndStop(1);
		theMovie._parent.checkAll_mc.enabled=true;
	}
}
//
function buttonPress() {
	//this.gotoAndStop(2);
}
//

function convertTextToFrameNumber(theData):String {
	var theFrameCorrect;
	if (theData.toLowerCase()=="c") {
		theFrameCorrect="2";
	} else if (theData.toLowerCase()=="u") {
		theFrameCorrect="5";
	} else {
		theFrameCorrect="1";
		trace("Check Your Array Items. Only c, u as data (and maybe \"\")");
	}
	return theFrameCorrect;
}

function initCircleUnderline(theRightArrayCopy,numOfItems) {
	for (i=0; i<numOfItems; i++) {
		myButLetter="cu";
		theMovie[myButLetter+i+"_mc"].gotoAndStop(1);
		theMovie[myButLetter+i+"_mc"].onRelease=buttonRelease;
		theMovie[myButLetter+i+"_mc"].clicked=0;
		theMovie[myButLetter+i+"_mc"].myNo=i;
		theMovie[myButLetter+i+"_mc"].myItems=numOfItems;
		theMovie[myButLetter+i+"_mc"].myName=myButLetter;
		theMovie[myButLetter+i+"_mc"].myState=0;//------for showAll
		theMovie[myButLetter+i+"_mc"].myCorrectAnswer=convertTextToFrameNumber(theRightArrayCopy[i]);
//		trace("test:" + theRightArrayCopy[i]);
//		trace("corect answer for " + myButLetter+ i + " : " + theMovie[myButLetter+i+"_mc"].myCorrectAnswer);
		//---------------------------
		theMovie["check"+i+"_mc"].myNum=i;
		theMovie["check"+i+"_mc"].clicked=0;
		theMovie["check"+i+"_mc"].gotoAndStop(3);
		theMovie["check"+i+"_mc"].enabled=false;
		theMovie["check"+i+"_mc"].onRelease=checkOneAnswer;
		//----------------------------
		theMovie["i"+i+"_mc"].onRelease=i_mc_onRelease;
		theMovie["i"+i+"_mc"].myNo=i;
		theMovie["i"+i+"_mc"].pressed=false;
		theMovie["i"+i+"_mc"]._visible=false;
		theMovie["info"+i+"_mc"]._visible=false;
		theMovie.theTextPointer["justification"+i+"_mc"]._visible=false;
	}
	//
	theMovie._parent.checkAll_mc.gotoAndStop(2);
	theMovie._parent.checkAll_mc.enabled=false;
	theMovie._parent.checkAll_mc.clicked=0;
	theMovie._parent.checkAll_mc.onRelease=check_answers;
	//
	theMovie._parent.showAll_mc.gotoAndStop(1);
	theMovie._parent.showAll_mc.enabled=true;
	theMovie._parent.showAll_mc.clicked=0;
	theMovie._parent.showAll_mc.onRelease=showAll_answers;
}

function showAll_answers() {

	if (this.clicked==0) {
		this.clicked=1;
		this.gotoAndStop(3);
		theMovie._parent.checkAll_mc.myRightFrame=theMovie._parent.checkAll_mc._currentframe;
		theMovie._parent.checkAll_mc.enabled=false;
		theMovie._parent.checkAll_mc.gotoAndStop(2);
		//---------------------------
		for (i=0; i<theMovie.myArray.length; i++) {
			myButLetter="cu";
			theMovie[myButLetter+i+"_mc"].myState=0;
			theMovie[myButLetter+i+"_mc"].enabled=false;
			theMovie["i"+i+"_mc"]._visible=true;
			
			theMovie[myButLetter+i+"_mc"].beforeShowAllFrame = theMovie[myButLetter+i+"_mc"]._currentframe;
			if (theMovie.theRightArray[i] == "c"){
					theMovie[myButLetter+i+"_mc"].gotoAndStop(circleRightFrame);
			} else if (theMovie.theRightArray[i] == "u"){
					theMovie[myButLetter+i+"_mc"].gotoAndStop(underlineRightFrame);
			} else  {
					theMovie[myButLetter+i+"_mc"].gotoAndStop(1);
			}

			/*
			if (typeof theRightArray[i]=="string") {
				if (theMovie[myButLetter+i+"_mc"]._currentframe==1&&theMovie[myButLetter+i+"_mc"].myName==theMovie.theRightArray[i]) {
					trace("1");
					theMovie[myButLetter+i+"_mc"].myState=0;
					theMovie[myButLetter+i+"_mc"].gotoAndStop(4);
				}
				if (theMovie[myButLetter+i+"_mc"]._currentframe==2&&theMovie[myButLetter+i+"_mc"].myName==theMovie.theRightArray[i]) {
					trace("2");
					theMovie[myButLetter+i+"_mc"].myState=1;
					theMovie[myButLetter+i+"_mc"].gotoAndStop(4);
				}
				if (theMovie[myButLetter+i+"_mc"]._currentframe==2&&theMovie[myButLetter+i+"_mc"].myName!=theMovie.theRightArray[i]) {
					trace("3");
					theMovie[myButLetter+i+"_mc"].myState=1;
					theMovie[myButLetter+i+"_mc"].gotoAndStop(1);
				}
			} else {
				var clickedWrongSingle=0;
				if (theMovie[myButLetter+i+"_mc"]._currentframe==1&&theMovie[myButLetter+i+"_mc"].myName==theMovie.theRightArray[i][k]) {
					trace("4");
					theMovie[myButLetter+i+"_mc"].myState=0;
					theMovie[myButLetter+i+"_mc"].gotoAndStop(4);
				}
				if (theMovie[myButLetter+i+"_mc"]._currentframe==2&&theMovie[myButLetter+i+"_mc"].myName==theMovie.theRightArray[i][k]) {
					trace("5");
					clickedWrongSingle=1;
					theMovie[myButLetter+i+"_mc"].myState=1;
					theMovie[myButLetter+i+"_mc"].gotoAndStop(4);
				}
				if (theMovie[myButLetter+i+"_mc"]._currentframe==2&&clickedWrongSingle==0) {
					trace("5");
					theMovie[myButLetter+i+"_mc"].myState=1;
					theMovie[myButLetter+i+"_mc"].gotoAndStop(1);
				}
			}*/
			theMovie["check"+i+"_mc"].myRightFrame=theMovie["check"+i+"_mc"]._currentframe;
			theMovie["check"+i+"_mc"].enabled=false;
			theMovie["check"+i+"_mc"].gotoAndStop(3);
			// AUDIOScript Justification
			theMovie["audioJustify_"+i]._visible=true;
			theMovie["audioJustify_"+i].gotoAndStop(1);
			theMovie["audioJustify_"+i].pressed=false;
		}
	} else {
		this.clicked=0;
		this.gotoAndStop(1);
		//--------------
		theMovie._parent.checkAll_mc.gotoAndStop(theMovie._parent.checkAll_mc.myRightFrame);
		if (theMovie._parent.checkAll_mc._currentframe!=2) {
			theMovie._parent.checkAll_mc.enabled=true;
		}
		//--------------
		for (i=0; i<theMovie.myArray.length; i++) {
			//theMovie["i" + i + "_mc"]._visible = false;
			theMovie["check"+i+"_mc"].gotoAndStop(theMovie["check"+i+"_mc"].myRightFrame);
			if (theMovie["check"+i+"_mc"]._currentframe!=3) {
				theMovie["check"+i+"_mc"].enabled=true;
			}

			theMovie["i"+i+"_mc"]._visible=false;


/*			myButLetter="cu";
			if (theMovie[myButLetter+i+"_mc"].myState==1) {
				theMovie[myButLetter+i+"_mc"].gotoAndStop(2);
			} else {
				theMovie[myButLetter+i+"_mc"].gotoAndStop(1);
			}*/
			theMovie[myButLetter+i+"_mc"].gotoAndStop(theMovie[myButLetter+i+"_mc"].beforeShowAllFrame);

			if (theMovie["check"+i+"_mc"]._currentframe!=4&&theMovie["check"+i+"_mc"]._currentframe!=5) {
				if (typeof theRightArray[i]=="string") {
				} else {
					theMovie[myButLetter+i+"_mc"].enabled=true;
				}
				if (theMovie[myButLetter+i+"_mc"].myState==0) {
					theMovie[myButLetter+i+"_mc"].enabled=true;
				}
				// AUDIOScript Justification
				theMovie["audioJustify_"+i]._visible=false;
				theMovie["audioJustify_"+i].gotoAndStop(1);
				theMovie["audioJustify_"+i].pressed=false;
				/*
				if (theMovie[myButLetter+i+"_mc"].clicked == 1) {
				theMovie[myButLetter+i+"_mc"].enabled = true;
				}
				if (theMovie[myButLetter+i+"_mc"].clicked == 0) {
				theMovie[myButLetter+i+"_mc"].enabled = true;
				}
				*/
			} else {
				theMovie["i"+i+"_mc"]._visible=true;
			}//IF
		}//for
	}// IF 1st
}


function check_answers() {
	if (this.clicked==0) {
		this.clicked=1;
		this.gotoAndStop(3);
		for (i=0; i<theMovie.myArray.length; i++) {
			var checkWrong=0;
			myButLetter="cu";
			if (theMovie["check"+i+"_mc"]._currentframe!=3) {
				theMovie[myButLetter+i+"_mc"].enabled=false;
			}
			
			
			/*if (typeof theRightArray[i]=="string") {
				if (theMovie[myButLetter+i+"_mc"]._currentframe==1&&theMovie[myButLetter+i+"_mc"].myName==theMovie.theRightArray[i]) {
					//------wrong!
					checkWrong=1;
					theMovie[myButLetter+i+"_mc"].clicked=1;
				}
				if (theMovie[myButLetter+i+"_mc"]._currentframe==2&&theMovie[myButLetter+i+"_mc"].myName==theMovie.theRightArray[i]) {
					//------correct!
					theMovie[myButLetter+i+"_mc"].clicked=2;
				}
				if (theMovie[myButLetter+i+"_mc"]._currentframe==2&&theMovie[myButLetter+i+"_mc"].myName!=theMovie.theRightArray[i]) {
					//------wrong!
					checkWrong=1;
					theMovie[myButLetter+i+"_mc"].clicked=2;
				}
			} else {
				var findCorrect=0;
				if (theMovie[myButLetter+i+"_mc"]._currentframe==1&&theMovie[myButLetter+i+"_mc"].myName==theMovie.theRightArray[i][k]) {
					checkWrong=1;
					theMovie[myButLetter+i+"_mc"].clicked=1;
				}
				if (theMovie[myButLetter+i+"_mc"]._currentframe==2&&theMovie[myButLetter+i+"_mc"].myName==theMovie.theRightArray[i][k]) {
					findCorrect=1;
					theMovie[myButLetter+i+"_mc"].clicked=2;
				}
				if (theMovie[myButLetter+i+"_mc"]._currentframe==2&&findCorrect==0) {
					checkWrong=1;
					theMovie[myButLetter+i+"_mc"].clicked=2;
				}
			}*/
		if (typeof theRightArray[i]=="string") {
			
			if (theMovie[myButLetter+i+"_mc"]._currentframe==1) { 	//if there is no selection(frame1) made, 
																	//and there is no data, consider as correct. 
																	//maybe redundant
				if (theMovie.theRightArray[i] == "") {
					//correct;
				}else if (theMovie.theRightArray[i] == "c"){
					//------wrong!
					checkWrong=1;
				} else if (theMovie.theRightArray[i] == "u"){
					//------wrong!
					checkWrong=1;					
				}
				theMovie[myButLetter+i+"_mc"].clicked=1;
			} else if (theMovie[myButLetter+i+"_mc"]._currentframe==2) { 	//same here. If it should be circled, left
																			//blank or underlined will give an error
				if (theMovie.theRightArray[i] == "") {
					//------wrong!
					checkWrong=1;
				}else if (theMovie.theRightArray[i] == "c"){
					//correct;
				} else if (theMovie.theRightArray[i] == "u"){
					//------wrong!
					checkWrong=1;		
				}
				theMovie[myButLetter+i+"_mc"].clicked=2;
			} else if (theMovie[myButLetter+i+"_mc"]._currentframe==5) { 	//same here. If it should be underlined, left
																			//blank or circled will give an error
				if (theMovie.theRightArray[i] == "") {
					//------wrong!
					checkWrong=1;
				}else if (theMovie.theRightArray[i] == "c"){
					//------wrong!
					checkWrong=1;
				} else if (theMovie.theRightArray[i] == "u"){
						//correct;
				}
				theMovie[myButLetter+i+"_mc"].clicked=5;
			}//end of long list of ifsssss...
		}	 else {
				var findCorrect=0;
				if (theMovie[myButLetter+i+"_mc"]._currentframe==1&&theMovie[myButLetter+i+"_mc"].myName==theMovie.theRightArray[i][k]) {
					checkWrong=1;
					theMovie[myButLetter+i+"_mc"].clicked=1;
				}
				if (theMovie[myButLetter+i+"_mc"]._currentframe==2&&theMovie[myButLetter+i+"_mc"].myName==theMovie.theRightArray[i][k]) {
					findCorrect=1;
					theMovie[myButLetter+i+"_mc"].clicked=2;
				}
				if (theMovie[myButLetter+i+"_mc"]._currentframe==2&&findCorrect==0) {
					checkWrong=1;
					theMovie[myButLetter+i+"_mc"].clicked=2;
				}
		}
			if (theMovie["check"+i+"_mc"]._currentframe==1) {
				if (checkWrong==0) {
					theMovie["check"+i+"_mc"].clicked=1;
					theMovie["check"+i+"_mc"].gotoAndStop(4);
				} else {
					theMovie["check"+i+"_mc"].clicked=1;
					theMovie["check"+i+"_mc"].gotoAndStop(5);
				}
				theMovie["i"+i+"_mc"]._visible=true;
				// AUDIOScript Justification
				theMovie["audioJustify_"+i]._visible=true;
				theMovie["audioJustify_"+i].gotoAndStop(1);
				theMovie["audioJustify_"+i].pressed=false;
			}
		}
	} else {
		this.clicked=0;
		this.gotoAndStop(1);
		for (i=0; i<theMovie.myArray.length; i++) {
			theMovie["i"+i+"_mc"]._visible=false;
			myButLetter="cu";
			theMovie[myButLetter+i+"_mc"].enabled=true;
			if (theMovie[myButLetter+i+"_mc"].clicked==1) {
				theMovie[myButLetter+i+"_mc"].enabled=true;
			}
			if (theMovie[myButLetter+i+"_mc"].clicked==0) {
				theMovie[myButLetter+i+"_mc"].enabled=true;
			}
			if (theMovie[myButLetter+i+"_mc"].clicked==2) {
				theMovie[myButLetter+i+"_mc"].clicked=0;
			}
		
			if (theMovie["check"+i+"_mc"]._currentframe!=3) {
				theMovie["check"+i+"_mc"].clicked=0;
				theMovie["check"+i+"_mc"].gotoAndStop(1);
				theMovie["check"+i+"_mc"].enabled=true;
				//---------------------------------------
				theMovie._parent.checkAll_mc.clicked=0;
				theMovie._parent.checkAll_mc.gotoAndStop(1);
				theMovie._parent.checkAll_mc.enabled=true;
				// AUDIOScript Justification
				theMovie["audioJustify_"+i]._visible=false;
				theMovie["audioJustify_"+i].gotoAndStop(1);
				theMovie["audioJustify_"+i].pressed=false;
			}
		}
	}
}

function checkIfWrong(itemRef, correctData):String{
	var retValue;
	if (itemRef.myCorrectAnswer != correctData){
		retValue = 1;
	} else {
		retValue = 0
	}
	return retValue;
}


function checkOneAnswer() {
	var i=this.myNum;
	var checkAll=0;
	
	trace("checkOneAnswer---");
	trace("i(also myNum):" + i);
	trace("this.clicked:" + this.clicked); 
	trace("which item:"+ theMovie[myButLetter+i+"_mc"]);
	trace("this items name:"+theMovie[myButLetter+i+"_mc"].myName);
	trace("theMovie.theRightArray[i]:"+theMovie.theRightArray[i]);
	trace("theMovie.theRightArray[i][k]:"+theMovie.theRightArray[i][k]);	
	if (this.clicked==0) {
		this.clicked=1;
		//this.gotoAndStop(2);
		var checkWrong=0;
		myButLetter="cu";
		theMovie[myButLetter+i+"_mc"].enabled=false;
		if (typeof theRightArray[i]=="string") {
			
			if (theMovie[myButLetter+i+"_mc"]._currentframe==1) { 	//if there is no selection(frame1) made, 
																	//and there is no data, consider as correct. 
																	//maybe redundant
				if (theMovie.theRightArray[i] == "") {
					//correct;
				}else if (theMovie.theRightArray[i] == "c"){
					//------wrong!
					checkWrong=1;
				} else if (theMovie.theRightArray[i] == "u"){
					//------wrong!
					checkWrong=1;					
				}
				theMovie[myButLetter+i+"_mc"].clicked=1;
			} else if (theMovie[myButLetter+i+"_mc"]._currentframe==2) { 	//same here. If it should be circled, left
																			//blank or underlined will give an error
				if (theMovie.theRightArray[i] == "") {
					//------wrong!
					checkWrong=1;
				}else if (theMovie.theRightArray[i] == "c"){
					//correct;
				} else if (theMovie.theRightArray[i] == "u"){
					//------wrong!
					checkWrong=1;		
				}
				theMovie[myButLetter+i+"_mc"].clicked=2;
			} else if (theMovie[myButLetter+i+"_mc"]._currentframe==5) { 	//same here. If it should be underlined, left
																			//blank or circled will give an error
				if (theMovie.theRightArray[i] == "") {
					//------wrong!
					checkWrong=1;
				}else if (theMovie.theRightArray[i] == "c"){
					//------wrong!
					checkWrong=1;
				} else if (theMovie.theRightArray[i] == "u"){
						//correct;
				}
				theMovie[myButLetter+i+"_mc"].clicked=5;
			}//end of long list of ifsssss...
			
			
/*			if (theMovie[myButLetter+i+"_mc"]._currentframe==1&&theMovie[myButLetter+i+"_mc"].myName==theMovie.theRightArray[i]) {
				//------wrong!
				checkWrong=1;
				theMovie[myButLetter+i+"_mc"].clicked=1;
			}
			if (theMovie[myButLetter+i+"_mc"]._currentframe==2&&theMovie[myButLetter+i+"_mc"].myName==theMovie.theRightArray[i]) {
				//------correct!
				theMovie[myButLetter+i+"_mc"].clicked=2;
			}
			if (theMovie[myButLetter+i+"_mc"]._currentframe==2&&theMovie[myButLetter+i+"_mc"].myName!=theMovie.theRightArray[i]) {
				//------wrong!
				checkWrong=1;
				theMovie[myButLetter+i+"_mc"].clicked=2;
			}
			checkWrong = checkIfWrong(theMovie[myButLetter+i+"_mc"], theMovie.theRightArray[i]);*/
			trace("User said: " + theMovie[myButLetter+i+"_mc"]._currentframe);
			trace("answer is: " + theMovie.theRightArray[i]);
			trace("checkWrong:"+checkWrong);
		} else {
			var findCorrect=0;
			if (theMovie[myButLetter+i+"_mc"]._currentframe==1&&theMovie[myButLetter+i+"_mc"].myName==theMovie.theRightArray[i][k]) {
				//------wrong!
				checkWrong=1;
				theMovie[myButLetter+i+"_mc"].clicked=1;
			}
			if (theMovie[myButLetter+i+"_mc"]._currentframe==2&&theMovie[myButLetter+i+"_mc"].myName==theMovie.theRightArray[i][k]) {
				findCorrect=1;
				theMovie[myButLetter+i+"_mc"].clicked=2;
			}
			if (theMovie[myButLetter+i+"_mc"]._currentframe==2&&findCorrect==0) {
				checkWrong=1;
				theMovie[myButLetter+i+"_mc"].clicked=2;
			}
		}

		if (checkWrong==0) {
			playRightAnswer();
			this.gotoAndStop(4);
		} else {
			playWrongAnswer();
			this.gotoAndStop(5);
		}
		theMovie["i"+i+"_mc"]._visible=true;
		var checkAllState=0;
		for (i=0; i<theMovie.myArray.length; i++) {
			if (theMovie["check"+i+"_mc"]._currentframe==1) {
				checkAllState=1;
			}
		}
		trace("checkAllState "+checkAllState);
		if (checkAllState==0) {
			theMovie._parent.checkAll_mc.clicked=1;
			theMovie._parent.checkAll_mc.gotoAndStop(3);
			theMovie._parent.checkAll_mc.enabled=true;
		}
		// AUDIOScript Justification
		theMovie["audioJustify_"+this.myNum]._visible=true;
		theMovie["audioJustify_"+this.myNum].gotoAndStop(1);
		theMovie["audioJustify_"+this.myNum].pressed=false;
	} else {
		this.clicked=0;
		this.gotoAndStop(1);
		theMovie[myButLetter+i+"_mc"].enabled=true;
		//theMovie._parent.checkAll_mc.clicked = 0;
		//theMovie._parent.checkAll_mc.gotoAndStop(1)
		//for (i = 0; i < theMovie.myArray.length; i++) {
		theMovie["i"+i+"_mc"]._visible=false;
		myButLetter="cu";
		if (typeof theRightArray[i]=="string") {
		} else {
			theMovie[myButLetter+i+"_mc"].enabled=true;
		}
		if (theMovie[myButLetter+i+"_mc"].clicked==1) {
			theMovie[myButLetter+i+"_mc"].enabled=true;
		}
		if (theMovie[myButLetter+i+"_mc"].clicked==0) {
			theMovie[myButLetter+i+"_mc"].enabled=true;
		}
		if (theMovie[myButLetter+i+"_mc"].clicked==2) {
			theMovie[myButLetter+i+"_mc"].clicked=0;
		}

		trace("checkAllState "+checkAllState);
		theMovie._parent.checkAll_mc.clicked=0;
		theMovie._parent.checkAll_mc.gotoAndStop(1);
		theMovie._parent.checkAll_mc.enabled=true;
		// AUDIOScript Justification
		theMovie["audioJustify_"+this.myNum]._visible=false;
		theMovie["audioJustify_"+this.myNum].gotoAndStop(1);
		theMovie["audioJustify_"+this.myNum].pressed=false;

	}

}
// ------------------------------------------ show text ----------------------------------------------------
function initShowText() {
	theMovie._parent.showText_mc.clicked=0;
	theMovie._parent.showText_mc.onRelease=showMyText;
	theMovie.text_1_mc._visible=false;
	theMovie.text_1_mc.white_mc.useHandCursor=false;
	theMovie.text_1_mc.white_mc.onPress=function() {
	};
}
//
function showMyText() {
	theTextPointer._parent.InitScrollBar();
	if (this.clicked==0) {
		this.clicked=1;
		theMovie._parent.showText_mc.gotoAndPlay(3);
		theMovie.text_1_mc._visible=true;
		for (i=0; i<theMovie.theRightArray.length; i++) {
			theMovie.theTextPointer["justification"+i+"_mc"]._visible=false;
		}
	} else {
		this.clicked=0;
		theMovie._parent.showText_mc.gotoAndPlay(1);
		theMovie.text_1_mc._visible=false;
		for (i=0; i<theMovie.theRightArray.length; i++) {
			theMovie["i"+i+"_mc"].pressed=false;
		}
	}
}

//--------------------------------------------------------------

initCircleUnderline(theMovie.theRightArray,theMovie.theRightArray.length);//, theMovie.numOfChoices, theMovie.isTrueFalse);
initShowText();