//Code to open a link to an activity: sound+2 definitions

//create and initialize css
import TextField.StyleSheet;
var myCSS:StyleSheet = new StyleSheet();
myCSS.setStyle("h1", {fontSize:'10', color:'#C51D2B'});
myCSS.setStyle("eTag", {fontSize:'10', color:'#0B2860'});
myCSS.setStyle("NumTag", {color:'#0B2860'});
myCSS.setStyle("NumTagPressed", {color:'#E85C00'});



// XMLy ***************************************
function processXMLData(success){
  if (success){	  
  	// Define root node
	var rootNode=this.firstChild;
	  
	// COUNTING START ***************************************
	// Read Counting Start attribute
	var counterNode=rootNode.attributes.counter;
	if(counterNode == undefined){
		debug8.text = "counterNode Undefined : " +counterNode
		counterNode = 1*1;
		debug8.text += " ++ " +counterNode
	} else {
		debug8.text = "counterNode OK : " +counterNode
		counterNode = counterNode*1;
	}

	//	  
	for (var currentDefinition=0; currentDefinition<rootNode.childNodes.length; currentDefinition++) {

		var definitionNode=rootNode.childNodes[currentDefinition];
		debug1.text += "@@@ definitionNode: "+ definitionNode
		//debug1.text += definitionNode.attributes.title +"\n"
		//
		totalItems++;
		debug2.text = "@@@ totalItems: "+totalItems
		//
		if (currentDefinition>0){
			// definitionPrevious > The Loop value before the current value of the loop > currentDefinition
			var definitionPrevious = currentDefinition - 1;
			// SOUND BUTTON DUPLICATE
			duplicateMovieClip (theMovie.container_mc.main_mc["speaker"+definitionPrevious], "speaker" + currentDefinition, currentDefinition+theMovie.itemsTotal); 
			theMovie.container_mc.main_mc["speaker"+currentDefinition]._y += theMovie.container_mc.main_mc["english"+definitionPrevious]._height;
			// SOUND BUTTON II DUPLICATE
			duplicateMovieClip (theMovie.container_mc.main_mc["speakerII"+definitionPrevious], "speakerII" + currentDefinition, currentDefinition+theMovie.itemsTotal*200); 
			theMovie.container_mc.main_mc["speakerII"+currentDefinition]._y += theMovie.container_mc.main_mc["english"+definitionPrevious]._height;
			// ENGLISH WORD DUPLICATE
			duplicateMovieClip (theMovie.container_mc.main_mc["showHideEng"+definitionPrevious], "showHideEng" + currentDefinition, currentDefinition+(theMovie.itemsTotal*400)); 
			theMovie.container_mc.main_mc["showHideEng"+currentDefinition]._y +=theMovie.container_mc.main_mc["english"+definitionPrevious]._height;
			duplicateMovieClip (theMovie.container_mc.main_mc["english"+definitionPrevious], "english" + currentDefinition, currentDefinition+(theMovie.itemsTotal*600)); 
			theMovie.container_mc.main_mc["english"+currentDefinition]._y +=theMovie.container_mc.main_mc["english"+definitionPrevious]._height;
			// GREEK WORD DUPLICATE
			duplicateMovieClip (theMovie.container_mc.main_mc["showHideGreek"+definitionPrevious], "showHideGreek" + currentDefinition, currentDefinition+(theMovie.itemsTotal*800)); 
			theMovie.container_mc.main_mc["showHideGreek"+currentDefinition]._y +=theMovie.container_mc.main_mc["english"+definitionPrevious]._height;
			duplicateMovieClip (theMovie.container_mc.main_mc["greek"+definitionPrevious], "greek" + currentDefinition, currentDefinition+(theMovie.itemsTotal*900));
			theMovie.container_mc.main_mc["greek"+currentDefinition]._y += theMovie.container_mc.main_mc["english"+definitionPrevious]._height;
			// EXTRA WORD DUPLICATE
			duplicateMovieClip (theMovie.container_mc.main_mc["showHideExtra"+definitionPrevious], "showHideExtra" + currentDefinition, currentDefinition+(theMovie.itemsTotal*1000)); 
			theMovie.container_mc.main_mc["showHideExtra"+currentDefinition]._y +=theMovie.container_mc.main_mc["english"+definitionPrevious]._height;
			duplicateMovieClip (theMovie.container_mc.main_mc["Extra"+definitionPrevious], "Extra" + currentDefinition, currentDefinition+(theMovie.itemsTotal*1100));
			theMovie.container_mc.main_mc["Extra"+currentDefinition]._y += theMovie.container_mc.main_mc["english"+definitionPrevious]._height;
			// EXTRA II WORD DUPLICATE
			duplicateMovieClip (theMovie.container_mc.main_mc["showHideExtraII"+definitionPrevious], "showHideExtraII" + currentDefinition, currentDefinition+(theMovie.itemsTotal*18)); 
			theMovie.container_mc.main_mc["showHideExtraII"+currentDefinition]._y +=theMovie.container_mc.main_mc["english"+definitionPrevious]._height;
			duplicateMovieClip (theMovie.container_mc.main_mc["ExtraII"+definitionPrevious], "ExtraII" + currentDefinition, currentDefinition+(theMovie.itemsTotal*19));
			theMovie.container_mc.main_mc["ExtraII"+currentDefinition]._y += theMovie.container_mc.main_mc["english"+definitionPrevious]._height;
			
			if (definitionNode.attributes.title){
				theMovie.container_mc.main_mc["speaker"+currentDefinition]._visible = false;
				theMovie.container_mc.main_mc["speakerII"+currentDefinition]._visible = false;
				//
				theMovie.container_mc.main_mc["showHideEng"+currentDefinition]._visible = false;
				//theMovie.container_mc.main_mc["english"+currentDefinition]._visible = false;
				theMovie.container_mc.main_mc["english"+currentDefinition].titled = true;
				//
				theMovie.container_mc.main_mc["showHideGreek"+currentDefinition]._visible = false;
				//theMovie.container_mc.main_mc["greek"+currentDefinition]._visible = false;
				theMovie.container_mc.main_mc["greek"+currentDefinition].titled = true;
				//
				theMovie.container_mc.main_mc["showHideExtra"+currentDefinition]._visible = false;
				//theMovie.container_mc.main_mc["Extra"+currentDefinition]._visible = false;
				theMovie.container_mc.main_mc["Extra"+currentDefinition].titled = true;
				//
				theMovie.container_mc.main_mc["showHideExtraII"+currentDefinition]._visible = false;
				//theMovie.container_mc.main_mc["Extra"+currentDefinition]._visible = false;
				theMovie.container_mc.main_mc["ExtraII"+currentDefinition].titled = true;
				//
			}
		}			
		
		// SOUND ***************************************
		var soundNode=findNode(definitionNode, "sound");
		soundValue=getValue(soundNode);
			
		if (soundValue!= "NAN"){
			initSounds(currentDefinition);
		} else {
			theMovie.container_mc.main_mc["speaker" + currentDefinition]._visible = false;
			theMovie.container_mc.main_mc["speakerII" + currentDefinition]._visible = false;
		}
		//
		var soundNodeII=findNode(definitionNode, "extra");
		soundValueII=getValue(soundNodeII);
		
		if (soundValueII== "NAN" || soundValueII== "NO VALUE"){
			theMovie.container_mc.main_mc["speakerII" + currentDefinition]._visible = false;
		}
		debug3.text += " @ "+soundValue
		
		// ENGLISH 1 ***************************************
		var englishNode=findNode(definitionNode, "english");
		englishValue=getValue(englishNode);
		if (englishValue!= "NAN"){
			if (theMovie.container_mc.main_mc["english"+currentDefinition].titled){
				theMovie.container_mc.main_mc["english"+currentDefinition].mytext.html = true;
				theMovie.container_mc.main_mc["english"+currentDefinition].mytext.styleSheet = myCSS;
				theMovie.container_mc.main_mc["english"+currentDefinition].mytext.htmlText = "<h1><b>"+englishValue+"</b></h1>";
				// If special number is used keep the rest of the numbering into sequence [available only here]
				counterNode --;
			} else {
				theMovie.container_mc.main_mc["english"+currentDefinition].mytext.html = true;
				theMovie.container_mc.main_mc["english"+currentDefinition].mytext.styleSheet = myCSS;
				theMovie.container_mc.main_mc["english"+currentDefinition].mytext.htmlText = "<eTag><b>"+englishValue+"</b></eTag>";
				// NUMBERING [Special or not]
				theMovie.container_mc.main_mc["showHideEng"+currentDefinition].my_text.html = true;
				theMovie.container_mc.main_mc["showHideEng"+currentDefinition].my_text.styleSheet = myCSS;
				if (definitionNode.attributes.myNumber){
					theMovie.container_mc.main_mc["showHideEng"+currentDefinition].my_text.htmlText = "<NumTag>"+(definitionNode.attributes.myNumber)+"</NumTag>";
					// If special number is used keep the rest of the numbering into sequence [available only here]
					counterNode --;
				} else {
					theMovie.container_mc.main_mc["showHideEng"+currentDefinition].my_text.htmlText = "<NumTag>"+(currentDefinition + counterNode)+"</NumTag>";
				}
			}			
			theMovie.container_mc.main_mc["showHideEng"+currentDefinition].myTextShowHide ="english" + currentDefinition;
			theMovie.container_mc.main_mc["showHideEng"+currentDefinition].onRelease = showHideText;
		} else {
			theMovie.container_mc.main_mc["showHideEng"+ currentDefinition]._visible = false;
		}		
		debug4.text += " @ "+englishValue
		
		// GREEK 1 ***************************************
		var greekNode=findNode(definitionNode, "greek");
		greekValue=getValue(greekNode);
		if (greekValue!= "NAN"){
			if (theMovie.container_mc.main_mc["greek"+currentDefinition].titled){
				theMovie.container_mc.main_mc["greek"+currentDefinition].mytext.html = true;
				theMovie.container_mc.main_mc["greek"+currentDefinition].mytext.styleSheet = myCSS;
				theMovie.container_mc.main_mc["greek"+currentDefinition].mytext.htmlText = "<h1><b>"+greekValue+"</b></h1>";
			} else {
				theMovie.container_mc.main_mc["greek"+currentDefinition].mytext.text = greekValue;
				
				// NUMBERING [Special or not]
				theMovie.container_mc.main_mc["showHideGreek"+currentDefinition].my_text.html = true;
				theMovie.container_mc.main_mc["showHideGreek"+currentDefinition].my_text.styleSheet = myCSS;
				if (definitionNode.attributes.myNumber){
					theMovie.container_mc.main_mc["showHideGreek"+currentDefinition].my_text.htmlText = "<NumTag>"+(definitionNode.attributes.myNumber)+"</NumTag>";
				} else {
					theMovie.container_mc.main_mc["showHideGreek"+currentDefinition].my_text.htmlText = "<NumTag>"+(currentDefinition + counterNode)+"</NumTag>";
				}
				
			}					
			theMovie.container_mc.main_mc["showHideGreek"+currentDefinition].myTextShowHide ="greek" + currentDefinition;
			theMovie.container_mc.main_mc["showHideGreek"+currentDefinition].onRelease = showHideText;
		} else {
			theMovie.container_mc.main_mc["showHideGreek"+ currentDefinition]._visible = false;
		}
		
		debug5.text += " @ "+greekValue
		
		// EXTRA II ENGLISH ***************************************
		var extraNode=findNode(definitionNode, "extra");
		extraValue=getValue(extraNode);
		if (extraValue!= "NAN" && extraValue!= "NO VALUE"){
			if (theMovie.container_mc.main_mc["Extra"+currentDefinition].titled){
				theMovie.container_mc.main_mc["Extra"+currentDefinition].mytext.html = true;
				theMovie.container_mc.main_mc["Extra"+currentDefinition].mytext.styleSheet = myCSS;
				theMovie.container_mc.main_mc["Extra"+currentDefinition].mytext.htmlText = "<h1><b>"+extraValue+"</b></h1>";
			} else {
				theMovie.container_mc.main_mc["Extra"+currentDefinition].mytext.html = true;
				theMovie.container_mc.main_mc["Extra"+currentDefinition].mytext.styleSheet = myCSS;
				theMovie.container_mc.main_mc["Extra"+currentDefinition].mytext.htmlText = "<eTag><b>"+extraValue+"</b></eTag>";
				// NUMBERING [Special or not]
				theMovie.container_mc.main_mc["showHideExtra"+currentDefinition].my_text.html = true;
				theMovie.container_mc.main_mc["showHideExtra"+currentDefinition].my_text.styleSheet = myCSS;
				if (definitionNode.attributes.myNumber){
					theMovie.container_mc.main_mc["showHideExtra"+currentDefinition].my_text.htmlText = "<NumTag>"+(definitionNode.attributes.myNumber)+"</NumTag>";
				} else {
					theMovie.container_mc.main_mc["showHideExtra"+currentDefinition].my_text.htmlText = "<NumTag>"+(currentDefinition + counterNode)+"</NumTag>";
				}
				
			}								
			theMovie.container_mc.main_mc["showHideExtra"+currentDefinition].myTextShowHide ="Extra" + currentDefinition;
			theMovie.container_mc.main_mc["showHideExtra"+currentDefinition].onRelease = showHideText;
		} else {
			theMovie.container_mc.main_mc["Extra"+currentDefinition]._visible = false;
			theMovie.container_mc.main_mc["showHideExtra"+ currentDefinition]._visible = false;
		}		
		debug6.text += " @ "+extraValue
		
		// EXTRA II GREEK ***************************************
		var extraNodeII=findNode(definitionNode, "extraII");
		extraValueII=getValue(extraNodeII);
		if (extraValueII!= "NAN" && extraValueII!= "NO VALUE"){
			if (theMovie.container_mc.main_mc["ExtraII"+currentDefinition].titled){
				theMovie.container_mc.main_mc["ExtraII"+currentDefinition].mytext.html = true;
				theMovie.container_mc.main_mc["ExtraII"+currentDefinition].mytext.styleSheet = myCSS;
				theMovie.container_mc.main_mc["ExtraII"+currentDefinition].mytext.htmlText = "<h1><b>"+extraValueII+"</b></h1>";
			} else {
				theMovie.container_mc.main_mc["ExtraII"+currentDefinition].mytext.text = extraValueII;
				
				// NUMBERING [Special or not]
				theMovie.container_mc.main_mc["showHideExtraII"+currentDefinition].my_text.html = true;
				theMovie.container_mc.main_mc["showHideExtraII"+currentDefinition].my_text.styleSheet = myCSS;
				if (definitionNode.attributes.myNumber){
					theMovie.container_mc.main_mc["showHideExtraII"+currentDefinition].my_text.htmlText = "<NumTag>"+(definitionNode.attributes.myNumber)+"</NumTag>";
				} else {
					theMovie.container_mc.main_mc["showHideExtraII"+currentDefinition].my_text.htmlText = "<NumTag>"+(currentDefinition + counterNode)+"</NumTag>";
				}
				
			}								
			theMovie.container_mc.main_mc["showHideExtraII"+currentDefinition].myTextShowHide ="ExtraII" + currentDefinition;
			theMovie.container_mc.main_mc["showHideExtraII"+currentDefinition].onRelease = showHideText;
		} else {
			theMovie.container_mc.main_mc["ExtraII"+currentDefinition]._visible = false;
			theMovie.container_mc.main_mc["showHideExtraII"+ currentDefinition]._visible = false;
		}		
		debug7.text += " @ "+extraValueII
	  }// END FOR LOOP
	  
	  // Run ScrollBar function
	//  if (theMovie.container_mc.main_mc._height > theMovie.container_mc.mask_mc._height){
	if (theMovie.container_mc.main_mc._height > (theMovie.container_mc.scrollVTree_mc._height - 20)){
	  	theMovie.container_mc.startScrollBar()
	 } else {
		theMovie.container_mc.mask_mc._visible = false;
		theMovie.container_mc.scrollVTree_mc._visible = false;
	 }
	//Hide Greek words on Init
	//showHideGreek();
	hideGreek();
	hideExtraII();
	//Hide Greek words on Init
	
  } else { 
    debug1.text = "XML not loaded"
  } // END First IF
}
//
function playAudioDefinition() {
	if (this.pressed==0){
		for (i=0; i < totalItems; i++) {
			theMovie.container_mc.main_mc["speaker" + i].pressed=0;
			theMovie.container_mc.main_mc["speaker" + i].gotoAndStop(1);
			theMovie.container_mc.main_mc["speakerII" + i].pressed=0;
			theMovie.container_mc.main_mc["speakerII" + i].gotoAndStop(1);
		}
		this.pressed=1;
		this.gotoAndStop(2);
	    soundPlay=myMainPath + String(this.mySound + ".mp3");
	    listenSound.loadSound(soundPlay,true);
		listenSound.onSoundComplete=function(){
			for (j=0; j < totalItems; j++) {
				theMovie.container_mc.main_mc["speaker" + j].pressed=0;
				theMovie.container_mc.main_mc["speaker" + j].gotoAndStop(1);
				theMovie.container_mc.main_mc["speakerII" + j].pressed=0;
				theMovie.container_mc.main_mc["speakerII" + j].gotoAndStop(1);
			}
		}
	} else {
		listenSound.stop();
		this.pressed=0;
		this.gotoAndStop(1);
	}
}
function initSounds(mySound) {
		theMovie.container_mc.main_mc["speaker" + mySound].gotoAndStop(1);
		theMovie.container_mc.main_mc["speaker" + mySound].mySound=mySound;
		theMovie.container_mc.main_mc["speaker" + mySound].pressed=0;
		theMovie.container_mc.main_mc["speaker" + mySound].onRelease=playAudioDefinition;
		//theMovie.container_mc.main_mc["speaker" + mySound]_alpha=(showSpeakers == false?0:100);
		theMovie.container_mc.main_mc["speakerII" + mySound].gotoAndStop(1);
		theMovie.container_mc.main_mc["speakerII" + mySound].mySound=mySound+"_II";
		theMovie.container_mc.main_mc["speakerII" + mySound].pressed=0;
		theMovie.container_mc.main_mc["speakerII" + mySound].onRelease=playAudioDefinition;
}
//
function showHideText(){
	if (theMovie.container_mc.main_mc[this.myTextShowHide]._visible){
		theMovie.container_mc.main_mc[this.myTextShowHide]._visible = false;
		this.gotoAndStop(2);
		this.my_text.htmlText = "<NumTagPressed>"+ this.my_text.text+"</NumTagPressed>";
	} else {
		theMovie.container_mc.main_mc[this.myTextShowHide]._visible = true;
		this.gotoAndStop(1);
		this.my_text.htmlText = "<NumTag>"+ this.my_text.text+"</NumTag>";
	}
	//theMovie.container_mc.main_mc[this.myTextShowHide]._visible = !theMovie.container_mc.main_mc[this.myTextShowHide]._visible;	
}

