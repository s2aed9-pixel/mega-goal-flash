var interval;
var intervalSec:Number;
var transSec:Number;
var pauseMe:Number;
var myNo:Number;


function startInterval(IntervalSec:Number, TransSec:Number){
	intervalSec = IntervalSec;
	transSec = TransSec;
	pauseMe  = 1000 * intervalSec;
	
	for (i=0; i<10; i++){
		theMovie.showUnit_mc["pic"+i+"_mc"]._visible = false;
	}
	
	//
	myNo = 0;
	if (interval){
		clearInterval(interval);
		theMovie.showUnit_mc.debux.text = " Interval exist  "
	}
	startTransition();
	interval = setInterval(startTransition, pauseMe);
	theMovie.showUnit_mc.debux.text += " startInterval "
}

function startTransition(){
	if (theMovie.showUnit_mc["pic"+myNo+"_mc"]){
		setTransition(theMovie.showUnit_mc["pic"+myNo+"_mc"], 0, transSec, "Random", "Strong", 0);
		
		theMovie.showUnit_mc.debux.text += " |"+theMovie.showUnit_mc["pic"+myNo+"_mc"]
		
	} else {
		clearInterval(interval);
	}
	myNo+=1
}

/*calls the function fadeIn and tells it how long 
to pause before coming in*/

//startTransition();

/*TRANSITIONS FX -------------------------------------------------------------
FUNCTION DESCRIPTION:
___________________________FUNCTION CALL______________________________________
***setTransition(Moviename& Path, Start Location, Duration, Effect, Easing)***
_____________________________VARIABLES________________________________________
--Moviename& Path: Example -> theMovie.test
--Start Location Values [0:Default, 1:TopLeft, 2:Top, 3:TopRight, 4:CentreLeft, 	5:Centre, 6:CentreRight, 7:BottomLeft, 8:BottomCentre, 9:BottomRight)
--Duration in seconds
--Effect Values: Iris - Wipe - PixelDissolve - Blinds - Fade - Zoom - Photo - Rotate - Random
--Easing Values : Strong - Elastic - Bounce - Back
_____________________________________________________________________________*/
var myTrans_mc:MovieClip;
var transParam:Object = new Object();
var tm:mx.transitions.TransitionManager;
var transListener:Object;

function setTransition(myTrans_mc_var, transStartPoint, transDuration, transTweenType, transMotion, transDirection) {
	//SET MOVIE NAME AND PATH FOR TRANSITION
	myTrans_mc = myTrans_mc_var;
	// Check if RANDOM Applies
	if (transTweenType == "Random") {
		//Randomise Effect
		var random_effect_array:Array = Array("Iris", "Wipe", "PixelDissolve", "Blinds", "Fade", "Zoom", "Photo");
		var tempRandomEffectNo:Number = Math.ceil(Math.random()*6);
		//trace("tempRandomEffectNo:"+tempRandomEffectNo);
		var myRandomEffect:String = random_effect_array[tempRandomEffectNo];
	} else {
		myRandomEffect = transTweenType;
	}
	//trace("myRandomEffect:"+myRandomEffect);
	//STANDARD VARIABLES INIT
	tm = new mx.transitions.TransitionManager(myTrans_mc);
	//FUNCTION SET UP
	//Values: 0 = IN / 1 = OUT
	transParam.direction = transDirection;
	transParam.startPoint = transStartPoint;
	transParam.duration = transDuration;
	switch (myRandomEffect) {
	case "Iris" :
		transParam.type = mx.transitions.Iris;
		transParam.shape = "CIRCLE";
		break;
	case "Wipe" :
		transParam.type = mx.transitions.Wipe;
		break;
	case "PixelDissolve" :
		transParam.type = mx.transitions.PixelDissolve;
		transParam.xSections = 40;
		transParam.ySections = 40;
		break;
	case "Blinds" :
		transParam.type = mx.transitions.Blinds;
		transParam.numStrips = 40;
		break;
	case "Fade" :
		transParam.type = mx.transitions.Fade;
		break;
	case "Zoom" :
		transParam.type = mx.transitions.Zoom;
		break;
	case "Fly" :
		transParam.type = mx.transitions.Fly;
		break;
	case "Photo" :
		transParam.type = mx.transitions.Photo;
		break;
	case "Rotate" :
		transParam.type = mx.transitions.Rotate;
		break;
	case "Squeeze" :
		transParam.type = mx.transitions.Squeeze;
		break;
	default :
		transParam.type = mx.transitions.Iris;
		transParam.shape = "CIRCLE";
		effects.selectedIndex = 2;
	}
	switch (transMotion) {
	case "Strong" :
		transParam.easing = mx.transitions.easing.Strong.easeInOut;
		break;
	case "Elastic" :
		transParam.easing = mx.transitions.easing.Elastic.easeOut;
		break;
	case "Bounce" :
		transParam.easing = mx.transitions.easing.Bounce.easeOut;
		break;
	case "Back" :
		transParam.easing = mx.transitions.easing.Back.easeOut;
		break;
	default :
		transParam.easing = mx.transitions.easing.Strong.easeInOut;
		easing.selectedIndex = 1;
	}
	// execute the motion
	tm.startTransition(transParam);
	//LISTENERS
	/*transListener = null;
	transListener = new Object();
	transListener.allTransitionsInDone = function(evt):Void  {
		//trace(evt.type+" triggered");
		
		picCounter++
		startTransition(theMovie, picCounter)
		//
		
		theMovie.debux.text = evt.type+" triggered" + picCounter + "  " +tm
		
	};*/
	/*
	transListener.allTransitionsOutDone = function(evt):Void  {
		//trace(evt.type+" triggered");
		// GO TO THE APPROPRIATE FRAME OF THE PRESENTATION
		myTrans_mc.gotoAndStop(myChosenStoryCurrentFrame+1);
		//CHANGE DIRECTION SO TO TRANS NEXT IMAGE
		transParam.direction = 0;
		//START SECOND IMAGE TRANSITION
		tm.startTransition(transParam);
	};
	*/
	//
	//tm.removeEventListener("allTransitionsInDone", transListener);
	//tm.addEventListener("allTransitionsInDone", transListener);
	//tm.removeEventListener("allTransitionsOutDone", transListener);
	//tm.addEventListener("allTransitionsOutDone", transListener);
}

//___________________________END OF TRANSITIONS_________________________________
/*TRANSITIONS FX -------------------------------------------------------------
***setTransition(Moviename& Path, Start Location, Duration, Effect, Easing)***
_____________________________VARIABLES________________________________________
--Moviename& Path: Example -> theMovie.test
--Start Location Values [0:Default, 1:TopLeft, 2:Top, 3:TopRight, 4:CentreLeft, 	5:Centre, 6:CentreRight, 7:BottomLeft, 8:BottomCentre, 9:BottomRight)
--Duration in seconds
--Effect Values: Iris - Wipe - PixelDissolve - Blinds - Fade - Zoom - Photo - Rotate - Random
--Easing Values : Strong - Elastic - Bounce - Back
-- TransDirection : 0 = IN / 1= OUT
_____________________________________________________________________________*/
//setTransition(anime, 5, 15, "Random", "Elastic", 0);