//30-9-2011 --- more than 1 colours for correct answers 
stop();
var colours_rgb = [0xFC181E, 0xFFFF33, 0x0066FF, 0xFAA61A, 0x1EB256, 0xF59395,    0x78AC00, 0xED0000, 0xFF76D1, 0x24830F,0x894E45,0x000000,0xBD1A8D,0xFFFFFF]; 
var colours_name = ["red", "yellow", "blue", "orange", "green", "pink",      "khaki", "red1", "pink1","lime","brown","black","purple","white"];
var correct=0;
var wrong=0;
var currentcolour = "";
var currentRGB
var mySoundFile:Sound = new Sound(theMovie);
//
function select_colour() {
	for (i=0; i<colours_name.length; i++) {
		theMovie["colour"+i].gotoAndStop(1);
	}
	this.gotoAndStop(2);
	currentcolour = this.colourname;
	currentRGB=this.mycolour;
	for (i=0; i<items_name.length; i++) {
		if (theMovie["item"+i].put == 0) {
			theMovie["item"+i].enabled = true;
		}
	}
}
//
function checking() {
	if (currentcolour<>"") {
		if (type == 1) {
			checkColour="none";
			for (i=0; i<this.colourArray.length; i++) {
				if (this.colourArray[i] == currentcolour) {
					checkColour="found";
					break;
				}
			}
			if (checkColour=="found"){
					playRightAnswer();
					mycolour = new Color(this);
					mycolour.setRGB(currentRGB);
					this.put = 1;
					this.enabled = false;
					correct++;
					theMovie["item"+this.id+"_ex"]._visible = false;
					if (correct == items_name.length) {
						for (i=0; i<colours_name.length; i++) {
							theMovie["colour"+i].gotoAndStop(1);
							theMovie["colour"+i].enabled = false;
						}
					}
				} else{
					if (theMovie.muteColourSound==false){
					    playWrongAnswer();
					}
				}
			
		} else {
			if (theMovie.muteColourSound==false){
			    playRightAnswer();
			}
			//correct_sound();
			mycolour = new Color(this);
			mycolour.setRGB(currentRGB);
		}
	}
}
//
function correct_sound() {
	soundPlay = "sounds/correct.mp3";
	var mySoundFile:Sound = new Sound();
	mySoundFile.loadSound(soundPlay, true);
}
//
function wrong_sound() {
	soundPlay = "sounds/wrong.mp3";
	var mySoundFile:Sound = new Sound();
	mySoundFile.loadSound(soundPlay, true);
}
//
function init() {
	trace("aaa")
	for (i=0; i<items_name.length; i++) {
		theMovie["item"+i].id = i;
		theMovie["item"+i].mycolour = items_rgb[i];
        theMovie["item"+i].colourArray=new Array()
		theMovie["item"+i].colourArray = items_name[i];
		theMovie["item"+i].put = 0;
		theMovie["item"+i].onRelease = checking;
		theMovie["item"+i].enabled = false;
		whitecolour = new Color(theMovie["item"+i]);
		//whitecolour.setRGB(0xFFFFFF);
		whitecolour.setRGB(theMovie.startColor);
	}
	for (i=0; i<colours_name.length; i++) {
		theMovie["colour"+i].id = i;
		theMovie["colour"+i].mycolour = colours_rgb[i];
		theMovie["colour"+i].colourname = colours_name[i];
		theMovie["colour"+i].onRelease = select_colour;
		theMovie["colour"+i].gotoAndStop(1);
		theMovie["colour"+i].enabled = true;
	}
}
init();