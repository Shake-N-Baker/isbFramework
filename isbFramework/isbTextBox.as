package isbFramework 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * Sprite text box. Creates a bitmapData representation using the embedded
	 * font spritesheet and the isbText class.
	 * 
	 * Usage:
		 * var textBox:isbTextBox = new isbTextBox(isbText.FONT_TYPE_8x13, "fontType = 8x13, Text, singleLine = false, 144 width, 28 height, 200% scale, font color 0xFF336699", false, 144, 28, 2, 0xFF336699);
		 * textBox.x = 100;
		 * textBox.y = 100;
		 * ...
		 * isbScreen.buffer.copyPixels(textBox.bitmapData, textBox.rectangle, textBox.point);
	 * 
	 * @author Ian Baker
	 */
	public class isbTextBox 
	{
		/**
		 * Global Constants
		 */
		public static const ALIGN_LEFT:String = "align_left";
		public static const ALIGN_CENTER:String = "align_center";
		public static const ALIGN_RIGHT:String = "align_right";
		
		/**
		 * Letter spacing constants, change these to change padding
		 */
		private static const LETTER_PADDING_HORIZONTAL:int = 1;
		private static const LETTER_PADDING_VERTICAL:int = 1;
		
		/**
		 * Internal representation
		 */
		private var _text:String;
		private var _color:uint;
		private var _backgroundColor:uint;
		private var _singleLine:Boolean;
		private var _charsPerLine:uint;
		private var _align:String;
		private var _scale:Number;
		private var _scaleMat:Matrix;
		private var _width:int;
		private var _height:int;
		private var _x:int;
		private var _y:int;
		private var _textChars:isbText;
		private var _bitmapData:BitmapData;
		private var _rectangle:Rectangle;
		private var _point:Point;
		
		/**
		 * Textbox constructor, packages the text box.
		 * 
		 * @param	fontType - Font type use isbText.FONT_TYPE_... to choose
		 * @param	text - Text to display in the text box
		 * @param	singleLine - Whether the text box is a single line or multilined
		 * @param	width - Max width of the text box
		 * @param	height - Max height of the text box
		 * @param	color - Color of the font
		 * @param	scale - How large to scale the letters
		 * @param	backgroundColor - Color of the background
		 * @param	align - Alignment of the text, ALIGN_LEFT, ALIGN_CENTER, ALIGN_RIGHT
		 * @param	charsPerLine - Maximum characters per line
		 */
		public function isbTextBox(fontType:int = 0, text:String = "", singleLine:Boolean = true, width:uint = 100, height:uint = 10, scale:Number = 1.0, color:uint = 0xff000000, backgroundColor:uint = 0x00000000, align:String = ALIGN_LEFT, charsPerLine:uint = 100)
		{
			_text = text;
			_color = color;
			_backgroundColor = backgroundColor;
			if (charsPerLine < 1) _charsPerLine = 1;
			else _charsPerLine = charsPerLine;
			_singleLine = singleLine;
			_align = align;
			_x = 0;
			_y = 0;
			_point = new Point(_x, _y);
			_width = width;
			_height = height;
			_scale = scale;
			_scaleMat = new Matrix();
			_scaleMat.scale(_scale, _scale);
			_rectangle = new Rectangle(0, 0, _width, _height);
			_textChars = new isbText(color, fontType);
			generateBitmapData();
		}
		
		/**
		 * Textbox X-coordinate position.
		 */
		public function get x():int 
		{
			return _x;
		}
		
		/**
		 * Textbox X-coordinate position.
		 */
		public function set x(x:int):void 
		{
			_x = x;
			_point.x = x;
		}
		
		/**
		 * Textbox Y-coordinate position.
		 */
		public function get y():int 
		{
			return _y;
		}
		
		/**
		 * Textbox Y-coordinate position.
		 */
		public function set y(y:int):void 
		{
			_y = y;
			_point.y = y;
		}
		
		/**
		 * Text box maximum width.
		 */
		public function get width():int 
		{
			return _width;
		}
		
		/**
		 * Text box maximum width.
		 */
		public function set width(width:int):void
		{
			_width = width;
			_rectangle.width = width;
		}
		
		/**
		 * Text box maximum height.
		 */
		public function get height():int 
		{
			return _height;
		}
		
		/**
		 * Text box maximum height.
		 */
		public function set height(height:int):void 
		{
			_height = height;
			_rectangle.height = height;
		}
		
		/**
		 * Text box position.
		 */
		public function get point():Point 
		{
			return _point;
		}
		
		/**
		 * Text box position.
		 */
		public function set point(point:Point):void 
		{
			_point = point;
			_x = point.x;
			_y = point.y;
		}
		
		/**
		 * Text box bitmapData source rectangle.
		 */
		public function get rectangle():Rectangle 
		{
			return _rectangle;
		}
		
		/**
		 * Text box bitmapData source rectangle.
		 */
		public function set rectangle(rectangle:Rectangle):void 
		{
			_rectangle = rectangle;
			_width = rectangle.width;
			_height = rectangle.height;
		}
		
		/**
		 * Text box text.
		 */
		public function get text():String 
		{
			return _text;
		}
		
		/**
		 * Text box text.
		 */
		public function set text(text:String):void 
		{
			_text = text;
			generateBitmapData();
		}
		
		/**
		 * Text box letter scale.
		 */
		public function get scale():Number
		{
			return _scale;
		}
		
		/**
		 * Text box letter scale.
		 */
		public function set scale(scale:Number):void
		{
			_scale = scale;
			generateBitmapData();
		}
		
		/**
		 * Text box text alignment.
		 */
		public function get align():String 
		{
			return _align;
		}
		
		/**
		 * Text box text alignment.
		 */
		public function set align(align:String):void 
		{
			_align = align;
			generateBitmapData();
		}
		
		/**
		 * Text box text color.
		 */
		public function get color():uint 
		{
			return _color;
		}
		
		/**
		 * Text box text color.
		 */
		public function set color(color:uint):void 
		{
			_color = color;
			_textChars.color = color;
			generateBitmapData();
		}
		
		/**
		 * Text box background color.
		 */
		public function get backgroundColor():uint 
		{
			return _backgroundColor;
		}
		
		/**
		 * Text box background color.
		 */
		public function set backgroundColor(backgroundColor:uint):void 
		{
			_backgroundColor = backgroundColor;
			generateBitmapData();
		}
		
		/**
		 * Text box text maximum characters per line.
		 */
		public function get charsPerLine():uint 
		{
			return _charsPerLine;
		}
		
		/**
		 * Text box text maximum characters per line.
		 */
		public function set charsPerLine(charsPerLine:uint):void 
		{
			_charsPerLine = charsPerLine;
			generateBitmapData();
		}
		
		/**
		 * Text box flag, text fits to single line.
		 */
		public function get singleLine():Boolean 
		{
			return _singleLine;
		}
		
		/**
		 * Text box flag, text fits to single line.
		 */
		public function set singleLine(singleLine:Boolean):void 
		{
			_singleLine = singleLine;
			generateBitmapData();
		}
		
		/**
		 * Text box bitmapData.
		 */
		public function get bitmapData():BitmapData 
		{
			return _bitmapData;
		}
		
		/**
		 * Converts the text box text to multiple single lines.
		 * 
		 * @return	Multiple single lines of text
		 */
		private function convertTextToLines():Vector.<String> 
		{
			var lines:Vector.<String> = new Vector.<String>();
			var maxCharPerLine:int = ((_width / _scale) + 1) / (_textChars.letter_width + LETTER_PADDING_HORIZONTAL);
			if (maxCharPerLine > _charsPerLine) maxCharPerLine = _charsPerLine;
			var words:Vector.<String> = new Vector.<String>();
			var i:int = 0;
			words[0] = "";
			
			// Chop text into words
			while (i < _text.length) {
				if (_text.charCodeAt(i) == 32) { // Space
					words.push("");
				} else if (_text.charCodeAt(i) == 10 || _text.charCodeAt(i) == 13) { // Newline or carriage return
					words.push("\n");
					words.push("");
				} else {
					words[words.length - 1] += _text.charAt(i);
				}
				i++;
			}
			
			var end:int = 0;
			var incr:int = 0;
			lines[0] = "";
			
			// Compose lines from words
			for (i = 0; i < words.length; i++) 
			{
				if (words[i] == "\n") { // New line
					if ((i + 1) < words.length) {
						if (lines[lines.length - 1].length > 0) { // Must be a word and a space
							lines[lines.length - 1] = lines[lines.length - 1].substr(0, lines[lines.length - 1].length - 1); // Remove space
						}
						lines.push("");
					}
				} else if (words[i].length > maxCharPerLine) { // Word too big for any line
					end = 0;
					incr = 0;
					while (end < words[i].length) 
					{
						incr = maxCharPerLine - lines[lines.length - 1].length;
						if ((incr + end) > words[i].length) {
							incr = words[i].length - end;
						}
						end += incr;
						lines[lines.length - 1] += words[i].substring(end - incr, end);
						if (end < words[i].length) {
							lines.push("");
						}
					}
					if ((i + 1) < words.length) {
						if (lines[lines.length - 1].length < maxCharPerLine) { // Room for space
							lines[lines.length - 1] += " ";
						} else {
							lines.push("");
						}
					}
				}else { // Word may fit on a line
					if (lines[lines.length - 1].length + words[i].length <= maxCharPerLine) { // Room for word on this line
						lines[lines.length - 1] += words[i];
						if ((i + 1) < words.length) {
							if (lines[lines.length - 1].length < maxCharPerLine) { // Room for space
								lines[lines.length - 1] += " ";
							} else {
								lines.push("");
							}
						}
					} else { // No room for word on this line (but word may fit on a line so must have word and space)
						lines[lines.length - 1] = lines[lines.length - 1].substr(0, lines[lines.length - 1].length - 1); // Remove space
						lines.push(words[i]);
						if ((i + 1) < words.length) {
							if (lines[lines.length - 1].length < maxCharPerLine) { // Room for space
								lines[lines.length - 1] += " ";
							} else {
								lines.push("");
							}
						}
					}
				}
			}
			return lines;
		}
		
		/**
		 * Generates bitmapData for a single line.
		 */
		private function generateSingleLineBitmapData():void 
		{
			var max:int = (_width + 1) / (_textChars.letter_width + LETTER_PADDING_HORIZONTAL);
			if (max > _charsPerLine) max = _charsPerLine;
			var extraSpace:int;
			if (_text.length >= max) {
				extraSpace = (_width / _scale) - ((max * (_textChars.letter_width + LETTER_PADDING_HORIZONTAL)) - 1);
			} else {
				extraSpace = (_width / _scale) - ((_text.length * (_textChars.letter_width + LETTER_PADDING_HORIZONTAL)) - 1);
			}
			_bitmapData = new BitmapData(_width, _textChars.letter_height, true, _backgroundColor);
			var rect:Rectangle;
			var pt:Point;
			var i:int = 0;
			if (_align == ALIGN_LEFT) {
				pt = new Point(0, 0);
			}else if (_align == ALIGN_CENTER) {
				pt = new Point(int(extraSpace / 2), 0);
			}else if (_align == ALIGN_RIGHT) {
				pt = new Point(extraSpace, 0);
			}
			while (i < max && i < _text.length) {
				rect = _textChars.RectangleFromCharCode(_text.charCodeAt(i));
				_bitmapData.copyPixels(_textChars.bitmapData, rect, pt, null, null, true);
				pt.x += _textChars.letter_width + LETTER_PADDING_HORIZONTAL;
				i++;
			}
		}
		
		/**
		 * Generates bitmapData for multiple lines.
		 */
		private function generateMultiLineBitmapData():void 
		{
			var rect:Rectangle;
			var pt:Point = new Point(0, 0);
			var i:int = 0;
			var j:int = 0;
			var maxLines:int = (_height + 1) / (_textChars.letter_height + LETTER_PADDING_VERTICAL);
			var extraSpace:int;
			var lines:Vector.<String> = convertTextToLines();
			_bitmapData = new BitmapData(_width, _height, true, _backgroundColor);
			while (i < maxLines && i < lines.length) {
				extraSpace = (_width / _scale) - ((lines[i].length * (_textChars.letter_width + LETTER_PADDING_HORIZONTAL)) - 1);
				if (_align == ALIGN_LEFT) {
					pt.x = 0;
				}else if (_align == ALIGN_CENTER) {
					pt.x = int(extraSpace / 2);
				}else if (_align == ALIGN_RIGHT) {
					pt.x = extraSpace;
				}
				for (j = 0; j < lines[i].length; j++) {
					rect = _textChars.RectangleFromCharCode(lines[i].charCodeAt(j));
					_bitmapData.copyPixels(_textChars.bitmapData, rect, pt, null, null, true);
					pt.x += _textChars.letter_width + LETTER_PADDING_HORIZONTAL;
				}
				pt.y += _textChars.letter_height + LETTER_PADDING_VERTICAL;
				i++;
			}
		}
		
		/**
		 * Generates the bitmapData for the textbox.
		 */
		private function generateBitmapData():void
		{
			if (_text.length > 0) {
				if (_singleLine) {
					generateSingleLineBitmapData();
				}else {
					generateMultiLineBitmapData();
				}
			}else {
				_bitmapData = new BitmapData(_width, _height, true, _backgroundColor);
			}
			if (_scale != 1) {
				var bd:BitmapData = new BitmapData(_bitmapData.width * _scale, _bitmapData.height * _scale, true, _backgroundColor);
				bd.draw(_bitmapData, _scaleMat);
				_bitmapData = bd;
			}
		}
		
	}
}