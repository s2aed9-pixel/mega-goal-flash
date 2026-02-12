//v1.6 23/1/2012 - McGrawHill/MegaGoal
//disable complete/showanswer buttons in the text
//line 129 --//check for complete/showanswer

//v1.5 10/10/2011 - Pearson Version
//V1.1 2/5/2011
//Same concept is applied  as for OnCourse. BUT, we are not registering types of exercises and
//the logic changed a little. When the script runs, it tries to figure out how many check items
//it should remove rather than which type of items, since all exercises have a check button.

/*Not the same as OnCOurse as this does not contain custom code for drag and drop etc exercises.

/ Basic functionality to deactivate and hide check etc buttons
  The script just needs to be included in frame3 of UNITS and the makeEbookContent() function to 
  be called AFTER the loading of each exercise. NOTE: mclListenerExercise_onLoadInit...
*/


//variables that will be used to create the root.Matrix array
var typeI=0;
var Units=theMovie.myUnitsNumExercises.length;
var Lessons=0;
var Exercises=0;

//custom debug function. Use "trace" as a second argument to trace the debug message.
/*function debugMe(debugMessage,method) {
	if (method == "" || method == undefined) {
		if (debug_txt.text == null || debug_txt.text == undefined) {
			this.createTextField("debug_txt",999,0,0,100,100);
			debug_txt.autoSize="left";
			debug_txt.multiline=true;
		}
		debug_txt.text+= debugMessage + "\n";
	} else {
		trace(debugMessage);
	}
}*/


//create an Array that replicates the structure of the App. 
//It does not need to be declared elsewhere
/*if (_root.Matrix.length == undefined) {
	_root.Matrix=new Array  ;
	debugMe("Now creating Matrix","trace");
	for (i=0; i < Units; i++) {
		_root.Matrix[i]=new Array  ;
		debugMe("Making Unit:" + i,"trace");
		Lessons=theMovie.myUnitsNumExercises[i].length;
		for (j=0; j < Lessons; j++) {
			debugMe("Making Lesson:" + j,"trace");
			Exercises=theMovie.myUnitsNumExercises[i][j];
			_root.Matrix[i][j]=new Array  ;
			for (k=0; k < Exercises; k++) {
				debugMe("Making exercise:" + k,"trace");
				type="EXTYPE";//sorType(typeI);
				_root.Matrix[i][j][k]=type;
			}
		}
	}

}*/

/*String.prototype.replace = function(searchStr, replaceStr):String {
    var arr:Array = this.split(searchStr);
    return arr.join(replaceStr);
};*/

/*
function outputAll() {
	//trace("length:" + _root.Matrix.length);
	//trace("unit1:" + _root.Matrix[1].length);
	//trace("lesson1:" + _root.Matrix[1][1].length);
	trace("Unit | Lesson | exercise | is of type | \n");
	for (i=0; i < _root.Matrix.length; i++) {
		Lessons=_root.Matrix[i].length;
		for (j=0; j < Lessons; j++) {
			Exercises=_root.Matrix[i][j].length;
			for (k=0; k < Exercises; k++) {
				//trace(i);
				//trace(j);
				//trace(k);
				trace(i + " | " + j + " | " + k + " | " + _root.Matrix[i][j][k] + "\n");

			}
		}
	}
}*/


function cleanAfterLoad(checkWhat,mcQualifier) {
	for (i=0; i < checkWhat; i++) {
		theMovie.showUnit_mc[mcQualifier + i + "_mc"]._alpha=0;
		theMovie.showUnit_mc[mcQualifier + i + "_mc"].onRelease="";
		theMovie.showUnit_mc[mcQualifier + i + "_mc"].useHandCursor=false;
	}
}


