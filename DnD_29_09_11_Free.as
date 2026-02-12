//MOD:29/9/11 - No check button

function passTheArray2Array(old_array:Array, new_array:Array) {
	for (var i = 0; i < old_array.length; i++) {
		var temp = old_array[i];
		if (temp[0] <> undefined) {
			var t_array:Array = new Array();
			passTheArray2Array(temp,t_array);
			var pushed:Number = new_array.push(t_array);
		} else {
			var pushed:Number = new_array.push(temp);
		}
	}
}
function checkOne_mc_onRelease() {
var dropName = "place"+this.myPlaceID+"_mc";
var dragName = "item"+theMovie[dropName].myItemId+"_mc";
var audioJustifyName = "audioJustify_"+this.myPlaceID;
var textJustifyName = "i"+this.myPlaceID+"_mc";
var myNumPlace = theMovie[dropName].myCat;
if (theMovie[dropName].lockPlace == 1) {
	theMovie[dragName].enabled = false;
	theMovie.rightPlace = [];
	passTheArray2Array(rightPlaceToUse,theMovie.rightPlace);
	var foundCorrect = 0;
	if (this._currentframe == 1) {
		//this.gotoAndStop(2);
		var checkOK = 0;
		for (var j = 0; j<theMovie.maxPlaces; j++) {
			checkOK = 0;
			myArrayItems = theMovie.rightPlace[myNumPlace];
			for (var m = 0; m<myArrayItems.length; m++) {
				//*********************************************	
				if (theMovie[dragName].myNo == myArrayItems[m]) {
					checkOK = 1;
					theMovie.rightPlace[myNumPlace][m] = -1;
					theMovie[dragName].my_txt.textColor = 0x009900;
					playRightAnswer();
					this.gotoAndStop(4);
					
					// AUDIOScript Justification
					theMovie[audioJustifyName]._visible = true;
					theMovie[audioJustifyName].gotoAndStop(1);
					theMovie[audioJustifyName].pressed = false;
					// ShowText Justification
					theMovie[textJustifyName]._visible = true;
					theMovie[textJustifyName].gotoAndStop(1);
					theMovie[textJustifyName].pressed = false;
					
					//****************************************
					foundCorrect = 1
					
					// DISACTIVATED Version 1 Check ALL
					/*if (theMovie.itemsWillSubsAccToPlace) {
						theMovie[dragName].my_txt.text = theMovie.itemsSubstitute_array[theMovie.rightPlaceToUse[hitI][hitJ]];
					} else {*/
						theMovie[dragName].my_txt.text = theMovie.itemsSubstitute_array[theMovie[dragName].myId];
					//}					
				}
			}
			if (checkOK == 0 && foundCorrect ==0) {
				theMovie[dragName].my_txt.textColor = 0xFF0000;
				playWrongAnswer()
				this.gotoAndStop(5);
				// AUDIOScript Justification
				theMovie[audioJustifyName]._visible = true;
				theMovie[audioJustifyName].gotoAndStop(1);
				theMovie[audioJustifyName].pressed = false;
				// ShowText Justification
				theMovie[textJustifyName]._visible = true;
				theMovie[textJustifyName].gotoAndStop(1);
				theMovie[textJustifyName].pressed = false;
			}
		} //FOR	
	} else {
		this.gotoAndStop(1);
		theMovie[dragName].enabled = true;
		theMovie[dragName].my_txt.textColor = theMovie[dragName].myTextColor;
		// AUDIOScript Justification
		theMovie[audioJustifyName]._visible = false;
		theMovie[audioJustifyName].gotoAndStop(1);
		theMovie[audioJustifyName].pressed = false;
		// ShowText Justification
		theMovie[textJustifyName]._visible = false;
		theMovie[textJustifyName].gotoAndStop(1);
		theMovie[textJustifyName].pressed = false;
	}//IF
}
//************** theMovie._parent.checkAll_mc **********************			
		var checkDownButton = 0;
		for (var i = 0; i < theMovie.maxCategories; i++) {
			for (var j = 0; j < theMovie.maxPlaces; j++) {
				if (theMovie["ddCheck" + i + "" + j + "_mc"]._currentframe == 1) {
						checkDownButton = 1;
				}
			}
		}
		//debug.text = checkDownButton
		/*if (checkDownButton == 0){
			theMovie._parent.checkAll_mc.clicked = 1;
			theMovie._parent.checkAll_mc.gotoAndStop(3);
			theMovie._parent.checkAll_mc.enabled = true;
		} else {
			theMovie._parent.checkAll_mc.clicked = 0;
			theMovie._parent.checkAll_mc.gotoAndStop(1);
			theMovie._parent.checkAll_mc.enabled = true;
		}*/
//*********************************************
}
function checkAllBut_mc_onRelease() {
	if (this._currentframe == 1) {
		this.gotoAndStop(3);
		theMovie.rightPlace = [];
		passTheArray2Array(rightPlaceToUse,theMovie.rightPlace);
		//trace("rightPlace"+theMovie.rightPlace)
		for (var i = 0; i < theMovie.items_array.length; i++) {
			//theMovie["item" + i + "_mc"].enabled = false;
		}
		var dropName = "";
		var checkOK = 0;
		for (var i = 0; i < theMovie.maxCategories; i++) {
			for (var j = 0; j < theMovie.maxPlaces; j++) {
				checkOK = 0
				dropName = "place" + i + j + "_mc";
				myNumPlace = theMovie[dropName].myCat;
				dragName = "item" + theMovie[dropName].myItemId + "_mc";
				trace("lockPlace "+theMovie[dropName].lockPlace)
				if (theMovie[dropName].lockPlace == 1) {
					myArrayItems = theMovie.rightPlace[myNumPlace];
					theMovie[dragName].enabled = false;
					for (var m = 0; m < myArrayItems.length; m++) {
						if (theMovie[dragName].myNo == myArrayItems[m]) {
							checkOK = 1;
							theMovie.rightPlace[myNumPlace][m] = -1;
							theMovie[dragName].my_txt.textColor = 0x009900;
							theMovie["ddCheck" + i + j + "_mc"].gotoAndStop(4)
							//theMovie["ddCheck" + i + j + "_mc"].enabled=false;
							// AUDIOScript Justification
							theMovie["audioJustify_"+i+""+j]._visible = true;
							theMovie["audioJustify_"+i+""+j].gotoAndStop(1);
							theMovie["audioJustify_"+i+""+j].pressed = false;
							// ShowText Justification
							theMovie["i"+i+""+j+"_mc"]._visible = true;
							theMovie["i"+i+""+j+"_mc"].gotoAndStop(1);
							theMovie["i"+i+""+j+"_mc"].pressed = false;
							
							// DISACTIVATED Version 1 Check ALL
							/*if (theMovie.itemsWillSubsAccToPlace) {
								theMovie[dragName].my_txt.text = theMovie.itemsSubstitute_array[theMovie.rightPlaceToUse[hitI][hitJ]];
							} else {*/
								theMovie[dragName].my_txt.text = theMovie.itemsSubstitute_array[theMovie[dragName].myId];
							//}
						}
					}
					if (checkOK == 0) {
						theMovie[dragName].my_txt.textColor = 0xFF0000;
						theMovie["ddCheck" + i + j + "_mc"].gotoAndStop(5)
						//theMovie["ddCheck" + i + j + "_mc"].enabled=false;
						// AUDIOScript Justification
						theMovie["audioJustify_"+i+""+j]._visible = true;
						theMovie["audioJustify_"+i+""+j].gotoAndStop(1);
						theMovie["audioJustify_"+i+""+j].pressed = false;
						// ShowText Justification
						theMovie["i"+i+""+j+"_mc"]._visible = true;
						theMovie["i"+i+""+j+"_mc"].gotoAndStop(1);
						theMovie["i"+i+""+j+"_mc"].pressed = false;
					}
				} //IF
			} //FOR
		}//FOR
	} else {
		//theMovie._parent.checkAll_mc.gotoAndStop(1);
		for (var i = 0; i < theMovie.items_array.length; i++) {
			theMovie["item" + i + "_mc"].enabled = true;
			theMovie["item" + i + "_mc"].my_txt.textColor = theMovie["item" + i + "_mc"].myTextColor;
		}
		
		for (var i = 0; i < theMovie.maxCategories; i++) {
			for (var j = 0; j < theMovie.maxPlaces; j++) {
				_mc.currentFrame
				if (theMovie["ddCheck" + i + j + "_mc"]._currentframe!=3){
					theMovie["ddCheck" + i + j + "_mc"].gotoAndStop(1)
					theMovie["ddCheck" + i + j + "_mc"].enabled=true;
				}
				// AUDIOScript Justification
				theMovie["audioJustify_"+i+""+j]._visible = false;
				theMovie["audioJustify_"+i+""+j].gotoAndStop(1);
				theMovie["audioJustify_"+i+""+j].pressed = false;
				// ShowText Justification
				theMovie["i"+i+""+j+"_mc"]._visible = false;
				theMovie["i"+i+""+j+"_mc"].gotoAndStop(1);
				theMovie["i"+i+""+j+"_mc"].pressed = false;
			}
		}		
	}
}
function solutionBut_mc_onRelease() {
	if (this._currentframe == 1) {
		this.gotoAndStop(3);
		//theMovie._parent.checkAll_mc.rightframe = theMovie._parent.checkAll_mc._currentframe;
		//theMovie._parent.checkAll_mc.gotoAndStop(2)
		theMovie.solution_mc._visible = true;
		theMovie.solution_mc.whiteDnD_mc._visible = !showItemShadows;
		for (var i = 0; i < theMovie.items_array.length; i++) {
			for (var j = 0; j < theMovie.maxPlaces; j++) {
				theMovie["item" + i + "_mc"]._visible = false;
				theMovie["ddCheck" + i + j + "_mc"].goframe = theMovie["ddCheck" + i + j + "_mc"]._currentframe;
				theMovie["ddCheck" + i + j + "_mc"].gotoAndStop(3)
			
				// AUDIOScript Justification
				theMovie["audioJustify_"+i+""+j]._visible = true;
				theMovie["audioJustify_"+i+""+j].gotoAndStop(1);
				theMovie["audioJustify_"+i+""+j].pressed = false;
				// ShowText Justification
				theMovie["i"+i+""+j+"_mc"]._visible = true;
				theMovie["i"+i+""+j+"_mc"].gotoAndStop(1);
				theMovie["i"+i+""+j+"_mc"].pressed = false;
			}
		}
	} else {
		//theMovie._parent.showAll_mc.gotoAndStop(1);
		theMovie.solution_mc._visible = false;
		//theMovie._parent.checkAll_mc.enabled = true;
		//theMovie._parent.checkAll_mc.gotoAndStop(theMovie._parent.checkAll_mc.rightframe)
		for (var i = 0; i < theMovie.items_array.length; i++) {
			for (var j = 0; j < theMovie.maxPlaces; j++) {
				theMovie["item" + i + "_mc"]._visible = true;
				theMovie["ddCheck" + i + j + "_mc"].gotoAndStop(theMovie["ddCheck" + i + j + "_mc"].goframe)
				if (theMovie["ddCheck" + i + j + "_mc"].goframe != 4 && theMovie["ddCheck" + i + j + "_mc"].goframe != 5){
					// AUDIOScript Justification
					theMovie["audioJustify_"+i+""+j]._visible = false;
					theMovie["audioJustify_"+i+""+j].gotoAndStop(1);
					theMovie["audioJustify_"+i+""+j].pressed = false;
					// ShowText Justification
					theMovie["i"+i+""+j+"_mc"]._visible = false;
					theMovie["i"+i+""+j+"_mc"].gotoAndStop(1);
					theMovie["i"+i+""+j+"_mc"].pressed = false;
				}
			}
		}
	}
}
function playTheSound(currSound) {
	stopAllSounds();
	theMovie.theSound.attachSound(currSound);
	theMovie.theSound.start();
}

