package isbFramework 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * Sprite sheet of text images to be used within the isbTextBox.
	 * 
	 * To change font:
	 * • Construct isbText with fontType parameter set correctly (use isbText.FONT_TYPE_ constants for selecting)
	 * 
	 * To add font:
	 * • Image must correspond to the proper mono-spaced format
	 * • Add the Embed Image and code
	 * • Add a case for the new font type into the constructor switch case (and update documentation)
	 * 
	 * @author Ian Baker
	 */
	public class isbText 
	{
		[Embed(source="Data/8x13Font.png")]
		private static var fontBaseImage8x13:Class;
		public static const FONT_TYPE_8x13:int = 0;
		[Embed(source = "Data/7x8Font.png")]
		private static var fontBaseImage7x8:Class;
		public static const FONT_TYPE_7x8:int = 1;
		
		public var letter_width:int;
		public var letter_height:int;
		private static const LETTER_PADDING:int = 1;
		
		public static const LETTER_LC_A:Rectangle = 				new Rectangle(0, 0, 1, 1);
		public static const LETTER_LC_B:Rectangle = 				new Rectangle(1, 0, 1, 1);
		public static const LETTER_LC_C:Rectangle = 				new Rectangle(2, 0, 1, 1);
		public static const LETTER_LC_D:Rectangle = 				new Rectangle(3, 0, 1, 1);
		public static const LETTER_LC_E:Rectangle = 				new Rectangle(4, 0, 1, 1);
		public static const LETTER_LC_F:Rectangle = 				new Rectangle(5, 0, 1, 1);
		public static const LETTER_LC_G:Rectangle = 				new Rectangle(6, 0, 1, 1);
		public static const LETTER_LC_H:Rectangle = 				new Rectangle(7, 0, 1, 1);
		public static const LETTER_LC_I:Rectangle = 				new Rectangle(8, 0, 1, 1);
		public static const LETTER_LC_J:Rectangle = 				new Rectangle(9, 0, 1, 1);
		public static const LETTER_LC_K:Rectangle = 				new Rectangle(10, 0, 1, 1);
		public static const LETTER_LC_L:Rectangle = 				new Rectangle(11, 0, 1, 1);
		public static const LETTER_LC_M:Rectangle = 				new Rectangle(12, 0, 1, 1);
		public static const LETTER_LC_N:Rectangle = 				new Rectangle(13, 0, 1, 1);
		public static const LETTER_LC_O:Rectangle = 				new Rectangle(14, 0, 1, 1);
		public static const LETTER_LC_P:Rectangle = 				new Rectangle(15, 0, 1, 1);
		public static const LETTER_LC_Q:Rectangle = 				new Rectangle(0, 1, 1, 1);
		public static const LETTER_LC_R:Rectangle = 				new Rectangle(1, 1, 1, 1);
		public static const LETTER_LC_S:Rectangle = 				new Rectangle(2, 1, 1, 1);
		public static const LETTER_LC_T:Rectangle = 				new Rectangle(3, 1, 1, 1);
		public static const LETTER_LC_U:Rectangle = 				new Rectangle(4, 1, 1, 1);
		public static const LETTER_LC_V:Rectangle = 				new Rectangle(5, 1, 1, 1);
		public static const LETTER_LC_W:Rectangle = 				new Rectangle(6, 1, 1, 1);
		public static const LETTER_LC_X:Rectangle = 				new Rectangle(7, 1, 1, 1);
		public static const LETTER_LC_Y:Rectangle = 				new Rectangle(8, 1, 1, 1);
		public static const LETTER_LC_Z:Rectangle = 				new Rectangle(9, 1, 1, 1);
		public static const LETTER_UC_A:Rectangle = 				new Rectangle(10, 1, 1, 1);
		public static const LETTER_UC_B:Rectangle = 				new Rectangle(11, 1, 1, 1);
		public static const LETTER_UC_C:Rectangle = 				new Rectangle(12, 1, 1, 1);
		public static const LETTER_UC_D:Rectangle = 				new Rectangle(13, 1, 1, 1);
		public static const LETTER_UC_E:Rectangle = 				new Rectangle(14, 1, 1, 1);
		public static const LETTER_UC_F:Rectangle = 				new Rectangle(15, 1, 1, 1);
		public static const LETTER_UC_G:Rectangle = 				new Rectangle(0, 2, 1, 1);
		public static const LETTER_UC_H:Rectangle = 				new Rectangle(1, 2, 1, 1);
		public static const LETTER_UC_I:Rectangle = 				new Rectangle(2, 2, 1, 1);
		public static const LETTER_UC_J:Rectangle = 				new Rectangle(3, 2, 1, 1);
		public static const LETTER_UC_K:Rectangle = 				new Rectangle(4, 2, 1, 1);
		public static const LETTER_UC_L:Rectangle = 				new Rectangle(5, 2, 1, 1);
		public static const LETTER_UC_M:Rectangle = 				new Rectangle(6, 2, 1, 1);
		public static const LETTER_UC_N:Rectangle = 				new Rectangle(7, 2, 1, 1);
		public static const LETTER_UC_O:Rectangle = 				new Rectangle(8, 2, 1, 1);
		public static const LETTER_UC_P:Rectangle = 				new Rectangle(9, 2, 1, 1);
		public static const LETTER_UC_Q:Rectangle = 				new Rectangle(10, 2, 1, 1);
		public static const LETTER_UC_R:Rectangle = 				new Rectangle(11, 2, 1, 1);
		public static const LETTER_UC_S:Rectangle = 				new Rectangle(12, 2, 1, 1);
		public static const LETTER_UC_T:Rectangle = 				new Rectangle(13, 2, 1, 1);
		public static const LETTER_UC_U:Rectangle = 				new Rectangle(14, 2, 1, 1);
		public static const LETTER_UC_V:Rectangle = 				new Rectangle(15, 2, 1, 1);
		public static const LETTER_UC_W:Rectangle = 				new Rectangle(0, 3, 1, 1);
		public static const LETTER_UC_X:Rectangle = 				new Rectangle(1, 3, 1, 1);
		public static const LETTER_UC_Y:Rectangle = 				new Rectangle(2, 3, 1, 1);
		public static const LETTER_UC_Z:Rectangle = 				new Rectangle(3, 3, 1, 1);
		public static const NUMBER_0:Rectangle = 					new Rectangle(4, 3, 1, 1);
		public static const NUMBER_1:Rectangle = 					new Rectangle(5, 3, 1, 1);
		public static const NUMBER_2:Rectangle = 					new Rectangle(6, 3, 1, 1);
		public static const NUMBER_3:Rectangle = 					new Rectangle(7, 3, 1, 1);
		public static const NUMBER_4:Rectangle = 					new Rectangle(8, 3, 1, 1);
		public static const NUMBER_5:Rectangle = 					new Rectangle(9, 3, 1, 1);
		public static const NUMBER_6:Rectangle = 					new Rectangle(10, 3, 1, 1);
		public static const NUMBER_7:Rectangle = 					new Rectangle(11, 3, 1, 1);
		public static const NUMBER_8:Rectangle = 					new Rectangle(12, 3, 1, 1);
		public static const NUMBER_9:Rectangle = 					new Rectangle(13, 3, 1, 1);
		public static const SPECIAL_SPACE:Rectangle = 				new Rectangle(14, 3, 1, 1);
		public static const SPECIAL_EXCLEMATION_MARK:Rectangle = 	new Rectangle(15, 3, 1, 1);
		public static const SPECIAL_AT_SIGN:Rectangle = 			new Rectangle(0, 4, 1, 1);
		public static const SPECIAL_POUND:Rectangle = 				new Rectangle(1, 4, 1, 1);
		public static const SPECIAL_DOLLAR:Rectangle = 				new Rectangle(2, 4, 1, 1);
		public static const SPECIAL_PERCENT:Rectangle = 			new Rectangle(3, 4, 1, 1);
		public static const SPECIAL_POWER:Rectangle = 				new Rectangle(4, 4, 1, 1);
		public static const SPECIAL_AND:Rectangle = 				new Rectangle(5, 4, 1, 1);
		public static const SPECIAL_MULTIPLY:Rectangle = 			new Rectangle(6, 4, 1, 1);
		public static const SPECIAL_LEFT_PARENTHESIS:Rectangle = 	new Rectangle(7, 4, 1, 1);
		public static const SPECIAL_RIGHT_PARENTHESIS:Rectangle = 	new Rectangle(8, 4, 1, 1);
		public static const SPECIAL_MINUS:Rectangle = 				new Rectangle(9, 4, 1, 1);
		public static const SPECIAL_PLUS:Rectangle = 				new Rectangle(10, 4, 1, 1);
		public static const SPECIAL_UNDERSCORE:Rectangle = 			new Rectangle(11, 4, 1, 1);
		public static const SPECIAL_EQUALS:Rectangle = 				new Rectangle(12, 4, 1, 1);
		public static const SPECIAL_LEFT_CURLY_BRACE:Rectangle = 	new Rectangle(13, 4, 1, 1);
		public static const SPECIAL_RIGHT_CURLY_BRACE:Rectangle = 	new Rectangle(14, 4, 1, 1);
		public static const SPECIAL_LEFT_BRACKET:Rectangle = 		new Rectangle(15, 4, 1, 1);
		public static const SPECIAL_RIGHT_BRACKET:Rectangle = 		new Rectangle(0, 5, 1, 1);
		public static const SPECIAL_SEMI_COLON:Rectangle = 			new Rectangle(1, 5, 1, 1);
		public static const SPECIAL_COLON:Rectangle = 				new Rectangle(2, 5, 1, 1);
		public static const SPECIAL_QUOTATION_MARK:Rectangle = 		new Rectangle(3, 5, 1, 1);
		public static const SPECIAL_APOSTROPHE:Rectangle = 			new Rectangle(4, 5, 1, 1);
		public static const SPECIAL_COMMA:Rectangle = 				new Rectangle(5, 5, 1, 1);
		public static const SPECIAL_PERIOD:Rectangle = 				new Rectangle(6, 5, 1, 1);
		public static const SPECIAL_LESS_THAN:Rectangle = 			new Rectangle(7, 5, 1, 1);
		public static const SPECIAL_GREATER_THAN:Rectangle = 		new Rectangle(8, 5, 1, 1);
		public static const SPECIAL_QUESTION_MARK:Rectangle = 		new Rectangle(9, 5, 1, 1);
		public static const SPECIAL_FORWARD_SLASH:Rectangle = 		new Rectangle(10, 5, 1, 1);
		public static const SPECIAL_BACK_SLASH:Rectangle = 			new Rectangle(11, 5, 1, 1);
		public static const SPECIAL_OR:Rectangle = 					new Rectangle(12, 5, 1, 1);
		public static const SPECIAL_GRAVE_ACCENT:Rectangle = 		new Rectangle(13, 5, 1, 1);
		public static const SPECIAL_TILDE:Rectangle = 				new Rectangle(14, 5, 1, 1);
		
		private var _fontBMD:BitmapData;
		private var _color:uint;
		
		/**
		 * For color swapping
		 */
		private static const ZERO_POINT:Point = new Point(0, 0);
		
		/**
		 * Construct the text.
		 * 
		 * @param	color - Font color
		 * @param	fontType - Font type
		 */
		public function isbText(color:uint = 0xff000000, fontType:int = FONT_TYPE_8x13) 
		{
			_color = color;
			var b:Bitmap;
			switch(fontType) {
				case FONT_TYPE_8x13:
					letter_width = 8;
					letter_height = 13;
					b = new fontBaseImage8x13();
					break;
				case FONT_TYPE_7x8:
					letter_width = 7;
					letter_height = 8;
					b = new fontBaseImage7x8();
					break;
				default:
					letter_width = 8;
					letter_height = 13;
					b = new fontBaseImage8x13();
					break;
			}
			_fontBMD = b.bitmapData;
			if (color != 0xff000000) {
				changeBMDColor(0xff000000, color);
			}
		}
		
		/**
		 * Returns the source rectangle from the bitmap of
		 * the corresponding letter.
		 * 
		 * @param	charCode - Character code of the letter
		 * @return	Source rectangle
		 */
		public function RectangleFromCharCode(charCode:uint):Rectangle
		{
			var rect:Rectangle;
			switch (charCode) 
			{
				case 97:
					rect = LETTER_LC_A;
					break;
				case 98:
					rect = LETTER_LC_B;
					break;
				case 99:
					rect = LETTER_LC_C;
					break;
				case 100:
					rect = LETTER_LC_D;
					break;
				case 101:
					rect = LETTER_LC_E;
					break;
				case 102:
					rect = LETTER_LC_F;
					break;
				case 103:
					rect = LETTER_LC_G;
					break;
				case 104:
					rect = LETTER_LC_H;
					break;
				case 105:
					rect = LETTER_LC_I;
					break;
				case 106:
					rect = LETTER_LC_J;
					break;
				case 107:
					rect = LETTER_LC_K;
					break;
				case 108:
					rect = LETTER_LC_L;
					break;
				case 109:
					rect = LETTER_LC_M;
					break;
				case 110:
					rect = LETTER_LC_N;
					break;
				case 111:
					rect = LETTER_LC_O;
					break;
				case 112:
					rect = LETTER_LC_P;
					break;
				case 113:
					rect = LETTER_LC_Q;
					break;
				case 114:
					rect = LETTER_LC_R;
					break;
				case 115:
					rect = LETTER_LC_S;
					break;
				case 116:
					rect = LETTER_LC_T;
					break;
				case 117:
					rect = LETTER_LC_U;
					break;
				case 118:
					rect = LETTER_LC_V;
					break;
				case 119:
					rect = LETTER_LC_W;
					break;
				case 120:
					rect = LETTER_LC_X;
					break;
				case 121:
					rect = LETTER_LC_Y;
					break;
				case 122:
					rect = LETTER_LC_Z;
					break;
				case 65:
					rect = LETTER_UC_A;
					break;
				case 66:
					rect = LETTER_UC_B;
					break;
				case 67:
					rect = LETTER_UC_C;
					break;
				case 68:
					rect = LETTER_UC_D;
					break;
				case 69:
					rect = LETTER_UC_E;
					break;
				case 70:
					rect = LETTER_UC_F;
					break;
				case 71:
					rect = LETTER_UC_G;
					break;
				case 72:
					rect = LETTER_UC_H;
					break;
				case 73:
					rect = LETTER_UC_I;
					break;
				case 74:
					rect = LETTER_UC_J;
					break;
				case 75:
					rect = LETTER_UC_K;
					break;
				case 76:
					rect = LETTER_UC_L;
					break;
				case 77:
					rect = LETTER_UC_M;
					break;
				case 78:
					rect = LETTER_UC_N;
					break;
				case 79:
					rect = LETTER_UC_O;
					break;
				case 80:
					rect = LETTER_UC_P;
					break;
				case 81:
					rect = LETTER_UC_Q;
					break;
				case 82:
					rect = LETTER_UC_R;
					break;
				case 83:
					rect = LETTER_UC_S;
					break;
				case 84:
					rect = LETTER_UC_T;
					break;
				case 85:
					rect = LETTER_UC_U;
					break;
				case 86:
					rect = LETTER_UC_V;
					break;
				case 87:
					rect = LETTER_UC_W;
					break;
				case 88:
					rect = LETTER_UC_X;
					break;
				case 89:
					rect = LETTER_UC_Y;
					break;
				case 90:
					rect = LETTER_UC_Z;
					break;
				case 48:
					rect = NUMBER_0;
					break;
				case 49:
					rect = NUMBER_1;
					break;
				case 50:
					rect = NUMBER_2;
					break;
				case 51:
					rect = NUMBER_3;
					break;
				case 52:
					rect = NUMBER_4;
					break;
				case 53:
					rect = NUMBER_5;
					break;
				case 54:
					rect = NUMBER_6;
					break;
				case 55:
					rect = NUMBER_7;
					break;
				case 56:
					rect = NUMBER_8;
					break;
				case 57:
					rect = NUMBER_9;
					break;
				case 32:
					rect = SPECIAL_SPACE;
					break;
				case 33:
					rect = SPECIAL_EXCLEMATION_MARK;
					break;
				case 64:
					rect = SPECIAL_AT_SIGN;
					break;
				case 35:
					rect = SPECIAL_POUND;
					break;
				case 36:
					rect = SPECIAL_DOLLAR;
					break;
				case 37:
					rect = SPECIAL_PERCENT;
					break;
				case 94:
					rect = SPECIAL_POWER;
					break;
				case 38:
					rect = SPECIAL_AND;
					break;
				case 42:
					rect = SPECIAL_MULTIPLY;
					break;
				case 40:
					rect = SPECIAL_LEFT_PARENTHESIS;
					break;
				case 41:
					rect = SPECIAL_RIGHT_PARENTHESIS;
					break;
				case 45:
					rect = SPECIAL_MINUS;
					break;
				case 43:
					rect = SPECIAL_PLUS;
					break;
				case 95:
					rect = SPECIAL_UNDERSCORE;
					break;
				case 61:
					rect = SPECIAL_EQUALS;
					break;
				case 123:
					rect = SPECIAL_LEFT_CURLY_BRACE;
					break;
				case 125:
					rect = SPECIAL_RIGHT_CURLY_BRACE;
					break;
				case 91:
					rect = SPECIAL_LEFT_BRACKET;
					break;
				case 93:
					rect = SPECIAL_RIGHT_BRACKET;
					break;
				case 59:
					rect = SPECIAL_SEMI_COLON;
					break;
				case 58:
					rect = SPECIAL_COLON;
					break;
				case 34:
					rect = SPECIAL_QUOTATION_MARK;
					break;
				case 39:
					rect = SPECIAL_APOSTROPHE;
					break;
				case 44:
					rect = SPECIAL_COMMA;
					break;
				case 46:
					rect = SPECIAL_PERIOD;
					break;
				case 60:
					rect = SPECIAL_LESS_THAN;
					break;
				case 62:
					rect = SPECIAL_GREATER_THAN;
					break;
				case 63:
					rect = SPECIAL_QUESTION_MARK;
					break;
				case 47:
					rect = SPECIAL_FORWARD_SLASH;
					break;
				case 92:
					rect = SPECIAL_BACK_SLASH;
					break;
				case 124:
					rect = SPECIAL_OR;
					break;
				case 96:
					rect = SPECIAL_GRAVE_ACCENT;
					break;
				case 126:
					rect = SPECIAL_TILDE;
					break;
				default:
					rect = SPECIAL_QUESTION_MARK;
					break;
			}
			var rect2:Rectangle = new Rectangle(rect.x, rect.y, letter_width, letter_height);
			rect2.x *= (letter_width + LETTER_PADDING);
			rect2.y *= (letter_height + LETTER_PADDING);
			return rect2;
		}
		
		/**
		 * Font color
		 */
		public function get color():uint 
		{
			return _color;
		}
		
		/**
		 * Font color
		 */
		public function set color(color:uint):void 
		{
			if (_color != color) {
				changeBMDColor(_color, color);
				_color = color;
			}
		}
		
		/**
		 * Bitmap of all letters of this font type and color
		 */
		public function get bitmapData():BitmapData 
		{
			return _fontBMD;
		}
		
		/**
		 * Replaces all letters of the old color with
		 * those of the colorReplacement color.
		 * 
		 * @param	colorReplacement - Color to be added
		 */
		private function changeBMDColor(colorLookUp:uint, colorReplacement:uint):void 
		{
			// Replace anything not transparent with the new color
			_fontBMD.threshold(_fontBMD, _fontBMD.rect, ZERO_POINT, "!=", 0x00000000, colorReplacement);
		}
		
	}
}