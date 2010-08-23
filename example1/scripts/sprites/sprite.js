var Sprite = Class.create();
Sprite.prototype = {
  initialize: function(fillStyle, strokeStyle) {
	this.fillStyle = fillStyle;
	this.strokeStyle = strokeStyle;
    this.x = 0;
    this.y = 0;
    this.width = 0;
    this.height = 0;
  },
  render: function(context) {
	context.fillStyle = this.fillStyle;
	context.strokeStyle = this.strokeStyle;
	// override render function in subclass
  },
  update: function(elapsedTime, bounds) {
	
  },
  isSprite: function(){
	return true;
  }
};
