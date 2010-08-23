package sprites
{
	import flash.geom.Rectangle;
	
	public interface IUpdateable
	{
		function update(elapsedTime:Number, bounds:Rectangle):void;
	}
}