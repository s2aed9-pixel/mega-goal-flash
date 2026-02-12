class listbox extends MovieClip {
	var length:Number;
	var selectedText:String;
	var locWidth:Number = 150;
	var locHeight:Number = 25;
	public var mouseListboxListener:Object;
	public var listboxMovie;
	function listbox() {
		this.mouseListboxListener = new Object();
		this.mouseListboxListener.onMouseMove = mouseListenerVTree_onMouseMove;
		this.listboxMovie = this;
		//trace("this.listboxMovie=" + this.listboxMovie._name);
		//trace("this._name=" + this._name);
		//trace("this._target=" + this._target);
		//trace("mouseListListener");
	}
	function populate(my_array:Array):Void {
		var myX:Number;
		var myY:Number;
		myX = 0;
		myY = 0;
		this["main_mc"].attachMovie("componentBackground", "background_mc", 0);
		this["main_mc"]["background_mc"]._width = locWidth;
		this["main_mc"]["background_mc"]._height = locHeight;
		this.length = my_array.length;
		for (var i = 0; i < my_array.length; i++) {
			this["main_mc"].createEmptyMovieClip("item" + i + "_mc", i + 1);
			this["main_mc"]["item" + i + "_mc"]._x = myX;
			this["main_mc"]["item" + i + "_mc"]._y = myY;
			box(this["main_mc"]["item" + i + "_mc"], locWidth, locHeight);
			this["main_mc"]["item" + i + "_mc"].createTextField("text_txt", 1, 0, 0, locWidth, locHeight);
			this["main_mc"]["item" + i + "_mc"].text_txt.text = my_array[i];
			this["main_mc"]["item" + i + "_mc"].text_txt.selectable = false;
			this["main_mc"]["item" + i + "_mc"].text = my_array[i];
			this["main_mc"]["item" + i + "_mc"].onRelease = item_mc_onRelease;
			myY = myY + this["main_mc"]["item" + i + "_mc"]._height;
		}
		this["background_mc"]._width = locWidth;
		this["background_mc"]._height = this["scrollVTree_mc"]._height;
		this.initScrollbar();
	}
	private function box(myObj:MovieClip, myWidth:Number, myHeight:Number):Void {
		myObj.createEmptyMovieClip("box_mc", 0);
		myObj.box_mc.beginFill(0xFFFFFF);
		myObj.box_mc.moveTo(0, 0);
		myObj.box_mc.lineTo(myWidth, 0);
		myObj.box_mc.lineTo(myWidth, myHeight);
		myObj.box_mc.lineTo(0, myHeight);
		myObj.box_mc.lineTo(0, 0);
		myObj.box_mc.endFill();
	}
	private function item_mc_onRelease():Void {
		for (var i = 0; i < this._parent._parent.length; i++) {
			var myColor = new Color(this._parent["item" + i + "_mc"]["box_mc"]);
			myColor.setRGB(0xffffff);
		}
		//this._xscale = this._yscale = 120;
		var myColor = new Color(this["box_mc"]);
		myColor.setRGB(0xEEEEEE);
		this._parent._parent.selectedText = this["text"];
		trace(this._parent._parent.selectedText);
		this._parent._parent.change();
	}
	function change():Void {
	}
	private function initScrollbar():Void {
		this["mask_mc"].swapDepths(101);
		this["main_mc"].setMask(this["mask_mc"]);
		this["scrollVTree_mc"]["sVUTree_mc"].onRelease = sVUTree_mc_onRelease;
		this["scrollVTree_mc"]["sVDTree_mc"].onRelease = sVDTree_mc_onRelease;
		if (this["main_mc"]._height < this["mask_mc"]._height) {
			var mainMaskHeight = this["mask_mc"]._height;
		}
		else {
			var mainMaskHeight = this["main_mc"]._height;
		}
		trace("mainHeight=" + this["main_mc"]._height);
		this["scrollVTree_mc"]["sVToolTree_mc"]._height = ((this["scrollVTree_mc"]["sVDTree_mc"]._y - this["scrollVTree_mc"]["sVUTree_mc"]._y - this["scrollVTree_mc"]["sVDTree_mc"]._height) / (mainMaskHeight / locHeight)) * this["mask_mc"]._height / locHeight;
		this["scrollVTree_mc"]["sVToolTree_mc"].onPress = sVToolTree_mc_onPress;
		this["scrollVTree_mc"]["sVToolTree_mc"].onRelease = sVToolTree_mc_onRelease;
		this["scrollVTree_mc"]["sVToolTree_mc"].onReleaseOutside = sVToolTree_mc_onRelease;
	}
	private function sVUTree_mc_onRelease() {
		if (this._parent._parent["main_mc"]._y < this._parent._parent["mask_mc"]._y) {
			this._parent._parent["main_mc"]._y = this._parent._parent["main_mc"]._y + this._parent._parent["main_mc"]["item0_mc"]._height;
			this._parent._parent["scrollVTree_mc"]["sVToolTree_mc"]._y = this._parent._parent["scrollVTree_mc"]["sVToolTree_mc"]._y - ((this._parent._parent["scrollVTree_mc"]["sVDTree_mc"]._y - this._parent._parent["scrollVTree_mc"]["sVUTree_mc"]._y - this._parent._parent["scrollVTree_mc"]["sVDTree_mc"]._height) / (this._parent._parent["main_mc"]._height / this._parent._parent["main_mc"]["item0_mc"]._height));
			if (this._parent._parent["scrollVTree_mc"]["sVToolTree_mc"]._y < this._parent._parent["scrollVTree_mc"]["sVUTree_mc"]._y + this._parent._parent["scrollVTree_mc"]["sVUTree_mc"]._height / 2) {
				this._parent._parent["scrollVTree_mc"]["sVToolTree_mc"]._y = this._parent._parent["scrollVTree_mc"]["sVUTree_mc"]._y + this._parent._parent["scrollVTree_mc"]["sVUTree_mc"]._height / 2;
			}
		}
	}
	private function sVDTree_mc_onRelease() {
		if (this._parent._parent["main_mc"]._y > this._parent._parent["mask_mc"]._y - (this._parent._parent["main_mc"]._height - this._parent._parent["mask_mc"]._height)) {
			this._parent._parent["main_mc"]._y = this._parent._parent["main_mc"]._y - this._parent._parent["main_mc"]["item0_mc"]._height;
			this._parent._parent["scrollVTree_mc"]["sVToolTree_mc"]._y = this._parent._parent["scrollVTree_mc"]["sVToolTree_mc"]._y + ((this._parent._parent["scrollVTree_mc"]["sVDTree_mc"]._y - this._parent._parent["scrollVTree_mc"]["sVUTree_mc"]._y - this._parent._parent["scrollVTree_mc"]["sVDTree_mc"]._height) / (this._parent._parent["main_mc"]._height / this._parent._parent["main_mc"]["item0_mc"]._height));
			if (this._parent._parent["scrollVTree_mc"]["sVToolTree_mc"]._y > this._parent._parent["scrollVTree_mc"]["sVDTree_mc"]._y - this._parent._parent["scrollVTree_mc"]["sVUTree_mc"]._height / 2 - this._parent._parent["scrollVTree_mc"]["sVToolTree_mc"]._height) {
				this._parent._parent["scrollVTree_mc"]["sVToolTree_mc"]._y = this._parent._parent["scrollVTree_mc"]["sVDTree_mc"]._y - this._parent._parent["scrollVTree_mc"]["sVUTree_mc"]._height / 2 - this._parent._parent["scrollVTree_mc"]["sVToolTree_mc"]._height;
			}
		}
	}
	private function sVToolTree_mc_onPress() {
		//trace("scrollPress");
		_root.listBoxTarget = this._parent._parent._target;
		this["myY"] = this._y;
		this["myYDifference"] = this._parent._parent._ymouse - this._y;
		//this._parent._parent.mouseListboxListener = new Object();
		//this._parent._parent.mouseListboxListener.onMouseMove = mouseListenerVTree_onMouseMove;
		//Mouse.addListener(this._parent._parent);
		Mouse.addListener(this._parent._parent.mouseListboxListener);
	}
	private function mouseListenerVTree_onMouseMove() {
		/*
		public function onMouseMove() {
		*/
		//trace("mouseMove");
		//trace(this.listboxMovie._name);
		//trace(eval(_root.listBoxTarget + "/scrollVTree_mc/sVUTree_mc._y"));
		//trace(this["scrollVTree_mc"]["sVUTree_mc"]._height / 2);
		//trace("thisScroll._target=" + this._target);
		var thisListbox = eval(_root.listBoxTarget);
		//trace(thisListbox._ymouse);
		//trace(thisListbox["scrollVTree_mc"]["sVUTree_mc"]._height / 2);
		var scrollPlacerTop = thisListbox["scrollVTree_mc"]["sVUTree_mc"]._y + thisListbox["scrollVTree_mc"]["sVUTree_mc"]._height / 2;
		var scrollPlacerBottomForTool = thisListbox["scrollVTree_mc"]["sVDTree_mc"]._y - thisListbox["scrollVTree_mc"]["sVDTree_mc"]._height / 2 - thisListbox["scrollVTree_mc"]["sVToolTree_mc"]._height;
		var numberOfLines = thisListbox["main_mc"]._height / thisListbox["main_mc"]["item0_mc"]._height;
		var scrollPlacerHeight = thisListbox["scrollVTree_mc"]["sVDTree_mc"]._y - thisListbox["scrollVTree_mc"]["sVUTree_mc"]._y - thisListbox["scrollVTree_mc"]["sVDTree_mc"]._height;
		var scrollPiecesHeight = scrollPlacerHeight / numberOfLines;
		if ((thisListbox._ymouse - thisListbox["scrollVTree_mc"]["sVToolTree_mc"]["myYDifference"] > scrollPlacerTop) and (thisListbox._ymouse - thisListbox["scrollVTree_mc"]["sVToolTree_mc"]["myYDifference"] < scrollPlacerBottomForTool)) {
			thisListbox["scrollVTree_mc"]["sVToolTree_mc"]._y = thisListbox._ymouse - thisListbox["scrollVTree_mc"]["sVToolTree_mc"]["myYDifference"];
			thisListbox["scrollVTree_mc"]["sVToolTree_mc"]._y = scrollPlacerTop + ((Math.round((thisListbox["scrollVTree_mc"]["sVToolTree_mc"]._y - scrollPlacerTop) / scrollPiecesHeight)) * scrollPiecesHeight);
			//trace("testScroll=" + ((Math.round((thisMovie.scrollText_mc.scrollTool_mc._y - scrollPlacerTop) / scrollPiecesHeight))));
			thisListbox["main_mc"]._y = thisListbox["mask_mc"]._y - ((Math.round((thisListbox["scrollVTree_mc"]["sVToolTree_mc"]._y - scrollPlacerTop) / scrollPiecesHeight))) * thisListbox["main_mc"]["item0_mc"]._height;
			//thisMovie.text_txt.scroll = (Math.round((thisMovie.scrollText_mc.scrollTool_mc._y - scrollPlacerTop) / scrollPiecesHeight)) + 1;
		}
	}
	private function sVToolTree_mc_onRelease() {
		//trace("scrollRelease");
		_root.listBoxTarget = undefined;
		var thisListbox = eval(_root.listBoxTarget);
		Mouse.removeListener(thisListbox["mouseListboxListener"]);
		//Mouse.removeListener(this._parent._parent);
		//delete thisListbox["scrollVTree_mc"]["sVToolTree_mc"].onRelease;
		//delete thisListbox["scrollVTree_mc"]["sVToolTree_mc"].onReleaseOutside;
	}
}