/*
function showHideEnglish(){
	if (theMovie.container_mc.showHideEnglish.pressed==0){
		for (i=0; i < totalItems; i++) {
			theMovie.container_mc.main_mc["english"+i]._visible = false;
			//theMovie.container_mc.main_mc["showHideEng"+i]._visible = false;
			theMovie.container_mc.main_mc["showHideEng"+i].gotoAndStop(2);
			theMovie.container_mc.main_mc["showHideEng"+i].my_text.htmlText = "<NumTagPressed>"+ theMovie.container_mc.main_mc["showHideEng"+i].my_text.text+"</NumTagPressed>";
		}
		theMovie.container_mc.showHideEnglish.pressed=1;
		theMovie.container_mc.showHideEnglish.gotoAndStop(2);
	} else {
		for (i=0; i < totalItems; i++) {
			if (theMovie.container_mc.main_mc["english"+i].titled){
				
			} else {
				//theMovie.container_mc.main_mc["showHideEng"+i]._visible = true;
				theMovie.container_mc.main_mc["showHideEng"+i].gotoAndStop(1);
				theMovie.container_mc.main_mc["showHideEng"+i].my_text.htmlText = "<NumTag>"+ theMovie.container_mc.main_mc["showHideEng"+i].my_text.text+"</NumTag>";
			}	
			theMovie.container_mc.main_mc["english"+i]._visible = true;
		}
		theMovie.container_mc.showHideEnglish.pressed=0;
		theMovie.container_mc.showHideEnglish.gotoAndStop(1);
	}	
}
function showHideGreek(){
	if (theMovie.container_mc.showHideGreek.pressed==0){
		for (i=0; i < totalItems; i++) {
			theMovie.container_mc.main_mc["greek"+i]._visible = false;
			//theMovie.container_mc.main_mc["showHideGreek"+i]._visible = false;
			theMovie.container_mc.main_mc["showHideGreek"+i].gotoAndStop(2);
			theMovie.container_mc.main_mc["showHideGreek"+i].my_text.htmlText = "<NumTagPressed>"+ theMovie.container_mc.main_mc["showHideGreek"+i].my_text.text+"</NumTagPressed>";
		}
		theMovie.container_mc.showHideGreek.pressed=1;
		theMovie.container_mc.showHideGreek.gotoAndStop(2);
	} else {
		for (i=0; i < totalItems; i++) {
			if (theMovie.container_mc.main_mc["greek"+i].titled){
				
			} else {
				//theMovie.container_mc.main_mc["showHideGreek"+i]._visible = true;
				theMovie.container_mc.main_mc["showHideGreek"+i].gotoAndStop(1);
				theMovie.container_mc.main_mc["showHideGreek"+i].my_text.htmlText = "<NumTag>"+ theMovie.container_mc.main_mc["showHideGreek"+i].my_text.text+"</NumTag>";
			}				
			theMovie.container_mc.main_mc["greek"+i]._visible = true;
		}
		theMovie.container_mc.showHideGreek.pressed=0;
		theMovie.container_mc.showHideGreek.gotoAndStop(1);
	}	
}
function showHideExtra(){
	if (theMovie.container_mc.showHideExtra.pressed==0){
		for (i=0; i < totalItems; i++) {
			theMovie.container_mc.main_mc["Extra"+i]._visible = false;
			theMovie.container_mc.main_mc["showHideExtra"+i]._visible = false;
			theMovie.container_mc.main_mc["showHideExtra"+i].gotoAndStop(2);
			theMovie.container_mc.main_mc["showHideExtra"+i].my_text.htmlText = "<NumTagPressed>"+ theMovie.container_mc.main_mc["showHideExtra"+i].my_text.text+"</NumTagPressed>";
		}
		theMovie.container_mc.showHideExtra.pressed=1;
		theMovie.container_mc.showHideExtra.gotoAndStop(2);
	} else {
		for (i=0; i < totalItems; i++) {
			if (theMovie.container_mc.main_mc["Extra"+i].titled){
				
			} else {
				theMovie.container_mc.main_mc["showHideExtra"+i]._visible = true;
				theMovie.container_mc.main_mc["showHideExtra"+i].gotoAndStop(1);
				theMovie.container_mc.main_mc["showHideExtra"+i].my_text.htmlText = "<NumTag>"+ theMovie.container_mc.main_mc["showHideExtra"+i].my_text.text+"</NumTag>";
			}						
			theMovie.container_mc.main_mc["Extra"+i]._visible = true;
		}
		theMovie.container_mc.showHideExtra.pressed=0;
		theMovie.container_mc.showHideExtra.gotoAndStop(1);
	}	
}
*/
function showEnglish(){
		for (i=0; i < totalItems; i++) {
			if (theMovie.container_mc.main_mc["english"+i].titled){
				
			} else if (theMovie.container_mc.main_mc["showHideEng"+i]._visible){
				//theMovie.container_mc.main_mc["showHideEng"+i]._visible = true;
				theMovie.container_mc.main_mc["showHideEng"+i].gotoAndStop(1);
				theMovie.container_mc.main_mc["showHideEng"+i].my_text.htmlText = "<NumTag>"+ theMovie.container_mc.main_mc["showHideEng"+i].my_text.text+"</NumTag>";
				// Show IT
				theMovie.container_mc.main_mc["english"+i]._visible = true;
			}				
		}
		theMovie.container_mc.showHideEnglish.pressed=0;
		theMovie.container_mc.showHideEnglish.gotoAndStop(1);
}
function hideEnglish(){
		for (i=0; i < totalItems; i++) {
			if (!theMovie.container_mc.main_mc["english"+i].titled){
				theMovie.container_mc.main_mc["english"+i]._visible = false;
			}
			//theMovie.container_mc.main_mc["showHideEng"+i]._visible = false;
			theMovie.container_mc.main_mc["showHideEng"+i].gotoAndStop(2);
			theMovie.container_mc.main_mc["showHideEng"+i].my_text.htmlText = "<NumTagPressed>"+ theMovie.container_mc.main_mc["showHideEng"+i].my_text.text+"</NumTagPressed>";
		}
		theMovie.container_mc.showHideEnglish.pressed=1;
		theMovie.container_mc.showHideEnglish.gotoAndStop(2);
}
//
function showGreek(){
		for (i=0; i < totalItems; i++) {
			if (theMovie.container_mc.main_mc["greek"+i].titled){
				
			} else if (theMovie.container_mc.main_mc["showHideGreek"+i]._visible){
				//theMovie.container_mc.main_mc["showHideGreek"+i]._visible = true;
				theMovie.container_mc.main_mc["showHideGreek"+i].gotoAndStop(1);
				theMovie.container_mc.main_mc["showHideGreek"+i].my_text.htmlText = "<NumTag>"+ theMovie.container_mc.main_mc["showHideGreek"+i].my_text.text+"</NumTag>";
				// Show IT
				theMovie.container_mc.main_mc["greek"+i]._visible = true;
			}					
		}
		theMovie.container_mc.showHideGreek.pressed=0;
		theMovie.container_mc.showHideGreek.gotoAndStop(1);
}

