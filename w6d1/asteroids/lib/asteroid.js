(function () {
  if (window.Asteroids === undefined) {
    window.Asteroids = {};
  }
  var Asteroid = Asteroids.Asteroid = function (pos, game) {
    Asteroids.MovingObject.call(this, pos, game);
    this.color = "#00FF00";
    this.radius = 10;
    this.vel = [2*Math.random()-1, 2*Math.random()-1];
  };
  Asteroids.Util.inherits(Asteroids.Asteroid, Asteroids.MovingObject);
})();
