stop();
var listenSound=new Sound(theMovie);
var totalSounds:Number;
//
function initSounds(mySounds:Number,showSpeakers:Boolean) {
	totalSounds=mySounds;
	for (i=0; i < mySounds; i++) {
		theMovie["sp" + i + "_mc"].gotoAndStop(1);
		theMovie["sp" + i + "_mc"].mysound=i;
		theMovie["sp" + i + "_mc"].pressed=0;
		theMovie["sp" + i + "_mc"].onRelease=playAudio;
		theMovie["sp" + i + "_mc"]._alpha=(theMovie.showSpeakers == false?0:100);
	}
}
//
function playAudio() {
	if (this.pressed==0){
		//
		if (showPlayer == 1) {
			//theMovie._parent.InitPlayer(theMovie.soundsPath + "audio.mp3");
			//theMovie._parent.pauseit();
			theMovie._parent.stopit();
		}
		//
		for (i=0; i < totalSounds; i++) {
		    theMovie["sp" + i + "_mc"].pressed=0;
			theMovie["sp" + i + "_mc"].gotoAndStop(1);
		}
		this.pressed=1;
		this.gotoAndStop(2);
//	    soundPlay=theMovie.soundsPath + String(this.mysound + ".mp3");
//		trace("heMovie.soundsPath:"+heMovie.soundsPath);		
		soundPlay = theMovie.soundsPath + String(this.mysound + ".mp3");
//		trace("soundPlay:"+soundPlay);
        //soundPlay=myMainPath + String(this.mySound + ".mp3");
	    listenSound.loadSound(soundPlay,true);
//        trace("soundPlay:"+soundPlay);

	    //soundPlay=theMovie.audioPath + String(this.mysound + ".mp3");
	    //listenSound.loadSound(soundPlay,true);
		listenSound.onSoundComplete=function(){
			for (i=0; i < totalSounds; i++) {
				theMovie["sp" + i + "_mc"].pressed=0;
				theMovie["sp" + i + "_mc"].gotoAndStop(1);
			}
		}
	} else {
		if (showPlayer == 1) {
			//theMovie._parent.playit();
		}
		debug.text = "stopped"
		listenSound.stop();
		this.pressed=0;
		this.gotoAndStop(1);
	}
}
initSounds(theMovie.exerciseTotalSounds)