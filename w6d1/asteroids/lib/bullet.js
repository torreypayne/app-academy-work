(function () {
  if (window.Asteroids === undefined) {
    window.Asteroids = {};
  }
  var Bullet = Asteroids.Bullet = function(ship, dir) {
    this.pos = this.ship.pos;
    this.vel = [50,50];
    this.dir = dir;
    this.radius = 3;
    this.color = "blue";
  };

  Asteroids.Util.inherits(Asteroids.Bullet, Asteroids.MovingObject);

})();
