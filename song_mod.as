//TEXT FORMAT ***********************************
//if text formats have not been defined in activity, use these default values
var default_fmt_Active:TextFormat = new TextFormat();
if (my_fmtActive != undefined) {
	default_fmt_Active = my_fmtActive;
} else {
	default_fmt_Active.bold = true;
	default_fmt_Active.font = "myLibraryFont";
	default_fmt_Active.color = 0x000000;
	default_fmt_Active.size = 14;
}
//TEXT FORMAT Optional
var default_fmt_Active_Optional:TextFormat = new TextFormat();
if (my_fmtActiveOptional !== undefined) {
	default_fmt_Active_Optional = my_fmtActiveOptional;
} else {	
	default_fmt_Active_Optional.bold = false;
	default_fmt_Active_Optional.font = "myLibraryFontOptional";
	default_fmt_Active_Optional.color = 0x000000;
	default_fmt_Active_Optional.size = 14;
}
	
//TEXT FORMAT REPLACE
var default_fmt_replace:TextFormat = new TextFormat();
if (my_fmtreplace != undefined) {
	default_fmt_replace = my_fmtreplace;
} else {	
	default_fmt_replace.bold = true;
	default_fmt_replace.font = "myLibraryFont";
	default_fmt_replace.color = 0x0000FF;
	default_fmt_replace.size = 14;
}
	
//TEXT FORMAT REPLACE Optional
var default_fmt_replace_Optional:TextFormat = new TextFormat();
if (my_fmtreplaceOptional != undefined) {
	default_fmt_replace_Optional = my_fmtreplaceOptional;
} else {	
	default_fmt_replace_Optional.bold = false;
	default_fmt_replace_Optional.font = "myLibraryFontOptional";
	default_fmt_replace_Optional.color = 0x0000FF;
	default_fmt_replace_Optional.size = 14;
}
//END TEXT FORMAT 

