//MOD: 27/6/11 - supports global "get the objects" function - NK

var numIntJustifyMcs:Number;
//


//returns an object with an array of the items(movieclips) that need to be initialised
//be that buttons, items, whatever. whatAmISearchingFor takes the root of the name of
//the movie clip that needs to be counted. TODO: return an object with an array of objects.
function getInitNumOfItems(whatAmISearchingFor):Object {
	var itemsList:Object = new Object();
	itemsList.Items = Array();
	itemsList.Total = Number;
	for (var k in theMovie) {
		if (k.substr(0, whatAmISearchingFor.length) == whatAmISearchingFor) {
			itemsList.Items.push(k);
		}
	}
	itemsList.Items.reverse();
	itemsList.Total = itemsList.Items.length;
	return itemsList;
}

function resetAudioScriptButtons(){
	for(i=0; i<numIntJustifyMcs; i++){
		theMovie["audioJustify_"+i].pressed = false;
		theMovie["audioJustify_"+i].gotoAndStop(1);
		theMovie.tapescript_text_mc["tapescriptJustification_"+i]._visible = false;
		for(j=0; j<theMovie.maxPlaces; j++){
			theMovie["audioJustify_"+i+""+j].pressed = false;
			theMovie["audioJustify_"+i+""+j].gotoAndStop(1);
			theMovie.tapescript_text_mc["tapescriptJustification_"+i+""+j]._visible = false;
		}
	}
}
//
function closeAudiocript_Release(){
	resetAudioScriptButtons();
	theMovie._parent.tapeScript_Release();
}
//
function audiocriptJustify_Release(){
	if(!this.pressed){
		this.pressed = true;
		this.gotoAndStop(2);
		theMovie.tapescript_text_mc["tapescriptJustification_"+this.myID]._visible = true;
	} else {
		this.pressed = false;
		this.gotoAndStop(1);
		theMovie.tapescript_text_mc["tapescriptJustification_"+this.myID]._visible = false;
	}
	theMovie._parent.tapeScript_Release();
}
//
function initTapeScriptJustify(numJustifyMcs){
	numIntJustifyMcs = numJustifyMcs;
	for(i=0; i<numIntJustifyMcs; i++){
		theMovie.tapescript_text_mc["tapescriptJustification_"+i].myID = i;
		theMovie.tapescript_text_mc["tapescriptJustification_"+i].pressed = false;
		theMovie.tapescript_text_mc["tapescriptJustification_"+i]._visible = false;
		//
		theMovie["audioJustify_"+i].onRelease = audiocriptJustify_Release;
		theMovie["audioJustify_"+i].myID = i;
		theMovie["audioJustify_"+i].pressed = false;
		theMovie["audioJustify_"+i]._visible = false;
		//		
		for(j=0; j<theMovie.maxPlaces; j++){
			theMovie.tapescript_text_mc["tapescriptJustification_"+i+""+j].myID = i+""+j;			
			theMovie.tapescript_text_mc["tapescriptJustification_"+i+""+j].pressed = false;
			theMovie.tapescript_text_mc["tapescriptJustification_"+i+""+j]._visible = false;
			//
			theMovie["audioJustify_"+i+""+j].onRelease = audiocriptJustify_Release;
			theMovie["audioJustify_"+i+""+j].myID = i+""+j;	
			theMovie["audioJustify_"+i+""+j].pressed = false;
			theMovie["audioJustify_"+i+""+j]._visible = false;
		}
		//
		theMovie.tapescript_text_mc.close_AudioScript_mc.onRelease = closeAudiocript_Release;
	}
}

initTapeScriptJustify(getInitNumOfItems("audioJustify").Total);