function hideGreek(){
		for (i=0; i < totalItems; i++) {
			if (!theMovie.container_mc.main_mc["greek"+i].titled){
				theMovie.container_mc.main_mc["greek"+i]._visible = false;
			}
			
			//theMovie.container_mc.main_mc["showHideGreek"+i]._visible = false;
			theMovie.container_mc.main_mc["showHideGreek"+i].gotoAndStop(2);
			theMovie.container_mc.main_mc["showHideGreek"+i].my_text.htmlText = "<NumTagPressed>"+ theMovie.container_mc.main_mc["showHideGreek"+i].my_text.text+"</NumTagPressed>";
		}
		theMovie.container_mc.showHideGreek.pressed=1;
		theMovie.container_mc.showHideGreek.gotoAndStop(2);
}

//
function showExtra(){
		for (i=0; i < totalItems; i++) {
			if (theMovie.container_mc.main_mc["Extra"+i].titled){
				
			} else if (theMovie.container_mc.main_mc["showHideExtra"+i]._visible){
				//theMovie.container_mc.main_mc["showHideExtra"+i]._visible = true;
				theMovie.container_mc.main_mc["showHideExtra"+i].gotoAndStop(1);
				theMovie.container_mc.main_mc["showHideExtra"+i].my_text.htmlText = "<NumTag>"+ theMovie.container_mc.main_mc["showHideExtra"+i].my_text.text+"</NumTag>";
				//
				theMovie.container_mc.main_mc["Extra"+i]._visible = true;
			}					
		}
		theMovie.container_mc.showHideExtra.pressed=0;
		theMovie.container_mc.showHideExtra.gotoAndStop(1);
}
function hideExtra(){
		for (i=0; i < totalItems; i++) {
			if (!theMovie.container_mc.main_mc["Extra"+i].titled){
				theMovie.container_mc.main_mc["Extra"+i]._visible = false;
			}
			
			//theMovie.container_mc.main_mc["showHideExtra"+i]._visible = false;
			theMovie.container_mc.main_mc["showHideExtra"+i].gotoAndStop(2);
			theMovie.container_mc.main_mc["showHideExtra"+i].my_text.htmlText = "<NumTagPressed>"+ theMovie.container_mc.main_mc["showHideExtra"+i].my_text.text+"</NumTagPressed>";
		}
		theMovie.container_mc.showHideExtra.pressed=1;
		theMovie.container_mc.showHideExtra.gotoAndStop(2);
}

