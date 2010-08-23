var Rectangle = Class.create(Sprite, {
  initialize: function($super, fillStyle, strokeStyle) {
	$super(fillStyle, strokeStyle);
  },

  render: function($super, context, bounds) {
    $super(context, bounds);
    context.fillRect(this.x, this.y, this.width, this.height);
  }
});