package isbFramework 
{
	import flash.geom.Rectangle;
	
	/**
	 * Utility class for handling collisions, calculates depth
	 * of collision and which side the collision came from.
	 * 
	 * Usage:
		 * var collisionType:int = isbCollision.rectCollisionTypeAtoB(heroRect, tileRect);
		 * var depth:int = isbCollision.rectCollisionDepthAtoB(heroRect, tileRect);
	 * 
	 * @author Ian Baker
	 */
	public class isbCollision 
	{
		/**
		 * Collision constants
		 */
		public static const NONE:int = 0;
		public static const BOTTOM:int = 1;
		public static const TOP:int = 2;
		public static const LEFT:int = 3;
		public static const RIGHT:int = 4;
		public static const BOTTOM_LEFT:int = 5;
		public static const BOTTOM_RIGHT:int = 6;
		public static const TOP_LEFT:int = 7;
		public static const TOP_RIGHT:int = 8;
		
		/**
		 * Default constructor, does nothing.
		 */
		public function isbCollision() { }
		
		/**
		 * Returns the collision type relative to the obstacle, i.e.
		 * where does the observer hit the obstacle.
		 * 
		 * Rectangle A relates to Rectangle B in one of 5 cases:
			 * A Does not collide with B
			 * A collides with bottom of B
			 * A collides with top of B
			 * A collides with left of B
			 * A collides with right of B
			 * A collides with bottom-left of B
			 * A collides with bottom-right of B
			 * A collides with top-left of B
			 * A collides with top-right of B
		 * 
		 * @param	A	Checking Rectangle (observer)
		 * @param	B	Checked Rectangle (obstacle)
		 * @return	Collision type relative to obstacle
		 */
		public static function rectCollisionTypeAtoB(A:Rectangle, B:Rectangle):int
		{
			var overlapX:int, overlapY:int;
			overlapX = lineSegmentOverlap(A.x, A.x + A.width, B.x, B.x + B.width);
			overlapY = lineSegmentOverlap(A.y, A.y + A.height, B.y, B.y + B.height);
			if (overlapX > 0 && overlapY > 0) 
			{
				if (overlapX > overlapY) 
				{
					if (A.y > B.y) 
					{
						return BOTTOM;
					}
					else 
					{
						return TOP;
					}
				}
				else if (overlapX < overlapY) 
				{
					if (A.x > B.x) 
					{
						return RIGHT;
					}
					else 
					{
						return LEFT;
					}
				} else {
					if (A.x > B.x)
					{
						if (A.y > B.y)
						{
							return BOTTOM_RIGHT;
						}
						else 
						{
							return TOP_RIGHT;
						}
					}
					else 
					{
						if (A.y > B.y)
						{
							return BOTTOM_LEFT;
						}
						else 
						{
							return TOP_LEFT;
						}
					}
				}
			}
			return NONE;
		}
		
		/**
		 * Rectangle A Collides with Rectangle B with this amount of depth.
		 * 
		 * @param	A - Checking Rectangle (observer)
		 * @param	B - Checked Rectangle (obstacle)
		 * @return	Depth of collision
		 */
		public static function rectCollisionDepthAtoB(A:Rectangle, B:Rectangle):int
		{
			var overlapX:int, overlapY:int;
			overlapX = lineSegmentOverlap(A.x, A.x + A.width, B.x, B.x + B.width);
			overlapY = lineSegmentOverlap(A.y, A.y + A.height, B.y, B.y + B.height);
			if (overlapX > 0 && overlapY > 0) 
			{
				if (overlapX > overlapY) 
				{
					return overlapY;
				}
				else 
				{
					return overlapX;
				}
			}
			return 0;
		}
		
		/**
		 * Returns the line-segment overlap.
		 * 
		 * @param	a1	Line-SegmentA Left
		 * @param	a2	Line-SegmentA Right
		 * @param	b1	Line-SegmentB Left
		 * @param	b2	Line-SegmentB Right
		 * @return	Integer overlap
		 */
		private static function lineSegmentOverlap(a1:int, a2:int, b1:int, b2:int):int
		{
			if (a1 > a2) { // Swap a1 and a2
				a1 ^= a2; a2 ^= a1; a1 ^= a2;
			}
			if (b1 > b2) { // Swap b1 and b2
				b1 ^= b2; b2 ^= b1; b1 ^= b2;
			}
			var WidthA:int = a2 - a1;
			var WidthB:int = b2 - b1;
			var RightToRight:int;
			b2 > a2? RightToRight = b2 - a2 : RightToRight = a2 - b2;
			var LeftToLeft:int;
			b1 > a1? LeftToLeft = b1 - a1 : LeftToLeft = a1 - b1;
			return ((WidthA + WidthB) - (RightToRight + LeftToLeft)) / 2;
		}
	}
}