//
function showExtraII(){
		for (i=0; i < totalItems; i++) {
			if (theMovie.container_mc.main_mc["ExtraII"+i].titled){
				
			} else if (theMovie.container_mc.main_mc["showHideExtraII"+i]._visible){
				//theMovie.container_mc.main_mc["showHideExtraII"+i]._visible = true;
				theMovie.container_mc.main_mc["showHideExtraII"+i].gotoAndStop(1);
				theMovie.container_mc.main_mc["showHideExtraII"+i].my_text.htmlText = "<NumTag>"+ theMovie.container_mc.main_mc["showHideExtraII"+i].my_text.text+"</NumTag>";
				// Show IT
				theMovie.container_mc.main_mc["ExtraII"+i]._visible = true;
			}							
		}
		theMovie.container_mc.showHideExtraII.pressed=0;
		theMovie.container_mc.showHideExtraII.gotoAndStop(1);
}

function hideExtraII(){
		for (i=0; i < totalItems; i++) {
			if (!theMovie.container_mc.main_mc["ExtraII"+i].titled){
				theMovie.container_mc.main_mc["ExtraII"+i]._visible = false;
			}
			
			//theMovie.container_mc.main_mc["showHideExtraII"+i]._visible = false;
			theMovie.container_mc.main_mc["showHideExtraII"+i].gotoAndStop(2);
			theMovie.container_mc.main_mc["showHideExtraII"+i].my_text.htmlText = "<NumTagPressed>"+ theMovie.container_mc.main_mc["showHideExtraII"+i].my_text.text+"</NumTagPressed>";
		}
		theMovie.container_mc.showHideExtraII.pressed=1;
		theMovie.container_mc.showHideExtraII.gotoAndStop(2);
}
//*************************************
function findNode(node, nodeName){
  if (node.nodeName==nodeName) return node;
  
  for (var i=0; node.childNodes && i<node.childNodes.length; i++) {
    var foundNode=findNode(node.childNodes[i], nodeName);
    if (foundNode!=null) return foundNode;
  }
  return null;
}

