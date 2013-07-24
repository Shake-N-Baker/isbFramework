package isbFramework 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * A state driven sprite to be used with the rest of the framework.
	 * The state sprite will make use of states to change the current
	 * sprite to static and/or animating sprites of different types.
	 * The sprite sheet must contain all of the sprites to be used for
	 * all of the various states.
	 * 
	 * Usage:
		 * var hero:isbStateSprite = new isbStateSprite(bitmapDataSpriteSheet, x, y);
		 * hero.addState("down", [R.HERO_DOWN1]);
		 * hero.addState("downWalk", [R.HERO_DOWN1, R.HERO_DOWN2, R.HERO_DOWN1, R.HERO_DOWN3], [10, 10, 10, 10]);
		 * ...
		 * hero.state = "downWalk";
		 * ...
		 * hero.updateSprite(1.23); <-- 123% animation speed
		 * isbScreen.buffer.copyPixels(hero.bitmapData, hero.rectangle, hero.point);
	 * 
	 * @author Ian Baker
	 */
	public class isbStateSprite extends isbSprite
	{
		/**
		 * Default constant, state sprites will default to the entire
		 * sprite sheet being shown
		 */
		public static const DEFAULT:String = "default";
		
		/**
		 * State properties
		 * 
		 * (inherited) bitmapData - Sprite sheet containing all state sprites
		 * 
		 * Two parallel arrays:
		 * 	states - Names of states of this sprite
		 * 	sprites - Cooresponding animated sprites for each state
		 * 
		 * curState - The current state of the sprite
		 */
		private var _states:Vector.<String>;
		private var _sprites:Vector.<isbAnimationSprite>;
		private var _curState:String;
		
		/**
		 * Constructor, packages the parameters into the isbAnimationSprite.
		 * 
		 * @param	spriteSheet - Sprite sheet image to use
		 * @param	x - X-Coordinates to draw image
		 * @param	y - Y-Coordinates to draw image
		 */
		public function isbStateSprite(spriteSheet:BitmapData, x:int = 0, y:int = 0, offset:Point = null) 
		{
			super(spriteSheet, x, y, offset);
			this._states = new Vector.<String>();
			this._sprites = new Vector.<isbAnimationSprite>();
			this._curState = isbStateSprite.DEFAULT;
		}
		
		/**
		 * Add a new state to the sprite.
		 * 
		 * @param	state - State name
		 * @param	rects - Source rectangles for the sprite sheet, defaults to the entire bitmapData
		 * @param	frames - Frames to hold the sprite in an animation, defaults to single frames for animations
		 * @param	offsets - Sprite offsets for the sprite to be drawn at, defaults to zero points
		 */
		public function addState(state:String, rects:Array = null, frames:Array = null, offsets:Array = null):void 
		{
			if (this._states.indexOf(state) == -1) {
				this._states.push(state);
				if (rects != null) {
					if (rects.length > 1) {
						// Animating sprite
						var animSprite:isbAnimationSprite = new isbAnimationSprite(this._bitmapData, this._x, this._y);
						// Offsets and frames default to zero point and 1 frame long
						if (offsets == null) {
							offsets = new Array();
							for (var i:int = 0; i < rects.length; i++) 
							{
								offsets.push(new Point());
							}
						}
						if (frames == null) {
							frames = new Array();
							for (i = 0; i < rects.length; i++) 
							{
								offsets.push(1);
							}
						}
						animSprite.addAnimations(rects, frames, offsets);
						this._sprites.push(animSprite);
					} else {
						// Single static sprite with source rectangle and possibly an offset
						var bd:BitmapData = new BitmapData(rects[0].width, rects[0].height);
						bd.copyPixels(this._bitmapData, rects[0], new Point());
						if (offsets != null) {
							this._sprites.push(new isbAnimationSprite(bd, this._x, this._y, offsets[0]));
						} else {
							this._sprites.push(new isbAnimationSprite(bd, this._x, this._y));
						}
					}
				} else {
					// Default single static sprite with spritesheet as the sprite image
					this._sprites.push(new isbAnimationSprite(this._bitmapData, this._x, this._y));
				}
			} else {
				trace("Duplicate state in stateSprite: " + this + ", state = " + state);
			}
		}
		
		/**
		 * Update the current sprite.
		 * 
		 * @param	speed - The speed with which to update the sprite
		 */
		public function updateSprite(speed:Number = 1):void 
		{
			if (this._states.indexOf(this._curState) != -1) {
				this._sprites[this._states.indexOf(this._curState)].updateSprite(speed);
			}
		}
		
		/**
		 * Current state of the sprite.
		 */
		public function get state():String
		{
			return this._curState;
		}
		
		/**
		 * Current state of the sprite.
		 */
		public function set state(value:String):void 
		{
			this._curState = value;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get bitmapData():BitmapData 
		{
			if (this._curState == isbStateSprite.DEFAULT) {
				return this._bitmapData;
			} else if (this._states.indexOf(this._curState) != -1) {
				return this._sprites[this._states.indexOf(this._curState)].bitmapData;
			} else {
				return new BitmapData(0, 0);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get point():Point
		{
			var pt:Point = new Point();
			if (this._curState == isbStateSprite.DEFAULT) {
				pt.x += this._point.x + this._offset.x;
				pt.y += this._point.y + this._offset.y;
			} else if (this._states.indexOf(this._curState) != -1) {
				var index:int = this._states.indexOf(this._curState);
				pt.x += this._point.x + this._offset.x + this._sprites[index].offset.x;
				pt.y += this._point.y + this._offset.y + this._sprites[index].offset.y;
			} else {
				pt.x += this._point.x + this._offset.x;
				pt.y += this._point.y + this._offset.y;
			}
			return pt;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get rectangle():Rectangle 
		{
			if (this._curState == isbStateSprite.DEFAULT) {
				return this._bitmapData.rect;
			} else if (this._states.indexOf(this._curState) != -1) {
				return this._sprites[this._states.indexOf(this._curState)].rectangle;
			} else {
				return new Rectangle();
			}
		}
	}
}