function itemX_mc_onRelease() {
	stopDrag();
	this.swapDepths(this.myDepth);
	var hitTheRoad = -1;
	var hitI, hitJ;
	//var checkOK = 0;
	var dropName = "";
	for (var i = 0; i < theMovie.maxCategories; i++) {
		for (var j = 0; j < theMovie.maxPlaces; j++) {
			if (this.hit_mc.hitTest(theMovie["place" + i + j + "_mc"].hit_mc)) {
				hitTheRoad = i + "" + j;
				hitI = i;
				hitJ = j;
				dropName = "place" + hitTheRoad + "_mc";
			}
		}
	}
				
	
	
	myNumPlace = theMovie[dropName].myCat;
	//------------------------
	if ((hitTheRoad <> -1) && (theMovie[dropName].lockPlace == 0)) {
		this._x = theMovie["place" + hitTheRoad + "_mc"]._x;
		this._y = theMovie["place" + hitTheRoad + "_mc"]._y;
		this.myPlaceNum = hitTheRoad;
		theMovie[dropName].lockPlace = 1;
		theMovie[dropName].myItemId = this.myId;
		theMovie["ddCheck" + hitTheRoad + "_mc"].gotoAndStop(1)
		theMovie["ddCheck" + hitTheRoad + "_mc"].enabled=true;
		this.Place_1._visible = (theMovie.itemAppearanceAfter.hideFrame ? false : true);
		//
		//theMovie._parent.checkAll_mc.gotoAndStop(1);
		//theMovie._parent.checkAll_mc.enabled = true;
		//Used in Substitute activities to show relevant changed word.
		if (theMovie.itemsWillSubsAccToPlace) {
			this.my_txt.text = theMovie.itemsSubstitute_array[this.myId];
		} 
	} else {
		this._x = this.prevX;
		this._y = this.prevY;
		this.Place_1._visible = (theMovie.itemAppearanceBefore.hideFrame ? false : true);
		//
	
		var checkDownButton = 0;
		for (var i = 0; i < theMovie.maxCategories; i++) {
			for (var j = 0; j < theMovie.maxPlaces; j++) {
				if (theMovie["ddCheck" + i + "" + j + "_mc"]._currentframe <> 3) {
					checkDownButton = 1;
				}
			}
		}
		if (checkDownButton == 0) {
			//theMovie._parent.checkAll_mc.gotoAndStop(2);
			//theMovie._parent.checkAll_mc.enabled = false;
		}
		//Used in Substitute activities to show relevant changed word.
		if (theMovie.itemsWillSubsAccToPlace) {
			this.my_txt.text = theMovie.items_array[this.myId];
		} 		
	}
}
/*

*/
function itemX_mc_onPress() {
	this.swapDepths(5000);
	this.startDrag();
	trace("this.myPlaceNum "+this.myPlaceNum)
	if (this.myPlaceNum != -1) {
		theMovie["ddCheck" +this.myPlaceNum + "_mc"].gotoAndStop(3)
		theMovie["ddCheck" + this.myPlaceNum + "_mc"].enabled=false;
		theMovie["place" + this.myPlaceNum + "_mc"].lockPlace = 0;
		theMovie["place" + this.myPlaceNum + "_mc"].myItemId = -1;
		trace("this.placeRESETTT "+this.myPlaceNum)
	}
	this.myPlaceNum = -1;
}
/*

*/
function initDragNDropCat() {
	theMovie.rightPlace = [];
	passTheArray2Array(rightPlaceToUse,theMovie.rightPlace);
	for (var i = 0; i < theMovie.titles_array.length; i++) {
		theMovie["title" + i + "_mc"].my_txt.text = theMovie.titles_array[i];
	}
	for (var i = 0; i < theMovie.maxCategories; i++) {
		for (var j = 0; j < theMovie.maxPlaces; j++) {
			theMovie["place" + i + j + "_mc"].myCat = i;
			theMovie["place" + i + j + "_mc"].lockPlace = 0;
			theMovie["place" + i + j + "_mc"].myItemId = -1;
			theMovie["place" + i + j + "_mc"].my_txt.text = theMovie.rightPlaceText_array[i][j];
			//------------------------------------
			theMovie["ddCheck" + i + j + "_mc"].gotoAndStop(3)
			theMovie["ddCheck" + i + j + "_mc"].enabled=false;
			theMovie["ddCheck" + i + j + "_mc"].myPlaceID = i +""+ j
			theMovie["ddCheck" + i + j + "_mc"].onRelease = checkOne_mc_onRelease
		}
	}
	for (var i = 0; i < theMovie.items_array.length; i++) {
		theMovie["item" + i + "_mc"]._visible = true;
		theMovie["item" + i + "_mc"].myNo = theMovie.assignMyNo_array[i];
		theMovie["item" + i + "_mc"].myId = i;
		theMovie["item" + i + "_mc"].my_txt.text = theMovie.items_array[i];		
		theMovie["item" + i + "_mc"].my_txt.textColor = 0x0066CC
		theMovie["item" + i + "_mc"].myTextColor = 0x0066CC
		theMovie["item" + i + "_mc"].myDepth = theMovie["item" + i + "_mc"].getDepth();
		theMovie["item" + i + "_mc"].prevX = theMovie["item" + i + "_mc"]._x;
		theMovie["item" + i + "_mc"].prevY = theMovie["item" + i + "_mc"]._y;
		theMovie["item" + i + "_mc"].myPlaceNum = -1;
		theMovie["item" + i + "_mc"].onPress = itemX_mc_onPress;
		theMovie["item" + i + "_mc"].onRelease = itemX_mc_onRelease;
		theMovie["item" + i + "_mc"].onReleaseOutside = itemX_mc_onRelease;
		//
		this.Place_1._visible = (theMovie.itemAppearanceBefore.hideFrame ? false : true);
		var my_fmt:TextFormat = new TextFormat();
		theMovie["itemShadow" + i + "_mc"].my_txt.text = theMovie.items_array[i];
	}
	theMovie.solution_mc.swapDepths(theMovie.solution_mc.myDepth);
	//theMovie._parent.showAll_mc.onRelease = solutionBut_mc_onRelease;
	//theMovie._parent.checkAll_mc.onRelease = checkAllBut_mc_onRelease;
	//theMovie._parent.checkAll_mc.gotoAndStop(2);
	//theMovie._parent.checkAll_mc.enabled = false;
	theMovie.solution_mc._visible = false;
	for (var i = 0; i < theMovie.maxCategories; i++) {
		for (var j = 0; j < theMovie.maxPlaces; j++) {
			myItemName = rightPlaceToUse[i][j];
			theMovie.solution_mc["p" + i + j + "_mc"].my_txt.text = theMovie.itemsSubstitute_array[myItemName];
			theMovie.solution_mc["p" + i + j + "_mc"].Place_1._visible = (theMovie.itemAppearanceAfter.hideFrame ? false : true);
		}
	}
}
/*

*/
function resetDragNDropCat() {
	for (var i = 0; i < theMovie.items_array.length; i++) {
		theMovie["item" + i + "_mc"]._x = theMovie["item" + i + "_mc"].prevX;
		theMovie["item" + i + "_mc"]._y = theMovie["item" + i + "_mc"].prevY;
		theMovie["item" + i + "_mc"].enabled = true;
	}
	initDragNDropCat();
}

initDragNDropCat();