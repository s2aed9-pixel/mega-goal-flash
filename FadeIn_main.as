//Fades in on Init activity

function fadeIn_onEnterFrame() {
	//trace("fadeIn_onEnterFrame")
	this.counter++;
	if (this.counter >= 5) {
		this._alpha-= 10;
		if (this._alpha <= 0) {
			delete this.onEnterFrame;
			this._visible=false;
			//
			//backNext_CheckEnabled(BackNextGo);
		}
	}
}
//
function fadeOut_onEnterFrame() {
	//trace("fadeOut_onEnterFrame")
	this.counter++;
	if (this.counter >= 5) {
		this._alpha+= 20;
		if (this._alpha >= 100) {
			delete this.onEnterFrame;
			//this._visible=false;
			if (BackNextGo == "back"){
				back_btnFunction();
			} else if (BackNextGo == "next"){
				next_btnFunction();
			}
		}
	}
}
//
var BackNextGo:String = "none";

function initFaderIn(){
	//trace("initFaderIn")
	delete theMovie.fadeIn_mc.onEnterFrame;
	//theMovie.fadeIn_mc._visible=false
	//
	theMovie.fadeIn_mc._alpha=100
	theMovie.fadeIn_mc.counter=0;
	theMovie.fadeIn_mc.onEnterFrame=fadeIn_onEnterFrame;
	theMovie.fadeIn_mc._visible=true;
}
function initFaderOut(backNextGo:String){
	//trace("initFaderOut")
	BackNextGo = backNextGo;
	delete theMovie.fadeIn_mc.onEnterFrame;
	//
	theMovie.fadeIn_mc._alpha=0;
	theMovie.fadeIn_mc.counter=0;
	theMovie.fadeIn_mc.onEnterFrame=fadeOut_onEnterFrame;
	theMovie.fadeIn_mc._visible=true;
}