function getValue(node){
  if (node && node.firstChild)
    return node.firstChild.nodeValue;
  return "NO VALUE";
}
//**********************************
var listenSound=new Sound(theMovie);
var totalItems=0;
/*
theMovie.container_mc.showHideEnglish.onRelease = showHideEnglish;
theMovie.container_mc.showHideEnglish.pressed=0;
theMovie.container_mc.showHideGreek.onRelease = showHideGreek;
theMovie.container_mc.showHideGreek.pressed=0;
theMovie.container_mc.showHideExtra.onRelease = showHideExtra;
theMovie.container_mc.showHideExtra.pressed=0;
*/
theMovie.container_mc.showHideEnglish.myShow.onRelease = showEnglish;
theMovie.container_mc.showHideEnglish.myHide.onRelease = hideEnglish;
theMovie.container_mc.showHideEnglish.pressed=0;
//
theMovie.container_mc.showHideGreek.myShow.onRelease = showGreek;
theMovie.container_mc.showHideGreek.myHide.onRelease = hideGreek;
theMovie.container_mc.showHideGreek.pressed=0;
//
theMovie.container_mc.showHideExtra.myShow.onRelease = showExtra;
theMovie.container_mc.showHideExtra.myHide.onRelease = hideExtra;
theMovie.container_mc.showHideExtra.pressed=0;
//
theMovie.container_mc.showHideExtraII.myShow.onRelease = showExtraII;
theMovie.container_mc.showHideExtraII.myHide.onRelease = hideExtraII;
theMovie.container_mc.showHideExtraII.pressed=0;

//
var xmlData=new XML();
xmlData.ignoreWhite=true;
xmlData.onLoad=processXMLData;
xmlData.load(myMainPath+"definition.xml");

