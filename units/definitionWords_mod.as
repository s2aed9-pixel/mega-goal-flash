//MOD:27/6/11 - Init at AS mod - NK

stop();
var defSound=new Sound(theMovie);
var currentdefSound;
var wordsNumber;

function initDefinition(numOfWords){
	theMovie.defBack_mc.useHandCursor=false;
	theMovie.defBack_mc.onRelease=function(){
	}
	theMovie.defBack_mc._visible=false;
	theMovie.defText_mc._visible=false;
	for (i=0;i<numOfWords;i++){
		 theMovie.buttDefinitionPath["definition"+i+"_mc"].myId=i;
		 theMovie.buttDefinitionPath["definition"+i+"_mc"].clicked=0;
		 theMovie.buttDefinitionPath["definition"+i+"_mc"].onRelease=showTheWord;
	}
}
//
function showTheWord(){
	if (this.clicked==0){
		for (i=0;i<wordsNumber;i++){
		     theMovie.buttDefinitionPath["definition"+i+"_mc"].clicked=0;
		}
	    theMovie.defText_mc.exitDefinition_mc._x=0;
	    //theMovie.defBack_mc._visible=false;
	    //theMovie.defText_mc._visible=false;		
		//
		this.clicked=1;
	    theMovie.defBack_mc._visible=true;
	    theMovie.defText_mc._visible=true;
	    theMovie.defText_mc.gotoAndStop(this.myId+2);
	    defBackResize(theMovie.defText_mc);
	    theMovie.defText_mc.exitDefinition_mc.onRelease=closeDefinition;
	    theMovie.currentdefSound=(theMovie.defText_mc._currentframe-2);
	    theMovie.defText_mc.defSound_mc.onRelease=playdefSound;//(this.myId);
	} else{
		this.clicked=0;
		theMovie.defText_mc.exitDefinition_mc._x=0;
	    theMovie.defBack_mc._visible=false;
	    theMovie.defText_mc._visible=false;		
	}
}
//
function defBackResize(myDefinitionMovie) {
	tempWidth=myDefinitionMovie._width;
	tempHeight=myDefinitionMovie._height;
	myDefinitionMovie._x = theMovie.defBack_mc._x+10;
	theMovie.defBack_mc._width=tempWidth+30;
	theMovie.defBack_mc._height=tempHeight+40;
	theMovie.defBack_mc._y=Stage.height-(theMovie.defBack_mc._height+60);
	// κεντράρισμα του κειμένου μέσα στο background
	var heightDifference=(theMovie.defBack_mc._height-tempHeight);
	myDefinitionMovie._y=theMovie.defBack_mc._y+(heightDifference/2);
	// αυτόματη τοποθέτηση του κουμπιού exit
	theMovie.defText_mc.exitDefinition_mc._x=0
	theMovie.defText_mc.exitDefinition_mc._x=theMovie.defText_mc._width//-theMovie.defText_mc.exitDefinition_mc._width;
    //theMovie.defText_mc.exitDefinition_mc._y=theMovie.defText_mc._y;
}
//
function playdefSound(){
	if (showPlayer == 1) {
		theMovie._parent.InitPlayer(theMovie.soundsPath + "audio.mp3");
	}
	//soundPlay = theMovie.soundsPath + String(theSound + ".mp3");
	soundPlay = theMovie.soundsPath + String("def"+currentdefSound + ".mp3")
	//soundPlay = theMovie.currentdefSound+".mp3";
	//trace(soundPlay)
	//soundPlay = "sounds/0.mp3";
	defSound.loadSound(soundPlay,true);
}
//
function closeDefinition(){
	theMovie.defText_mc.exitDefinition_mc._x=0;
	theMovie.defBack_mc._visible=false;
	theMovie.defText_mc._visible=false;
	for (i=0;i<wordsNumber;i++){
		buttDefinitionPath["definition"+i+"_mc"].clicked=0;
	}	
}
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
		trace(itemsList.Total);
	return itemsList;
}

if ((theMovie.wordNumber == null) || (theMovie.wordNumber == undefined)){
	wordsNumber = getInitNumOfItems("definition").Total;
} else {
	wordsNumber = theMovie.wordNumber;
}

initDefinition(wordsNumber);