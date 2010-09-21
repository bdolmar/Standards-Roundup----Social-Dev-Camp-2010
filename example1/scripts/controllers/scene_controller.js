var SceneController = Class.create();
SceneController.prototype = {
  framerate: 1000/60,  
	
  initialize: function(context,bounds) {
	  this.children = [];
	  this.frameInterval = null;
	  this.graphicContext = context;
	  this.lastUpdate = 0;
	  this.bounds = bounds;
	  SceneController.scene = this;
  },
  addChild: function(sprite) {
	if(!(sprite.isSprite())){
		throw "SceneController: Can only add Sprite objects to scene.";
	}
	this.children.push(sprite);
  },
  startUpdate: function(){
	 this.lastUpdate = new Date().getTime();
	 this.frameInterval = setInterval(this.update, this.framerate);
  },
  stopUpdate: function(){
	clearInterval(this.frameInterval);
  },
  update: function(){
	var scene = SceneController.scene;
	var currentTime = new Date().getTime();
	var elapsedTime = currentTime - scene.lastUpdate;
	scene.lastUpdate = currentTime;
	
//	console.log("Frame Tick: %o", elapsedTime);
	var numChildren = scene.children.length;
	for(var i = 0; i < numChildren; i++){
//		console.log("... sprite: %o", sprite);
		var sprite = scene.children[i];
		sprite.update(elapsedTime, scene.bounds);
		sprite.render(scene.graphicContext);
	}
  }
};
