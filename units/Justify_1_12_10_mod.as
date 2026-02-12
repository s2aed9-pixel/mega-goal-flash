//MOD:27/6/11 - Init at AS mod - NK


stop();
//justifications
var NumOfJustifies = 0;
//
function wordJustify_onRelease() {
	if (!this.pressed) {
		//debug5.text += " $maxPlaces "+i+": "+theMovie.maxPlaces
		for (i=0; i<NumOfJustifies; i++) {
			if (theMovie.maxPlaces == undefined){
				theMovie["i"+i+"_mc"].pressed = false;
				theTextPointer["justification"+i+"_mc"]._visible = false;
				// Read the array for Scroll steps of Justification
				theTextPointer["justification"+i+"_mc"].mySteps = theMovie.theStepsJustificationArray[i]
				//debug1.text += " $$ Steps "+i+": " + theTextPointer["justification"+i+"_mc"].mySteps
				//debug2.text += " $ "+i+": " + i
			} else {	
				// Read the array for Scroll steps of Justification
				for(j=0; j<theMovie.maxPlaces; j++){
					theMovie["i"+i+""+j+"_mc"].pressed = false;
					theTextPointer["justification"+i+""+j+"_mc"]._visible = false;
					// Read the array for Scroll steps of Justification
					theTextPointer["justification"+i+""+j+"_mc"].mySteps = theMovie.theStepsJustificationArray[i][j]
					// Read the array for Scroll steps of Justification
					//debug3.text += " $$ Steps "+i+j+": " + theTextPointer["justification"+i+""+j+"_mc"].mySteps
					//debug4.text += " $ "+i+j+": " + i +"_"+j
				}
			}
		}
		this.pressed = true;
		//this.gotoAndStop(2);
		if (theMovie.text_1_mc){
			theMovie.text_1_mc._visible = true;
			theTextPointer["justification"+this.myID+"_mc"]._visible = true;
			theMovie._parent.showText_mc.clicked = 1;
			theMovie._parent.showText_mc.gotoAndPlay(3);
			// Move Scrollbar
			theTextPointer._parent.UpdateScrollBar(this.myID)
			//debug5.text += ">>this.myID: "+this.myID
		} else {
			theTextPointer["justification"+this.myID+"_mc"]._visible = true;
		}
		// Move Scrollbar		
	} else {
		this.pressed = false;
		theTextPointer["justification"+this.myID+"_mc"]._visible = false;
		if (theMovie.text_1_mc){
			theMovie._parent.showText_mc.clicked = 0;
			theMovie._parent.showText_mc.gotoAndPlay(1);
		}
	}
}
//
function buttonReleaseOutside() {
	this.gotoAndStop(1);
}
//
function NumOfJustify():Number {
	var xNum = 0;
	for (var m in theMovie){
		if ( (m.substr(0,1) == "i") && (m.substr((m.length -3),3) == "_mc")) {
				trace('key: '+m.substr(0,1)+', value: '+theMovie[m]);
				xNum++;
		}
	}
	return xNum;
}

function initJustify(NumOfJustify:Number) {
	NumOfJustifies = NumOfJustify;
	for (i=0; i<NumOfJustifies; i++) {
		if (theMovie.maxPlaces == undefined){
			theMovie["i"+i+"_mc"].onRelease = wordJustify_onRelease;
			theMovie["i"+i+"_mc"].myNo = i;
			theMovie["i"+i+"_mc"].myID = i;
			theMovie["i"+i+"_mc"].pressed = false;
			theMovie["i"+i+"_mc"]._visible = false;
			//theMovie["info"+i+"_mc"]._visible = false;
			theMovie.theTextPointer["justification"+i+"_mc"]._visible = false;
		} else {
			// Dnd Extra Justify
			for(j=0; j<theMovie.maxPlaces; j++){
				theMovie.theTextPointer["justification"+i+""+j+"_mc"]._visible = false;
				//
				theMovie["i"+i+""+j+"_mc"].onRelease = wordJustify_onRelease;
				theMovie["i"+i+""+j+"_mc"].myNo = i;
				theMovie["i"+i+""+j+"_mc"].myID = i+""+j;	
				theMovie["i"+i+""+j+"_mc"].pressed = false;
				theMovie["i"+i+""+j+"_mc"]._visible = false;
			}
		}
		//
	}
	// INIT SHOW TEXT
	theMovie._parent.showText_mc.clicked = 0;
	theMovie._parent.showText_mc.onRelease = showMyText;
	theMovie.text_1_mc._visible = false;
	theMovie.text_1_mc.white_mc.useHandCursor = false;
	theMovie.text_1_mc.white_mc.onPress = function() {
	};
}
// ------------------------------------------ show text ----------------------------------------------------
//
function showMyText() {
	theTextPointer._parent.InitScrollBar();
	if (this.clicked == 0) {
		this.clicked = 1;
		theMovie._parent.showText_mc.gotoAndPlay(3);
		theMovie.text_1_mc._visible = true;
		for (i=0; i<NumOfJustifies; i++) {
			theMovie.theTextPointer["justification"+i+"_mc"]._visible = false;
			for(j=0; j<theMovie.maxPlaces; j++){
				theMovie.theTextPointer["justification"+i+""+j+"_mc"]._visible = false;
			}
		}
	} else {
		this.clicked = 0;
		theMovie._parent.showText_mc.gotoAndPlay(1);
		theMovie.text_1_mc._visible = false;
		for (i=0; i<NumOfJustifies; i++) {
			theMovie["i"+i+"_mc"].pressed = false;
			for(j=0; j<theMovie.maxPlaces; j++){
				theMovie["i"+i+""+j+"_mc"].pressed = false;
			}
		}
	}
}

//trace("theMovie.maxCategories:"+theMovie.maxCategories);
if ((theMovie.maxCategories == null) || (theMovie.maxCategories == undefined)) {
	initJustify(NumOfJustify());
} else {
	initJustify(theMovie.maxCategories);
}