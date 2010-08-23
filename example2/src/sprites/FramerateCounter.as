package sprites
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class FramerateCounter extends Sprite implements IUpdateable
	{
		private var _label:TextField;
		private var _elapsedFrames:Number = 0;
		private var _elapsedTime:Number = 0;
		
		public function FramerateCounter()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, createChildren, false, 0, true);
		}
		
		private function createChildren(evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, createChildren);
			_label = new TextField();
			_label.defaultTextFormat = new TextFormat("_sans", 12, 0x000000, true);
			_label.autoSize = TextFieldAutoSize.LEFT;
			_label.text = "Framerate: --";
			addChild(_label);
		}
		
		public function update(elapsedTime:Number, bounds:Rectangle):void
		{
			if(!_label){
				return;
			}
			
			_elapsedTime += elapsedTime;
			_elapsedFrames++;
			if(_elapsedTime > 500){
				var frames:Number = Math.round(_elapsedFrames/_elapsedTime * 1000);
				_label.text = "Framerate: " + frames;
			}
		}		
	}
}