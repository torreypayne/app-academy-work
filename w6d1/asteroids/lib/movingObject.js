(function () {
  if (window.Asteroids === undefined) {
    window.Asteroids = {};
  }

  var MovingObject = Asteroids.MovingObject = function (pos, game, vel, radius, color) {
    this.game = game;
    this.pos = pos;
    this.vel = vel;
    this.radius = radius;
    this.color = color;
  };

  MovingObject.prototype.draw = function(ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();

    ctx.arc(
      this.pos[0],
      this.pos[1],
      this.radius,
      0,
      2 * Math.PI,
      false
    );
    ctx.fill();
  };

  MovingObject.prototype.move = function() {
    this.pos = this.game.wrap(this.pos);
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
  };

  MovingObject.prototype.isCollidedWith = function(otherObject) {
    var x = Math.pow((this.pos[0] - otherObject.pos[0]), 2);
    var y = Math.pow((this.pos[1] - otherObject.pos[1]), 2);

    if (Math.sqrt(x+y) <= this.radius || Math.sqrt(x+y) <= otherObject.radius) {
      return true;
    }
    return false;
  };

  // MovingObject.prototype.collidedWith = function(otherObject) {
  //   if (this.isCollidedWith(otherObject)) {
  //     this.game.remove(otherObject);
  //     this.game.remove(this);
  //   }
  // };
})();
