var Ball = Class.create(Sprite, {
  initialize: function($super, fillStyle, strokeStyle) {
	$super(fillStyle, strokeStyle);
  	this.radius = 0;
    this.velocity = this.generateRandomVelocity();
  },

// Sprite Interface Methods
  render: function($super, context) {
    $super(context);
	context.save();

    context.globalAlpha = .4;
	context.beginPath();
	context.arc(this.x, this.y, this.radius, 0, Math.PI * 2, false);
	context.closePath();
	context.fill();

	context.shadowColor = "#333333";
	context.shadowOffsetY = 3;
	context.shadowBlur = 2;
    context.globalAlpha = .9;

	context.stroke();
	
	context.restore();
  },
  update: function($super, elapsedTime, bounds) {
	$super(elapsedTime, bounds);
	this.x += this.velocity.x;
	this.y += this.velocity.y;
	if(this.x - this.radius < bounds.x || this.x + this.radius > bounds.x + bounds.width){
		this.velocity.x = this.velocity.x * -1;
	}
	if(this.y - this.radius < bounds.y || this.y + this.radius > bounds.y + bounds.height){
		this.velocity.y = this.velocity.y * -1;
	}
  },

// Utility Methods
  generateRandomVelocity: function(){
	var velocity = {x: 0, y:0};
	velocity.x = Math.random()*Math.random()*5+3;
	velocity.y = Math.random()*Math.random()*5+3;
	Math.random() > .5 ? velocity.x : velocity.x * -1;
	Math.random() > .5 ? velocity.y : velocity.y * -1;
	return velocity;
  }
});