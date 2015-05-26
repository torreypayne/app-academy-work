(function() {
  if (window.Asteroids === undefined) {
    window.Asteroids = {};
  }

  var Ship = Asteroids.Ship = function(game) {
    this.game = game;
    this.pos = [this.game.DIM_X/2, this.game.DIM_Y/2];
    this.vel = [0,0];
    this.color = "red";
    this.radius = 10;
  };

  Asteroids.Util.inherits(Asteroids.Ship, Asteroids.MovingObject);

  Ship.prototype.relocate = function() {
    this.pos = [this.game.DIM_X/2, this.game.DIM_Y/2];
    this.vel = [0,0];
  };

  Ship.prototype.power = function(impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };

})();
