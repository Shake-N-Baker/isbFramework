package isbFramework 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * Double buffered bitmap screen. Capable of scaling to any size
	 * along with point scaling functions to map unscaled points to
	 * scaled points.
	 * 
	 * Usage:
		 * // Add 160x144 screen at 4x resolution
		 * var screen:isbScreen = new isbScreen(160, 144);
		 * addChild(screen);
		 * screen.resize(640, 576);
		 * ...
		 * isbScreen.buffer.lock();
		 * // Clear canvas
		 * isbScreen.buffer.fillRect(isbScreen.rectangle, 0xFF000000);
		 * isbScreen.buffer.unlock();
		 * isbScreen.flip();
		 * ...
		 * var mousePt:Point = isbScreen.scale(mouseX, mouseY);
	 * 
	 * @author Ian Baker
	 */
	public class isbScreen extends Bitmap
	{
		/**
		 * Screen properties (Unscaled)
		 */
		public static var width:int;
		public static var height:int;
		public static var rectangle:Rectangle;
		public static var point:Point = new Point(0, 0);
		
		/**
		 * Front and back buffers, buffer remains unscaled always
		 */
		public static var buffer:BitmapData;
		public static var display:BitmapData;
		
		/**
		 * Scaling matrix
		 */
		public static var scaling:Matrix;
		
		/**
		 * Constructor of the screen, requires adding to the
		 * displaylist to show.
		 * 
		 * @param	width - Width of the screen
		 * @param	height - Height of the screen
		 */
		public function isbScreen(width:int, height:int) 
		{
			isbScreen.width = width;
			isbScreen.height = height;
			isbScreen.buffer = new BitmapData(width, height, false, 0x00000000);
			isbScreen.display = new BitmapData(width, height, false, 0x00000000);
			isbScreen.rectangle = new Rectangle(0, 0, width, height);
			isbScreen.scaling = new Matrix();
			super(display);
		}
		
		/**
		 * Flip the buffers, displaying the back buffer
		 */
		public static function flip():void 
		{
			isbScreen.display.draw(isbScreen.buffer, isbScreen.scaling);
			isbScreen.buffer.fillRect(isbScreen.rectangle, 0x00000000);
		}
		
		/**
		 * Resizes the screen, requires a reference to the
		 * isbScreen to resize as static classes are not
		 * possible.
		 * 
		 * @param	width - Width of the resized screen
		 * @param	height - Height of the resized screen
		 */
		public function resize(width:int, height:int):void 
		{
			isbScreen.scaling.identity();
			// isbScreen buffer / rectangle / width / height remain the same and are used for scaling
			isbScreen.scaling.scale(width / isbScreen.width, height / isbScreen.height);
			isbScreen.display = new BitmapData(width, height, false, 0x00000000);
			this.bitmapData = isbScreen.display;
		}
		
		/**
		 * Scale the input point based on the current screen
		 * scaling factor. Good for coordinate conversion.
		 * 
		 * @param	pt - Point to be scaled
		 * @return	Scaled point
		 */
		public static function scalePoint(pt:Point):Point 
		{
			pt.x /= isbScreen.scaling.a;
			pt.y /= isbScreen.scaling.d;
			return pt;
		}
		
		/**
		 * Scale the input point based on the current screen
		 * scaling factor. Good for coordinate conversion.
		 * 
		 * @param	x - X-coordinate to be scaled
		 * @param	y - Y-coordinate to be scaled
		 * @return	Scaled point
		 */
		public static function scale(x:int, y:int):Point 
		{
			x /= isbScreen.scaling.a;
			y /= isbScreen.scaling.d;
			return new Point(x, y);
		}
	}
}