//***************************************************************
//************* SONG BEFORE INIT ********************************
//***************************************************************
//31/5/2011 - nk
//this makes sure that there is at least a 3-something gap
//between the end of a verse and the beginning of the next
//just to be on the safe side, change manually the last item
//of the array, sometimes it gives grief...
function correctTimes() {
	var timeLapse = 0;//original time difference
	var minimumGap = 3;//minimum wanted time difference
	for (i=0; i<myPosition_array.length; i++) {
		timeLapse = parseInt(myPosition_array[i+1][0]) - parseInt(myPosition_array[i][1]);
		if ((timeLapse < minimumGap) && (myPosition_array[i+1][0] != undefined )){
			 myPosition_array[i+1][0] += minimumGap - timeLapse;
		}
	}
}
correctTimes();
// Function to reset textfields to relevant Initial Format (Active/Optional Active)
function resetFormat(myTextCounter){
	if(myTextCounter <= 0){
		// Counter for all text to change format
		myFormatCounter = 0;
	}	
	theMovie.lyrics_mask_mc["my_lyric_"+myTextCounter].embedFonts = true;
	if (myTextCounter == myFormatChanges_Array[myFormatCounter]) {
		theMovie.lyrics_mask_mc["my_lyric_"+myTextCounter].setTextFormat(default_fmt_Active_Optional);
		myFormatCounter++;
	} else {
		theMovie.lyrics_mask_mc["my_lyric_"+myTextCounter].setTextFormat(default_fmt_Active);
	}
	// Set Border & Background
	theMovie.lyrics_mask_mc["my_lyric_"+myTextCounter].backgroundColor = myBackgroundColor;
	theMovie.lyrics_mask_mc["my_lyric_"+myTextCounter].background = false;		
	theMovie.lyrics_mask_mc["my_lyric_"+myTextCounter].borderColor = myBorderColor;
	theMovie.lyrics_mask_mc["my_lyric_"+myTextCounter].border = false;		
}
//________________________________________________________________________________
// CREATE TEXT FIELDS ~~~~~~~DO NOT CHANGE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Init Position of first text
var myTextPositionX = 0;
var myTextPositionY = 0;
// Counter for all text created
var myCounter = 0;
// Counter for all text to change format
var myFormatCounter = 0;
// Place all texts
for (i=0; i<myLyrics_array.length; i++) {
	if (myLyrics_array[i] == "$") {
		myTextPositionY += myTextPositionY$;
	} else if (myLyrics_array[i] == "$$") {
		myTextPositionY += myTextPositionY$$;
	}else if (myLyrics_array[i] == "$$$") {
		myTextPositionY += myTextPositionY$$$;
	} else if (myLyrics_array[i] == "$$$$") {
		myTextPositionX += myTextPositionX$$$$;
		myTextPositionY = 0;
	} else {
		theMovie.lyrics_mask_mc.createTextField("my_lyric_"+myCounter, theMovie.lyrics_mask_mc.getNextHighestDepth(), myTextPositionX, myTextPositionY, 0, 0);
		//Properties of Text
		theMovie.lyrics_mask_mc["my_lyric_"+myCounter].text = myLyrics_array[i];
		theMovie.lyrics_mask_mc["my_lyric_"+myCounter].autoSize = true;
		theMovie.lyrics_mask_mc["my_lyric_"+myCounter].selectable = false;
		//TEXT FORMAT
		resetFormat(myCounter)
		//________________________________________________________
		myCounter++;
	}
}
//***************************************************************
//************* SONG INIT / Reset *******************************
//***************************************************************
function initSong(){
	// VARS TO CONTROL KARAOKE LINES
	myNextArrayLine = 0;
	myCurrentArrayLine = -1;	
	//SPECIAL PARAMETER FOR STATIC MOTION!
	myNextKaraokeLine = 0;
	myCurrentKaraokeLine = -1;
	// Parameter to create a line change
	nextRefrainChange = 0;
	// Parameter to create a format change
	nextFormatChange = 0;
};
initSong();
//
function resetSong() {
	myStyleText5.text = "Song Reset!!"
	//
	initSong();
	// Reset all active textFields
	myCounter = 0;
	for (i=0; i<myLyrics_array.length; i++) {
		// Reset Format back to Acive or Active Optional
		if (myLyrics_array[i] != "$" && (myLyrics_array[i] != "$$")) {
			//TEXT FORMAT
			resetFormat(myCounter)
			myCounter++;			
		}
	}
	delete theMovie.onEnterFrame;	
}
//***************************************************************
//************* SONG EXECUTE ************************************
//***************************************************************
function songEnterFrame() {
	//DEBUG TEXT
	myStyleText1.text = "Song position:"+myPosition;
	myStyleText2.text = "Next Position to change:"+theMovie.myPosition_array[theMovie.myNextArrayLine][0];
	myStyleText3.text = "myNextArrayLine:"+theMovie.myNextArrayLine;
	myStyleText4.text = "myNextKaraokeLine:"+theMovie.myNextKaraokeLine;
	// Player Audio/Song Position ------------------------------------
	myPosition = Math.floor(this._parent.sound_obj.position/100);
	//***********************************************
	//CHANGE text format to the REPLACED Format ***********************************  
	if (myPosition>=theMovie.myPosition_array[theMovie.myNextArrayLine][0] and (theMovie.myNextArrayLine<myPosition_array.length)) {
		// EDITING FOR CORRECT LINE TO SHOW NEXT ----------------------------------
		// IF defined in myRefrainChanges_Array to stop the serial process then do it.
		if (theMovie.myNextArrayLine == myRefrainChanges_Array[nextRefrainChange][0]) {
			theMovie.myNextKaraokeLine = myRefrainChanges_Array[nextRefrainChange][1];
			nextRefrainChange++;
		}		
		// EDITING FOR ITALICS TO SHOW --------------------------------------- 
		if (theMovie.myNextKaraokeLine == myFormatChanges_Array[nextFormatChange]) {
			theMovie.lyrics_mask_mc["my_lyric_"+theMovie.myNextKaraokeLine].embedFonts = true;
			theMovie.lyrics_mask_mc["my_lyric_"+theMovie.myNextKaraokeLine].setTextFormat(default_fmt_replace_Optional);
			nextFormatChange++;
		} else {
			theMovie.lyrics_mask_mc["my_lyric_"+theMovie.myNextKaraokeLine].embedFonts = true;
			theMovie.lyrics_mask_mc["my_lyric_"+theMovie.myNextKaraokeLine].setTextFormat(default_fmt_replace);
		}
		//***************Border & Background**************************************
		theMovie.lyrics_mask_mc["my_lyric_"+theMovie.myNextKaraokeLine].background = true;
		theMovie.lyrics_mask_mc["my_lyric_"+theMovie.myNextKaraokeLine].border = true;
		// Number of current and next movie to highlight
		theMovie.myCurrentArrayLine = theMovie.myNextArrayLine;
		theMovie.myNextArrayLine += 1;
		//
		theMovie.myCurrentKaraokeLine = theMovie.myNextKaraokeLine;
		theMovie.myNextKaraokeLine += 1;
	//Change text BACK to the ACTIVE Format ***********************************                                             
	} else if (myPosition>=theMovie.myPosition_array[theMovie.myCurrentArrayLine][1]) {
		if (theMovie.myCurrentKaraokeLine == myFormatChanges_Array[nextFormatChange-1]) {
			theMovie.lyrics_mask_mc["my_lyric_"+theMovie.myCurrentKaraokeLine].embedFonts = true;
			theMovie.lyrics_mask_mc["my_lyric_"+theMovie.myCurrentKaraokeLine].setTextFormat(default_fmt_Active_Optional);
		} else {
			theMovie.lyrics_mask_mc["my_lyric_"+theMovie.myCurrentKaraokeLine].embedFonts = true;
			theMovie.lyrics_mask_mc["my_lyric_"+theMovie.myCurrentKaraokeLine].setTextFormat(default_fmt_Active);
		}
		//***************Border & Background**************************************
		theMovie.lyrics_mask_mc["my_lyric_"+theMovie.myCurrentKaraokeLine].background = false;
		theMovie.lyrics_mask_mc["my_lyric_"+theMovie.myCurrentKaraokeLine].border = false;
	}
}