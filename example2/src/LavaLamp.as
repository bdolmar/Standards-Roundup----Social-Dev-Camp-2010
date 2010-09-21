package {
	import __AS3__.vec.Vector;
	
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import sprites.Ball;
	import sprites.FramerateCounter;
	import sprites.IUpdateable;

	[SWF(width="960", height="576", frameRate="60")]
	public class LavaLamp extends Sprite
	{
		private var _lastUpdate:Number;
		private var _sprites:Vector.<Ball>;
		private var _framerateCounter:FramerateCounter;
		private var _ballCount:Number = 100;
		
		public function LavaLamp()
		{
			if(loaderInfo.parameters.ballCount){
				_ballCount = loaderInfo.parameters.ballCount;
			}
			
			addEventListener(Event.ADDED_TO_STAGE, createChildren, false, 0, true);
		}

// Scene Setup and Layout Methods and Properties		
		private function createChildren(evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, createChildren);
			stage.addEventListener(Event.RESIZE, onStageResize, false, 0, true);
			
			_sprites = new Vector.<Ball>();
			for(var i:int = 0; i < _ballCount; i++){
				var radius:int = Math.round(Math.random()*25 + 10);
				var fillColor:Number = Math.random()*0xFFFFFF;
				var ball:Ball = new Ball(radius, fillColor, 0xffffff);
				ball.x = Math.round(Math.random()*(stage.stageWidth - 2*radius))+radius;
				ball.y = Math.round(Math.random()*(stage.stageHeight- 2*radius))+radius;
				addChild(ball);
				_sprites.push(ball);
			}
			
			_framerateCounter = new FramerateCounter();
			_framerateCounter.x = 10;
			_framerateCounter.y = 10;
			addChild(_framerateCounter);
			
			layoutComponent();
			startUpdate();
		}
		
		private function layoutComponent():void
		{
			var gradientMatrix:Matrix = new Matrix();
			gradientMatrix.createGradientBox(stage.stageWidth, stage.stageHeight, -.5*Math.PI); 
			graphics.clear();
			graphics.beginGradientFill(GradientType.LINEAR, [0x999999, 0xeeeeee], [1, 1], [0, 128], gradientMatrix);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
		}
		
		private function onStageResize():void
		{
			layoutComponent();
		}

// Update Methods and Properties
		private function startUpdate():void
		{
			_lastUpdate = getTimer();
			addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
		
		private function stopUpdate():void
		{
			removeEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(evt:Event):void
		{
			var currentTime:Number = getTimer();
			var elapsedTime:Number = currentTime - _lastUpdate;
			_lastUpdate = currentTime;
			var bounds:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			
			for each(var sprite:IUpdateable in _sprites){
				sprite.update(elapsedTime, bounds);
			}
			
			_framerateCounter.update(elapsedTime, bounds);
		}
	}
}