function makeEbookContent() {
	//Try to figure out what type of exercise is it	by searching for variables.
	//However, this is only an indication because even if a variable has been 
	//declared in the script does not mean necessarily that is is used. 
	//So, a pair of variables will be used, to ensure that these items do
	//exist on stage. 
	
	//disable checkbuttons
/*	theMovie.checkAll_mc.enabled = false;
	theMovie.checkAll_mc.useHandCursor = false;
	theMovie.checkAll_mc.gotoAndStop(2);
	
	theMovie.showAll_mc.enabled = false;
	theMovie.showAll_mc.useHandCursor = false;
	theMovie.showAll_mc.gotoAndStop(2);*/
	
	//get rid of right/wrong sound
	theMovie.showUnit_mc.playRightAnswer = function(){};
	theMovie.showUnit_mc.playWrongAnswer = function(){};
	
	
	theMovie.showUnit_mc.theTextPointer.completedAnswers_mc._visible = false;
	theMovie.showUnit_mc.text_1_mc.text_2_mc.text_3_mc.text_4_mc.completedAnswers_mc._visible = false;	
	theMovie.showUnit_mc.text_mc.completedAnswers_mc._visible = false;
	theMovie.showUnit_mc.completedAnswers_mc._visible = false;	
	
	
	
	if ((theMovie.showUnit_mc.words_array.length != null) || (theMovie.showUnit_mc.	words_array != undefined)) {
		cleanAfterLoad(theMovie.showUnit_mc.words_array.length, "p")
	}
	//check for complete/showanswer
	if ((theMovie.showUnit_mc.complete_array.length != null) || (theMovie.showUnit_mc.complete_array.length != undefined)) {
		cleanAfterLoad(theMovie.showUnit_mc.complete_array.length, "p")
		//check for complete/showanswer buttons in the text
		for (i=0; i < theMovie.showUnit_mc.complete_array.length; i++) {
			theMovie.showUnit_mc.text_1_mc.text_2_mc.text_3_mc.text_4_mc["p" + i+ "_mc"]._alpha=0;
			theMovie.showUnit_mc.text_1_mc.text_2_mc.text_3_mc.text_4_mc["p" + i+ "_mc"].onRelease="";
			theMovie.showUnit_mc.text_1_mc.text_2_mc.text_3_mc.text_4_mc["p" + i+ "_mc"].useHandCursor=false;
		}
	}
	//check for match
	if ((theMovie.showUnit_mc.correctID.length != null) || (theMovie.showUnit_mc.correctID.length != undefined)) {
		cleanAfterLoad(theMovie.showUnit_mc.correctID.length, "matchCheck")
	}
	//check for TF/circle
	if ((theMovie.showUnit_mc.theRightArray.length != null) || (theMovie.showUnit_mc.theRightArray.length != undefined)) {
		cleanAfterLoad(theMovie.showUnit_mc.theRightArray.length, "check")
	}	
	//check for popUp
	if ((theMovie.showUnit_mc.popUp_array.length != null) || (theMovie.showUnit_mc.popUp_array.length != undefined)) {
		for (i=0; i < theMovie.showUnit_mc.popCorrect_array.length; i++) {
			theMovie.showUnit_mc["popCheck" + i]._alpha=0;
			theMovie.showUnit_mc["popCheck" + i].onRelease="";
			theMovie.showUnit_mc["popCheck" + i].useHandCursor=false;
		}
	}		
	//check for drag and drop
	if ((theMovie.showUnit_mc.items_array.length != null) || (theMovie.showUnit_mc.items_array.length != undefined)) {
		for (i=0; i < theMovie.showUnit_mc.rightPlaceToUse.length; i++) {
			for (k=0; k<10; k++) {
				theMovie.showUnit_mc["ddCheck" + i + k + "_mc"]._alpha=0;
				theMovie.showUnit_mc["ddCheck" + i + k + "_mc"].onRelease="";
				theMovie.showUnit_mc["ddCheck" + i + k + "_mc"].useHandCursor=false;
			}
		}
	}
	
	//use your english as exercise. UYE must also be deactivated in UNITS frame 2 at
	//mclListenerUseEnglish_onLoadInit
/*	if (theMovie.showUnit_mc.voc_mc._visible == true) {
		for (i=0; i<5; i++) {
			theMovie.showUnit_mc.voc_mc.main_mc["p"+ i + "_mc"]._alpha = 0;
			theMovie.showUnit_mc.voc_mc.main_mc["p"+ i + "_mc"].onRelease = "";
			theMovie.showUnit_mc.voc_mc.main_mc["p"+ i + "_mc"].useHandCursor = false;
		}
	}*/
}