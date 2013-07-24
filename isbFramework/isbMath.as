package isbFramework 
{
	/**
	 * Utility class with helpful math related functions.
	 * 
	 * @author Ian Baker
	 */
	public class isbMath 
	{
		
		/**
		 * Empty constructor, no point in constructing.
		 */
		public function isbMath() { }
		
		/**
		 * Returns the angle between two points in radians.
		 * 
		 * @param	fromX - First point X-coordinate
		 * @param	fromY - First point Y-coordinate
		 * @param	toX - Second point X-coordinate
		 * @param	toY - Second point Y-coordinate
		 * @return	Angle in radians
		 */
		public static function getAngleBetweenPoints(fromX:Number, fromY:Number, toX:Number, toY:Number):Number
		{
			var dx:Number = toX - fromX;
			var dy:Number = toY - fromY;
			return Math.atan2(dy,dx);
		}
		
		/**
		 * Random a number within the range inclusive.
		 * 
		 * @param	low - Lowest number in range
		 * @param	high - Highest number in range
		 * @return	Random number in range
		 */
		public static function randomRangeInt(low:int, high:int):int
		{
			if (low > high) {
				var temp:int = high;
				high = low;
				low = temp;
			}
			return low + (Math.random() * ((high - low) + 1));
		}
	}
}