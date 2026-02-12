//MOD:29/6/11 - removed playRight/Wrong answer definition - moved to UNITS
//MOD:27/6/11 - Init at AS mod - NK
/*MOD:10/11/11 - CD
1. Correct and wrong sounds added when global check is pressed.
*/

stop();
var correct = 0;
var lineCounter=0;
var myColour=0x0066CC;
var howManyLines=0;
//
function emptyTexts(numOfItems) {
	for (i=0; i<numOfItems; i++) {
		theMovie["text"+i+"_txt"].autoSize = true;
		theMovie["text"+i+"_txt"].text = ""; 
	}
}
//
function createMatchingClips(numOfItems, myArray, myType, myCorrectArray, myFinalArray) {
	for (i=0; i<theMovie.phrasesToMatch; i++) {
		theMovie["myLine"+i+"_mc"].removeMovieClip();
	}
	theMovie.nextItem_mc.gotoAndStop(2);
	theMovie.nextItem_mc.enabled = false;
	theMovie.nextItem_mc.onRelease = showNextItem;
	//
	for (i=0; i<numOfItems; i++) {
		theMovie["bullet"+i+"_mc"]._x = theMovie["start"+i+"_mc"]._x;
		theMovie["bullet"+i+"_mc"]._y = theMovie["start"+i+"_mc"]._y;
		theMovie["bullet"+i+"_mc"].id = i;
		theMovie["bullet"+i+"_mc"].put = 0;
		//***
		theMovie["bullet"+i+"_mc"].startX = theMovie["bullet"+i+"_mc"]._x;
		theMovie["bullet"+i+"_mc"].startY = theMovie["bullet"+i+"_mc"]._y;
		theMovie["bullet"+i+"_mc"].myDepth = theMovie["bullet"+i+"_mc"].getDepth();
		theMovie["bullet"+i+"_mc"].myLineDepth = (100+i);
		theMovie["bullet"+i+"_mc"].itemsToCheck = numOfItems;
		theMovie["bullet"+i+"_mc"].myText = myArray[i];
		theMovie["bullet"+i+"_mc"].myFinalText = myFinalArray[i];
		theMovie["bullet"+i+"_mc"].myTarget = correctID[i];
		theMovie["bullet"+i+"_mc"].myType = myType;
		theMovie["bullet"+i+"_mc"].currentId=999;
		theMovie["bullet"+i+"_mc"].checkCorrect=0; // 1 = correct , 2 = wrong
		theMovie["bullet"+i+"_mc"].onPress = drag;
		theMovie["bullet"+i+"_mc"].onRelease = checking;
		theMovie["bullet"+i+"_mc"].onReleaseOutside = outside;
		theMovie["bullet"+i+"_mc"].enabled = true;
		theMovie["empty"+i+"_mc"].gotoAndStop(1);//**************8
		theMovie["empty"+i+"_mc"].myTarget = correctID[i];
		theMovie["empty"+i+"_mc"].myNo = i;
		theMovie["empty"+i+"_mc"].currentId=999;
		theMovie["empty"+i+"_mc"].checkCorrect=0; // 1 = correct , 2 = wrong
		if (myType == 1) {
			theMovie["empty"+i+"_mc"].id = correctID[i];
		} else {
			theMovie["empty"+i+"_mc"].id = i;
		}
		theMovie["empty"+i+"_mc"].myText = myCorrectArray[i];
		theMovie["empty"+i+"_mc"].put = 0;
		// 
		theMovie["matchCheck"+i+"_mc"].gotoAndStop(3);
		theMovie["matchCheck"+i+"_mc"].id=i;
		theMovie["matchCheck"+i+"_mc"].clicked=0;
		theMovie["matchCheck"+i+"_mc"].setMeOn=0;
		theMovie["matchCheck"+i+"_mc"].keepMyCurrentFrame=3;
		theMovie["matchCheck"+i+"_mc"].onRelease=showSingleSolution;
		theMovie["matchCheck"+i+"_mc"].enabled=false
		//
	}
	//
	for (i=0; i<theMovie.drags.length; i++) {
		theMovie["bullet"+i+"_mc"].myDrags = theMovie.drags[i];
	}
	//
	theMovie._parent.checkAll_mc.gotoAndStop(1);
	theMovie._parent.checkAll_mc.clicked = 0;
	theMovie._parent.checkAll_mc.onRelease = check_answers_match;
	theMovie._parent.checkAll_mc.enabled = false;
	// *************************************************************
	theMovie._parent.showAll_mc.gotoAndStop(1);
	theMovie._parent.showAll_mc.clicked = 0;
	theMovie._parent.showAll_mc.onRelease = check_answers;
	theMovie._parent.showAll_mc.enabled = true;
	// *************************************************************
	
}
//
function check_answers(){
	var lines = 0;
	if (this.clicked == 0) {
		this.clicked = 1;
		this.gotoAndStop(3);
		theMovie._parent.checkAll_mc.gotoAndStop(2);
		theMovie._parent.checkAll_mc.enabled=false;
		theMovie.nextItem_mc.gotoAndStop(1);
		theMovie.nextItem_mc.enabled = true;
		//debug_txt.text=theMovie.empty1_mc.id[1]
		for (i=0; i<theMovie.phrasesToMatch; i++) {
			if (theMovie["bullet"+i+"_mc"].put == 0) {
				theMovie["bullet"+i+"_mc"].enabled = false;
			}
			theMovie["matchCheck"+i+"_mc"].gotoAndStop(3);
			theMovie["matchCheck"+i+"_mc"].enabled=false;
			// AUDIOScript Justification
			theMovie["audioJustify_"+i]._visible = true;
			theMovie["audioJustify_"+i].gotoAndStop(1);
			theMovie["audioJustify_"+i].pressed = false;			
			// Justification
			theMovie["i"+i+"_mc"]._visible = true;
			theMovie["i"+i+"_mc"].gotoAndStop(1);
			theMovie["i"+i+"_mc"].pressed = false;			
		}
		for (i=0; i<theMovie.phrasesToMatch; i++) {
			var temp=theMovie["empty"+i+"_mc"].id.length;
		    for (j=0; j<temp; j++) {
		         var tempId = theMovie["empty"+i+"_mc"].id[j];
		         theMovie.createEmptyMovieClip("showLine"+lines+"_mc",50000+lines);
		         theMovie["showLine"+lines+"_mc"].lineStyle(2,0x0066CC,100);
		         theMovie["showLine"+lines+"_mc"].moveTo(theMovie["empty"+i+"_mc"]._x,theMovie["empty"+i+"_mc"]._y);
		         theMovie["showLine"+lines+"_mc"].lineTo(theMovie["start"+tempId+"_mc"]._x,theMovie["start"+tempId+"_mc"]._y);
		         lines++;
		     }
			//var tempId = theMovie["empty"+i+"_mc"].myTarget;
			//var tempText = theMovie["bullet"+tempId+"_mc"].myFinalText;
			//theMovie["text"+tempId+"_txt"].text = tempText;			 
		}
		for (i=0; i<100; i++) {
			theMovie["myLine"+i+"_mc"]._alpha=0;
		}		
		
	} else {
		this.clicked = 0;
		this.gotoAndStop(1);
		if (howManyLines<>0){
			theMovie._parent.checkAll_mc.enabled=true;
			//theMovie._parent.checkAll_mc.gotoAndStop(1);
		} 
		theMovie.nextItem_mc.gotoAndStop(2);
		theMovie.nextItem_mc.enabled = false;
		for (i=0; i<theMovie.phrasesToMatch; i++) {
			// AUDIOScript Justification
			theMovie["audioJustify_"+i]._visible = false;
			theMovie["audioJustify_"+i].gotoAndStop(1);
			theMovie["audioJustify_"+i].pressed = false;
			// Justification
			theMovie["i"+i+"_mc"]._visible = false;
			theMovie["i"+i+"_mc"].gotoAndStop(1);
			theMovie["i"+i+"_mc"].pressed = false;			
			if (theMovie["bullet"+i+"_mc"].put == 0) {
				theMovie["bullet"+i+"_mc"].enabled = true;
				var tempId = theMovie["bullet"+i+"_mc"].id;
				theMovie["text"+tempId+"_txt"].text = "";
			}
			
			if (theMovie["matchCheck"+i+"_mc"].setMeOn==1){
				theMovie["matchCheck"+i+"_mc"].enabled=true;
				theMovie["matchCheck"+i+"_mc"].gotoAndStop(theMovie["matchCheck"+i+"_mc"].keepMyCurrentFrame);
			    if ((theMovie["matchCheck"+i+"_mc"].keepMyCurrentFrame==4) or (theMovie["matchCheck"+i+"_mc"].keepMyCurrentFrame==5)){
			// AUDIOScript Justification
			theMovie["audioJustify_"+i]._visible = true;
			theMovie["audioJustify_"+i].gotoAndStop(1);
			theMovie["audioJustify_"+i].pressed = false;
			// Justification
			theMovie["i"+i+"_mc"]._visible = true;
			theMovie["i"+i+"_mc"].gotoAndStop(1);
			theMovie["i"+i+"_mc"].pressed = false;					
				}
			} 
			//theMovie["showLine"+i+"_mc"].removeMovieClip(); 
		}
		var blue=0;
		var red=0;
		var green=0;
	    for (i=0; i<theMovie.phrasesToMatch; i++) {
		   if (theMovie["matchCheck"+i+"_mc"]._currentframe==1){
			   blue=1;
		   }
		   if (theMovie["matchCheck"+i+"_mc"]._currentframe==4){
			   green=1;
		   }	
		   if (theMovie["matchCheck"+i+"_mc"]._currentframe==5){
			   red=1;
			   //theMovie.mytext_txt.text=i;
		   }		   
	    }
	    if ((green==1) or (red==1)){
	    	theMovie._parent.checkAll_mc.gotoAndStop(3);
		}
	    if ((green==0) and (red==0) and (blue==1)){
	    	theMovie._parent.checkAll_mc.gotoAndStop(1);
		}
	    if ((green==0) and (red==0) and (blue==0)){
	    	theMovie._parent.checkAll_mc.gotoAndStop(2);
		}		
		//
		for (i=0; i<100; i++) {
			theMovie["myLine"+i+"_mc"]._alpha=100;
			theMovie["showLine"+i+"_mc"].removeMovieClip();
		}
		//
		if (howManyLines==0){
			for (i=0; i<theMovie.phrasesToMatch; i++) {
			    theMovie["matchCheck"+i+"_mc"].enabled = false;
			    theMovie["matchCheck"+i+"_mc"].gotoAndStop(3);
			    theMovie["matchCheck"+i+"_mc"].keepMyCurrentFrame=3;
			    theMovie["matchCheck"+i+"_mc"].setMeOn=0;
			    theMovie["matchCheck"+i+"_mc"].clicked=0;
			    // AUDIOScript Justification
			    theMovie["audioJustify_"+i]._visible = false;
			    theMovie["audioJustify_"+i].gotoAndStop(1);
			    theMovie["audioJustify_"+i].pressed = false;
				// Justification
			    theMovie["i"+i+"_mc"]._visible = false;
			    theMovie["i"+i+"_mc"].gotoAndStop(1);
			    theMovie["i"+i+"_mc"].pressed = false;					
		   }
		   theMovie._parent.checkAll_mc.gotoAndStop(2);
		}
	}
	
}
//
function check_answers_match() {
	//MOD:10/11/11 
	var checkAllOK = 1;
	
	var lines = 0;
    /*	
	for (i=0; i<100; i++) {
		theMovie["showLine"+i+"_mc"].removeMovieClip();
	}
	*/
	if (this.clicked == 0) {
		this.clicked = 1;
		this.gotoAndStop(3);
		theMovie.nextItem_mc.gotoAndStop(1);
		theMovie.nextItem_mc.enabled = true;
		//debug_txt.text=theMovie.empty1_mc.id[1]
		for (i=0; i<theMovie.phrasesToMatch; i++) {
			//if (theMovie["bullet"+i+"_mc"].put == 0) {
				if (theMovie["matchCheck"+i+"_mc"]._currentframe<>3){
				theMovie["matchCheck"+i+"_mc"].clicked=1;
				var myDraggedId = theMovie["empty"+i+"_mc"].currentId
				theMovie["bullet"+myDraggedId+"_mc"].enabled = false;
				//theMovie["matchCheck"+i+"_mc"].enabled = false;
				/*
				if (theMovie["empty"+i+"_mc"].checkCorrect<>0) {
				   theMovie["matchCheck"+i+"_mc"].gotoAndStop(1);// *********
				}
				*/
				delete theMovie["bullet"+i+"_mc"].onEnterFrame;
	            // AUDIOScript Justification myNo
	            theMovie["audioJustify_"+i]._visible = true;
	            theMovie["audioJustify_"+i].gotoAndStop(1);
	            theMovie["audioJustify_"+i].pressed = false;	
	            // Justification myNo
	            theMovie["i"+i+"_mc"]._visible = true;
	            theMovie["i"+i+"_mc"].gotoAndStop(1);
	            theMovie["i"+i+"_mc"].pressed = false;
	            //				
				}
			//}
		}
		//
		for (i=0; i<theMovie.phrasesToMatch; i++) {
			if (theMovie["empty"+i+"_mc"].checkCorrect<>0){
		         //theMovie.createEmptyMovieClip("showLine"+lines+"_mc",500+lines);
				 if (theMovie["empty"+i+"_mc"].checkCorrect==1){
					 theMovie["matchCheck"+i+"_mc"].gotoAndStop(4);
					 theMovie["matchCheck"+i+"_mc"].keepMyCurrentFrame=4;
		             //theMovie["showLine"+lines+"_mc"].lineStyle(2,0x009900,100);
				 } else {
					 if (theMovie["empty"+i+"_mc"].checkCorrect==2){
						 theMovie["matchCheck"+i+"_mc"].gotoAndStop(5);
						  theMovie["matchCheck"+i+"_mc"].keepMyCurrentFrame=5;
						  //MOD:10/11/11 
							checkAllOK = 0;
						
						// theMovie["showLine"+lines+"_mc"].lineStyle(2,0xCC0000,100);
					 }
				 }
				 var tempId=theMovie["empty"+i+"_mc"].currentId
	             //theMovie["showLine"+lines+"_mc"].moveTo(theMovie["empty"+i+"_mc"]._x,theMovie["empty"+i+"_mc"]._y);
				 //theMovie["showLine"+lines+"_mc"].lineTo(theMovie["start"+tempId+"_mc"]._x, theMovie["start"+tempId+"_mc"]._y);
		         //lines++;
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
		//
	} else {
		this.clicked = 0;
		this.gotoAndStop(1);
		theMovie.nextItem_mc.gotoAndStop(2);
		theMovie.nextItem_mc.enabled = false;
		for (i=0; i<theMovie.phrasesToMatch; i++) {
	        // AUDIOScript Justification myNo
	        theMovie["audioJustify_"+i]._visible = false;
	        theMovie["audioJustify_"+i].gotoAndStop(1);
	        theMovie["audioJustify_"+i].pressed = false;	
	        // Justification myNo
	        theMovie["i"+i+"_mc"]._visible = false;
	        theMovie["i"+i+"_mc"].gotoAndStop(1);
	        theMovie["i"+i+"_mc"].pressed = false;
	        //			
			//if (theMovie["bullet"+i+"_mc"].put == 0) {
				theMovie["bullet"+i+"_mc"].enabled = true;
				if (theMovie["empty"+i+"_mc"].checkCorrect<>0){
				   theMovie["matchCheck"+i+"_mc"].enabled = true;
				   theMovie["matchCheck"+i+"_mc"].gotoAndStop(1);
				   theMovie["matchCheck"+i+"_mc"].keepMyCurrentFrame=1;
				   theMovie["matchCheck"+i+"_mc"].clicked=0;
				}
				//var tempId = theMovie["bullet"+i+"_mc"].id;
				//theMovie["text"+tempId+"_txt"].text = "";
			//}
			//theMovie["showLine"+i+"_mc"].removeMovieClip(); 
		}
		/*
		for (i=0; i<100; i++) {
			theMovie["showLine"+i+"_mc"].removeMovieClip();
		}
		*/
	}
}
//
function showSingleSolution(){
	if (this.clicked==0){
		this.clicked=1;
		this.gotoAndStop(1);
		this.keepMyCurrentFrame=1;
		//theMovie.createEmptyMovieClip("showLine"+this.id+"_mc",5000+this.id);
		if (theMovie["empty"+this.id+"_mc"].checkCorrect==1){
			 theMovie["matchCheck"+this.id+"_mc"].gotoAndStop(4);
			 theMovie["matchCheck"+this.id+"_mc"].keepMyCurrentFrame=4;
			 if (!theMovie.muteSound){playRightAnswer();}
			//theMovie["showLine"+this.id+"_mc"].lineStyle(2,0x009900,100);
		} else {
		   if (theMovie["empty"+this.id+"_mc"].checkCorrect==2){
			   theMovie["matchCheck"+this.id+"_mc"].gotoAndStop(5);
			   theMovie["matchCheck"+this.id+"_mc"].keepMyCurrentFrame=5;
			   if (!theMovie.muteSound){playWrongAnswer();}
			 //theMovie["showLine"+this.id+"_mc"].lineStyle(2,0xCC0000,100);
		  }
	   }
	   // AUDIOScript Justification myNo
	   theMovie["audioJustify_"+this.id]._visible = true;
	   theMovie["audioJustify_"+this.id].gotoAndStop(1);
	   theMovie["audioJustify_"+this.id].pressed = false;	
	   // Justification myNo
	   theMovie["i"+this.id+"_mc"]._visible = true;
	   theMovie["i"+this.id+"_mc"].gotoAndStop(1);
	   theMovie["i"+this.id+"_mc"].pressed = false;
	   //
	   var tempId=theMovie["empty"+this.id+"_mc"].currentId;
	   theMovie["bullet"+tempId+"_mc"].enabled=false;
	   var checkMe=0;
	   for (i=0; i<theMovie.phrasesToMatch; i++) {
		   if (theMovie["matchCheck"+i+"_mc"]._currentframe==1){
			   theMovie["matchCheck"+i+"_mc"].keepMyCurrentFrame=1;
			   checkMe=1;
		   }
	   }
	   if (checkMe==0){
	    	theMovie._parent.checkAll_mc.gotoAndStop(3);
			theMovie._parent.checkAll_mc.clicked = 1;
	   }
	   /*
	   theMovie["showLine"+this.id+"_mc"].moveTo(theMovie["empty"+this.id+"_mc"]._x,theMovie["empty"+this.id+"_mc"]._y);
	   theMovie["showLine"+this.id+"_mc"].lineTo(theMovie["start"+tempId+"_mc"]._x, theMovie["start"+tempId+"_mc"]._y);
	   */
	} else {
		this.clicked=0;
		this.gotoAndStop(1);
		this.keepMyCurrentFrame=1;
		var tempId=theMovie["empty"+this.id+"_mc"].currentId
		theMovie["bullet"+tempId+"_mc"].enabled=true;
	    	theMovie._parent.checkAll_mc.gotoAndStop(1);
			theMovie._parent.checkAll_mc.clicked = 0;
	   // AUDIOScript Justification myNo
	   theMovie["audioJustify_"+this.id]._visible = false;
	   theMovie["audioJustify_"+this.id].gotoAndStop(1);
	   theMovie["audioJustify_"+this.id].pressed = false;	
	   // Justification myNo
	   theMovie["i"+this.id+"_mc"]._visible = false;
	   theMovie["i"+this.id+"_mc"].gotoAndStop(1);
	   theMovie["i"+this.id+"_mc"].pressed = false;
	   //  
     	//theMovie["showLine"+this.id+"_mc"].removeMovieClip();
	}
}
//
function drag() {
	this.swapDepths(1000);
	this.startDrag();
	if (this._x<>this.startX){ 
	howManyLines-=1;
	if (howManyLines<1){
	   theMovie._parent.checkAll_mc.gotoAndStop(2);
	   theMovie._parent.checkAll_mc.enabled=false;
	   howManyLines=0;
	 }	
	}
	if (this.currentId<>999){
		theMovie["empty"+this.currentId+"_mc"].checkCorrect=0
		theMovie["empty"+this.currentId+"_mc"].put=0;
		theMovie["empty"+this.currentId+"_mc"].gotoAndStop(1)
		theMovie["matchCheck"+this.currentId+"_mc"].enabled=false;
		theMovie["matchCheck"+this.currentId+"_mc"].gotoAndStop(3);
		theMovie["matchCheck"+this.currentId+"_mc"].setMeOn=0;//6-10-2011 new
		this.currentId=999;//6-10-2011 new				
		// AUDIOScript Justification
		theMovie["audioJustify_"+this.currentId]._visible = false;
		theMovie["audioJustify_"+this.currentId].gotoAndStop(1);
		theMovie["audioJustify_"+this.currentId].pressed = false;
		//  Justification
		theMovie["i"+this.currentId+"_mc"]._visible = false;
		theMovie["i"+this.currentId+"_mc"].gotoAndStop(1);
		theMovie["i"+this.currentId+"_mc"].pressed = false;			
	}
	this.colour=myColour
	theMovie.createEmptyMovieClip("myLine"+this.id+"_mc", this.myLineDepth);
	theMovie["myLine"+this.id+"_mc"].colour=this.colour;
	theMovie["myLine"+this.id+"_mc"].myAlpha=100;
	theMovie["myLine"+this.id+"_mc"].lineStyle(2, this.colour, 100);
	theMovie["myLine"+this.id+"_mc"].checkCorrect=0;
	theMovie["myLine"+this.id+"_mc"].moveTo(this._x, this._y);
	theMovie["myLine"+this.id+"_mc"].lineTo(theMovie["start"+this.id+"_mc"]._x, theMovie["start"+this.id+"_mc"]._y);
	this.onEnterFrame = drawMe;
}
//
function drawMe() {
	if (theMovie._parent.showAll_mc.clicked==0){
	theMovie.createEmptyMovieClip("myLine"+this.id+"_mc", this.myLineDepth);
	theMovie["myLine"+this.id+"_mc"].lineStyle(2, this.colour, 100);
	theMovie["myLine"+this.id+"_mc"].moveTo(this._x, this._y);
	theMovie["myLine"+this.id+"_mc"].lineTo(theMovie["start"+this.id+"_mc"]._x, theMovie["start"+this.id+"_mc"]._y);
	}
}
//
function checking() { 
	
		
	this.stopDrag();
	this.swapDepths(this.myDepth);
	var hitclip = "none";
	var found = 0;
	for (i=0; i<this.itemsToCheck; i++) {
		if (this.hitTest(theMovie["empty"+i+"_mc"])) {
			hitclip = theMovie["empty"+i+"_mc"];
			for (j=0; j<hitclip.id.length; j++) {
				if (this.id == hitclip.id[j]) {
					found = 1;
				}
			}
			break;
		}
	}
	if (((hitclip<>"none") and (found == 1) and (this.myType == 1)) or ((hitclip<>"none") and (this.myText == hitclip.myText) and (this.myType == 2))) {
			this._x = hitclip._x;
			this._y = hitclip._y;
			this.swapDepths(this.myDepth);
			correct += 1;
			if (hitclip.put==0){
				howManyLines +=1;
				theMovie._parent.checkAll_mc.gotoAndStop(1);
			    theMovie._parent.checkAll_mc.enabled=true;
			    hitclip.put = 1;
				hitclip.currentId=this.id;
			    hitclip.gotoAndPlay(this._currentframe);
				this.currentId=hitclip.myNo;
			    this.myDrags -= 1;
			    lineCounter++;
			    var myNum:Number = this.myLineDepth+100+hitclip.myNo+lineCounter;
				this.checkCorrect=1;
				theMovie["myLine"+this.id+"_mc"].checkCorrect=1;
				hitclip.checkCorrect=1;
				theMovie["matchCheck"+hitclip.myNo+"_mc"].enabled=true;
				theMovie["matchCheck"+hitclip.myNo+"_mc"].setMeOn=1;
				theMovie["matchCheck"+hitclip.myNo+"_mc"].gotoAndStop(1);
				theMovie["matchCheck"+hitclip.myNo+"_mc"].keepMyCurrentFrame=1;
				/*
				// AUDIOScript Justification myNo
				theMovie["audioJustify_"+hitclip.myNo]._visible = true;
				theMovie["audioJustify_"+hitclip.myNo].gotoAndStop(1);
				theMovie["audioJustify_"+hitclip.myNo].pressed = false;				
			    // Justification 
			    theMovie["i"+hitclip.myNo+"_mc"]._visible = true;
			    theMovie["i"+hitclip.myNo+"_mc"].gotoAndStop(1);
			    theMovie["i"+hitclip.myNo+"_mc"].pressed = false;
			    //
				*/
			    if (this.myDrags == 0) {
				   //this.enabled = false;
				   //this.put = 1;
			    } 				
			//playRightAnswer();
			} else {
				 this._x = this.startX;
				 this._y = this.startY;
				 howManyLines-=1;
		         if (howManyLines==0){
			         theMovie._parent.checkAll_mc.gotoAndStop(2);
			         theMovie._parent.checkAll_mc.enabled=false;
					 for (i=0; i<theMovie.phrasesToMatch; i++) {
				         theMovie["matchCheck"+i+"_mc"].enabled = false;
				         theMovie["matchCheck"+i+"_mc"].gotoAndStop(3);
				         theMovie["matchCheck"+i+"_mc"].keepMyCurrentFrame=3;
						 theMovie["matchCheck"+i+"_mc"].setMeOn=0;
				         theMovie["matchCheck"+i+"_mc"].clicked=0;						 
					 }					 
		         }				 
			}
			/*
			if (this.myType == 1) {
				if (correct == this.itemsToCheck) {
					theMovie._parent.checkAll_mc.enabled = false;
					theMovie._parent.checkAll_mc.gotoAndStop(2);
				}
			}
			*/
			//} //else {
			  //	   this._x = this.startX;
			  //     this._y = this.startY;
			//}
		
		if (this.myType == 2) {
			var tempText = this.myFinalText;
			var tempId = hitclip.id;
			theMovie["text"+this.id+"_txt"].text = tempText;
			if (correct == this.itemsToCheck) {
				correct = 0;
				theMovie._parent.checkAll_mc.enabled = false;
				theMovie.nextItem_mc.gotoAndStop(1);
				theMovie.nextItem_mc.enabled = true;
				//theMovie.control_mc.timer = 0;
				//theMovie.control_mc.onEnterFrame = pauseMe;
			}
		}
		
	} else {
		//delete this.onEnterFrame;
		//theMovie["myLine"+this.id+"_mc"].removeMovieClip();
		if (((hitclip<>"none") and (hitclip.put==0) and (this.id<>hitclip.id) and (this.myType == 1)) or ((hitclip<>"none") and (this.myText<>hitclip.myText) and (this.myType == 2))) {
			//this._x = this.startX;
			//this._y = this.startY;
			//theMovie["myLine"+this.id+"_mc"].removeMovieClip();
			hitclip.put = 1;
			this._x = hitclip._x;
			this._y = hitclip._y;
			this.swapDepths(this.myDepth);
			this.checkCorrect=2;
			this.currentId=hitclip.myNo;
			theMovie["myLine"+this.id+"_mc"].checkCorrect=2;
			hitclip.checkCorrect=2;
			hitclip.currentId=this.id;
			theMovie["matchCheck"+hitclip.myNo+"_mc"].enabled=true;
			theMovie["matchCheck"+hitclip.myNo+"_mc"].setMeOn=1; // new
			theMovie["matchCheck"+hitclip.myNo+"_mc"].gotoAndStop(1);
			theMovie["matchCheck"+hitclip.myNo+"_mc"].keepMyCurrentFrame=1;
			howManyLines+=1;
			/*
			// AUDIOScript Justification myNo
			theMovie["audioJustify_"+hitclip.myNo]._visible = true;
			theMovie["audioJustify_"+hitclip.myNo].gotoAndStop(1);
			theMovie["audioJustify_"+hitclip.myNo].pressed = false;				
			// Justification
			theMovie["i"+hitclip.myNo+"_mc"]._visible = true;
			theMovie["i"+hitclip.myNo+"_mc"].gotoAndStop(1);
			theMovie["i"+hitclip.myNo+"_mc"].pressed = false;
			//
			*/
			theMovie._parent.checkAll_mc.gotoAndStop(1);
			theMovie._parent.checkAll_mc.enabled=true;
			//playWrongAnswer();

		} else {
			if ((hitclip == "none") or (hitclip.put==1)){
				this._x = this.startX;
				this._y = this.startY;
				if (hitclip.put==0){
				 howManyLines-=1;
		         if (howManyLines==0){
			         theMovie._parent.checkAll_mc.gotoAndStop(2);
			         theMovie._parent.checkAll_mc.enabled=false;
					 for (i=0; i<theMovie.phrasesToMatch; i++) {
				         theMovie["matchCheck"+i+"_mc"].enabled = false;
				         theMovie["matchCheck"+i+"_mc"].gotoAndStop(3);
				         theMovie["matchCheck"+i+"_mc"].keepMyCurrentFrame=3;
						 theMovie["matchCheck"+i+"_mc"].setMeOn=0;
				         theMovie["matchCheck"+i+"_mc"].clicked=0;						 
					 }
		         }
			  }
			}
		}
	}
	//theMovie.text_txt.text=howManyLines;
}
//
function showNextItem() {
	theMovie.nextFrame();
	for (i=0; i<theMovie.phrasesToMatch; i++) {
		theMovie["myLine"+i+"_mc"].removeMovieClip();
		theMovie["showLine"+i+"_mc"].removeMovieClip();
	}
	if (theMovie._totalframes>theMovie._currentframe) {
		theMovie._parent.checkAll_mc.enabled = true;
	} else {
		theMovie._parent.checkAll_mc.gotoAndStop(2);
		theMovie._parent.checkAll_mc.enabled = false;
	}
}
//
function outside() {
	this.stopDrag();
	this._x = this.startX;
	this._y = this.startY;
}
//

//init from exercise
emptyTexts(theMovie.phrasesToMatch);
createMatchingClips(theMovie.phrasesToMatch,theMovie.myArray,1);