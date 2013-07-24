package isbFramework 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * General use sprite container for use with the
	 * rest of the framework. Contains a bitmapData
	 * and a point to draw it at.
	 * 
	 * Usage:
		 * var bob:isbSprite = new isbSprite(bitmapData, x, y, offset);
		 * ...
		 * isbScreen.buffer.copyPixels(bob.bitmapData, bob.rectangle, bob.point);
	 * 
	 * @author Ian Baker
	 */
	public class isbSprite 
	{
		/**
		 * Internal representation.
		 */
		protected var _x:int;
		protected var _y:int;
		protected var _bitmapData:BitmapData;
		protected var _point:Point;
		protected var _offset:Point;
		
		/**
		 * Constructor, packages the parameters into the isbSprite.
		 * 
		 * @param	bitmapData - Sprite image to use
		 * @param	x - X-Coordinates to draw image
		 * @param	y - Y-Coordinates to draw image
		 * @param	offset - Point to offset image from position
		 */
		public function isbSprite(bitmapData:BitmapData, x:int = 0, y:int = 0, offset:Point = null)
		{
			this._bitmapData = bitmapData;
			this._x = x;
			this._y = y;
			this._point = new Point(x, y);
			if (offset == null) {
				this._offset = new Point();
			} else {
				this._offset = offset;
			}
		}
		
		/**
		 * Sprite image to use
		 */
		public function get bitmapData():BitmapData 
		{
			return this._bitmapData;
		}
		
		/**
		 * Sprite image to use
		 */
		public function set bitmapData(value:BitmapData):void 
		{
			this._bitmapData = value;
		}
		
		/**
		 * X-Coordinates to draw image
		 */
		public function get x():int 
		{
			return this._x;
		}
		
		/**
		 * X-Coordinates to draw image
		 */
		public function set x(value:int):void 
		{
			this._x = value;
			this._point.x = value;
		}
		
		/**
		 * Y-Coordinates to draw image
		 */
		public function get y():int 
		{
			return this._y;
		}
		
		/**
		 * Y-Coordinates to draw image
		 */
		public function set y(value:int):void 
		{
			this._y = value;
			this._point.y = value;
		}
		
		/**
		 * Coordinates to draw image (including offset)
		 */
		public function get point():Point
		{
			var pt:Point = new Point();
			pt.x += this._point.x + this._offset.x;
			pt.y += this._point.y + this._offset.y;
			return pt;
		}
		
		/**
		 * Coordinates to draw image (including offset)
		 */
		public function set point(value:Point):void
		{
			this._point = value;
			this._x = value.x;
			this._y = value.y;
		}
		
		/**
		 * Coordinates to offset the drawing of the image
		 */
		public function get offset():Point
		{
			return this._offset;
		}
		
		/**
		 * Coordinates to offset the drawing of the image
		 */
		public function set offset(value:Point):void
		{
			this._offset = value;
		}
		
		/**
		 * Rectangle of the sprite image.
		 */
		public function get rectangle():Rectangle 
		{
			return this._bitmapData.rect;
		}
	}
}