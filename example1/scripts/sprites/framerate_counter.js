var FramerateCounter = Class.create(Sprite, {
  initialize: function($super, fillStyle, strokeStyle) {
	$super(fillStyle, strokeStyle);
    this.label = "Framerate: -- ";
    this.elapsedFrames = 0;
    this.elapsedTime = 0;
  },

  render: function($super, context) {
    $super(context);
    context.save();
	context.font = "bold 12px sans-serif";
	context.textBaseline = "top";
	context.fillText(this.label, this.x, this.y);
	context.restore();
  },
  update: function($super, elapsedTime, bounds) {
	$super(elapsedTime, bounds);
	this.elapsedTime += elapsedTime;
	this.elapsedFrames++;
	if(this.elapsedTime > 500){
		var frames = Math.round(this.elapsedFrames/this.elapsedTime * 1000);
		this.label = "Framerate: " + frames;
	}
  }
});