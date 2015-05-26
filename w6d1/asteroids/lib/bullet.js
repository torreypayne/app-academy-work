(function () {
  if (window.Asteroids === undefined) {
    window.Asteroids = {};
  }
  var Bullet = Asteroids.Bullet = function(ship, dir) {
    this.game = ship.game;
    this.pos = ship.pos.slice(0);
    this.vel = [1,1];
    this.dir = dir;
    this.radius = 3;
    this.color = "blue";
  };

  Asteroids.Util.inherits(Asteroids.Bullet, Asteroids.MovingObject);

})();
