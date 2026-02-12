//MOD:27/6/11 - Init at AS mod - NK

stop();
function initShowText(numOfItems) {
	theMovie._parent.showText_mc.clicked = 0;
	theMovie._parent.showText_mc.onRelease = showMyText;
	theMovie.text_1_mc._visible = false;
	theMovie.text_1_mc.white_mc.useHandCursor = false;
	theMovie.text_1_mc.white_mc.onPress = function() {
	};
	//
	for (i=0; i<numOfItems; i++) {
		theMovie["i"+i+"_mc"].onRelease = i_mc_onRelease;
		theMovie["i"+i+"_mc"].myNo = i;
		theMovie["i"+i+"_mc"].pressed = false;
		//theMovie["i"+i+"_mc"]._visible = false;
		//theMovie["info"+i+"_mc"]._visible = false;
		theMovie.theTextPointer["justification"+i+"_mc"]._visible = false;
	}
	//
}
//
function showMyText() {
	theTextPointer._parent.InitScrollBar();
	if (this.clicked == 0) {
		this.clicked = 1;
		theMovie._parent.showText_mc.gotoAndPlay(3);
		theMovie.text_1_mc._visible = true;
		_root.showXCanvas("ShowText");
		for (i=0; i<theMovie.itemsNum; i++) {
			theMovie.theTextPointer["justification"+i+"_mc"]._visible = false;
		}
	} else {
		this.clicked = 0;
		theMovie._parent.showText_mc.gotoAndPlay(1);
		theMovie.text_1_mc._visible = false;
		_root.hideXCanvas("ShowText");		
		for (i=0; i<theMovie.itemsNum; i++) {
			theMovie["i"+i+"_mc"].pressed = false;
		}
	}
}
//justifications
function i_mc_onRelease() {
	if (!this.pressed) {
		for (i=0; i<theMovie.itemsNum; i++) {
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
		if (theMovie.showText==1)
		{
			theMovie._parent.showText_mc.clicked = 1;
			theMovie._parent.showText_mc.gotoAndPlay(3);
			_root.showXCanvas("ShowText");
		}
		// Move Scrollbar
		theTextPointer._parent.UpdateScrollBar(this.myNo)
		// Move Scrollbar		
	} else {
		this.pressed = false;
		theMovie["info"+this.myNo+"_mc"]._visible = false;
		theTextPointer["justification"+this.myNo+"_mc"]._visible = false;
		if (theMovie.showText==1)
		{
		theMovie._parent.showText_mc.clicked = 0;
		theMovie._parent.showText_mc.gotoAndPlay(1);
		_root.hideXCanvas("ShowText");
		}
	}
}

initShowText();