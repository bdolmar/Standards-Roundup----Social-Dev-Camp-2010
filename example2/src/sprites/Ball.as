package sprites
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Ball extends Sprite implements IUpdateable
	{
		private var _fillColor:uint = 0x00ff00;
		private var _lineColor:uint = 0xffffff;
		private var _radius:int = 0;
		private var _velocity:Point;
		private var _outline:Shape;
		
		public function Ball(radius:uint, fillColor:uint, lineColor:uint)
		{
			super();
			_radius = radius;
			_fillColor = fillColor;
			_lineColor = lineColor;
			_velocity = generateRandomVelocity();
			addEventListener(Event.ADDED_TO_STAGE, createChildren, false, 0, true);
		}
		
		private function createChildren(evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, createChildren);
			graphics.clear();
			graphics.beginFill(_fillColor, .4);
			graphics.drawCircle(0, 0, _radius);
			graphics.endFill();
			
			_outline = new Shape();
			_outline.graphics.clear();
			_outline.graphics.lineStyle(2, _lineColor, .9, true);
			_outline.graphics.drawCircle(0, 0, _radius);
			_outline.filters = [new DropShadowFilter(3, 90, 0x333333, .6, 3, 3)];
			addChild(_outline);
			
			cacheAsBitmap = true;
		}
		
		public function update(elapsedTime:Number, bounds:Rectangle):void
		{
			x += _velocity.x*elapsedTime;
			y += _velocity.y*elapsedTime;
			if((x - _radius < bounds.x && _velocity.x < 0) || 
			   (x + _radius > bounds.x + bounds.width && _velocity.x > 0)){
				_velocity.x = _velocity.x * -1;
			}
			if((y - _radius < bounds.y && _velocity.y < 0) || 
			   (y + _radius > bounds.y + bounds.height && _velocity.y > 0)){
				_velocity.y = _velocity.y * -1;
			}
		}
		
		private function generateRandomVelocity():Point
		{
			_velocity = new Point();
			_velocity.x = (Math.random()*Math.random()*5+3)/32;
			_velocity.y = (Math.random()*Math.random()*5+3)/32;
			Math.random() > .5 ? _velocity.x : _velocity.x * -1;
			Math.random() > .5 ? _velocity.y : _velocity.y * -1;
			return _velocity;
		}

		
	}
}