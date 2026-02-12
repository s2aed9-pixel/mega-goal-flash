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
	if (numberOfPhrases >= theMovie.unlockCheckAllNo) {
		theMovie.showAll = 1;
		theMovie._parent.showAll_mc.enabled = true;
		theMovie._parent.showAll_mc.gotoAndStop(1);
		theMovie._parent.showAll_mc.onRelease = checkPhrases;
	}
	
}

initPhrases();
/**************
telitses complete
**************/