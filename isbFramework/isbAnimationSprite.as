package isbFramework 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * An animated sprite to be used with the rest of the framework.
	 * Animation sprite makes use of a sprite sheet with all of the
	 * sprites to be drawn and the source rectangles of where those
	 * specific sprites are. The offsets of each sprite as well as the
	 * total time to hold each sprite in the animation is also required.
	 * Optionally an animated sprite with no animations will use the
	 * sprite sheet as a non-animating single frame sprite.
	 * 
	 * Usage:
		 * var animSprite:isbAnimationSprite = new isbAnimationSprite(bitmapData, x, y);
		 * animSprite.addAnimations(rects, frames, offsets);
		 * ...
		 * animSprite.updateSprite(0.67); <-- 67% animation speed
		 * isbScreen.buffer.copyPixels(animSprite.bitmapData, animSprite.rectangle, animSprite.point);
	 * 
	 * @author Ian Baker
	 */
	public class isbAnimationSprite extends isbSprite
	{
		/**
		 * Animation properties
		 * 
		 * (inherited) bitmapData - Sprite sheet containing animation sprites
		 * 
		 * Three parallel arrays:
		 * 	sourceSprites - Sprite source rectangles to use throughout the animation
		 * 	offsets - Point offsets to draw the image current animation sprite at
		 * 	frames - Frames to hold the sprite in the animation
		 * 
		 * curFrame - The current frame of the animation
		 * totFrames - The total number of frames in the animation
		 * subCurFrame - The animation may be slowed down or sped up to non integer frames
		 */
		private var _sourceSprites:Vector.<Rectangle>;
		private var _offsets:Vector.<Point>;
		private var _frames:Vector.<int>;
		private var _curFrame:int;
		private var _totFrames:int;
		private var _subCurFrame:Number;
		
		/**
		 * Constructor, packages the parameters into the isbAnimationSprite.
		 * 
		 * @param	spriteSheet - Sprite sheet image to use
		 * @param	x - X-Coordinates to draw image
		 * @param	y - Y-Coordinates to draw image
		 */
		public function isbAnimationSprite(spriteSheet:BitmapData, x:int = 0, y:int = 0, offset:Point = null) 
		{
			super(spriteSheet, x, y, offset);
			this._curFrame = 0;
			this._totFrames = 0;
			this._subCurFrame = 0;
		}
		
		/**
		 * Adds the animation to play.
		 * 
		 * @param	rects - Source rectangles of the sprites to use
		 * @param	frames - Frames to hold sprite before transitioning
		 * @param	offsets - Display offsets of the sprite, defaults to zero points
		 */
		public function addAnimations(rects:Array, frames:Array, offsets:Array = null):void 
		{
			this._sourceSprites = Vector.<Rectangle>(rects);
			this._frames = Vector.<int>(frames);
			if (offsets != null) {
				this._offsets = Vector.<Point>(offsets);
			} else {
				offsets = new Array();
				for (var i:int = 0; i < rects.length; i++) 
				{
					offsets.push(new Point());
				}
			}
			this._totFrames = 0;
			for each (var frameTime:int in this._frames) 
			{
				this._totFrames += frameTime;
			}
			// Check for incorrect dimensions
			if (this._frames.length != this._sourceSprites.length || this._sourceSprites.length != this._offsets.length) {
				trace("Incorrect dimensions of added animation to: " + this + ", Source rectangles given: " + this._sourceSprites.length + ", Frame lengths given: " + this._frames.length + ", Offsets given: " + this._offsets.length);
			}
		}
		
		/**
		 * Update the current sprite.
		 * 
		 * @param	speed - The speed with which to update the sprite
		 */
		public function updateSprite(speed:Number = 1):void 
		{
			this.subCurFrame += speed;
		}
		
		/**
		 * Get the current animation index based on the current frame.
		 * 
		 * @return	Index of the current animation
		 */
		private function getAnimIndex():int
		{
			var index:int, frame:int;
			index = 0;
			frame = 0;
			while (index < this._frames.length) {
				frame += this._frames[index];
				if (frame >= this._curFrame) {
					break;
				}
				index++;
			}
			return index;
		}
		
		/**
		 * The animation may be slowed down or sped up to non integer frames.
		 */
		private function get subCurFrame():Number
		{
			return this._subCurFrame;
		}
		
		/**
		 * The animation may be slowed down or sped up to non integer frames.
		 */
		private function set subCurFrame(value:Number):void
		{
			this._subCurFrame = value;
			while (_subCurFrame >= 1) {
				_subCurFrame -= 1;
				this._curFrame += 1;
				if (this._curFrame > this._totFrames) {
					this._curFrame = 0;
				}
			}
			while (_subCurFrame < 0) {
				_subCurFrame += 1;
				this._curFrame -= 1;
				if (this._curFrame < 0) {
					this._curFrame = this._totFrames;
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get bitmapData():BitmapData 
		{
			var bd:BitmapData;
			if (this._totFrames > 0) {
				bd = new BitmapData(this._sourceSprites[getAnimIndex()].width, this._sourceSprites[getAnimIndex()].height);
				bd.copyPixels(this._bitmapData, this._sourceSprites[getAnimIndex()], new Point());
			} else {
				return this._bitmapData;
			}
			return bd;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get x():int 
		{
			if (this._totFrames > 0) {
				return this._x + this._offsets[getAnimIndex()].x;
			} else {
				return this._x;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get y():int 
		{
			if (this._totFrames > 0) {
				return this._y + this._offsets[getAnimIndex()].y;
			} else {
				return this._y;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get offset():Point
		{
			if (this._totFrames > 0) {
				var index:int = getAnimIndex();
				return new Point(this._offset.x + this._offsets[index].x, this._offset.y + this._offsets[index].y);
			} else {
				return this._offset;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get point():Point
		{
			var pt:Point = new Point();
			if (this._totFrames > 0) {
				pt.x += this._point.x + this._offset.x + this._offsets[getAnimIndex()].x;
				pt.y += this._point.y + this._offset.x + this._offsets[getAnimIndex()].y;
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
			if (this._totFrames > 0) {
				return new Rectangle(0, 0, this._sourceSprites[getAnimIndex()].width, this._sourceSprites[getAnimIndex()].height);
			} else {
				return this._bitmapData.rect;
			}
		}
	}
}