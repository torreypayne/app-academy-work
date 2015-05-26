(function () {
  if (window.Asteroids === undefined) {
    window.Asteroids = {};
  }

  var Game = Asteroids.Game = function() {
    this.DIM_X = 800;
    this.DIM_Y = 600;
    this.NUM_ASTEROIDS = 10;
    this.asteroids = [];
    this.addAsteroids();
    this.ship = new Asteroids.Ship(this);
    this.bullets = [];
  };

  Game.prototype.randomPosition = function() {
    return [this.DIM_X * Math.random(), this.DIM_Y * Math.random()];
  };

  Game.prototype.addAsteroids = function() {
    var i = 0;
    while(i < this.NUM_ASTEROIDS) {
      this.asteroids.push(new Asteroids.Asteroid(this.randomPosition(), this));
      i++;
    }
  };

  Game.prototype.draw = function(ctx) {
    ctx.clearRect(0, 0, this.DIM_X, this.DIM_Y);
    this.allObjects().forEach(function(asteroid) {
      asteroid.draw(ctx);
    });
  };

  Game.prototype.moveObjects = function() {
    this.allObjects().forEach(function(asteroid) {
      asteroid.move();
    });
  };

  Game.prototype.wrap = function(pos, callback) {
    if (pos[0] >= this.DIM_X) {
      // var m = pos[1] / pos[0];
      // var b = pos[1] - m*pos[0];
      pos[0] = 0;
      // pos[1] = b;
    }
    else if (pos[0] <= 0) {
      // var m = pos[1] / pos[0];
      // var b = pos[1] - m*pos[0];
      pos[0] = this.DIM_X;
      // pos[1] = b;
    }
    else if (pos[1] >= this.DIM_Y) {
        pos[1] = 0;
    }
    else if (pos[1] <= 0){
      pos[1] = this.DIM_Y;
    }
    return pos;
  };

  Game.prototype.checkCollisions = function() {
    for(var i = 0; i < this.allObjects().length; i++) {
      for(var j = i+1; j < this.allObjects().length; j++) {
        this.allObjects()[i].collidedWith(this.allObjects()[j]);
      }
    }
  };

  Game.prototype.step = function() {
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.remove = function(asteroid) {
    var removeIndex = this.asteroids.indexOf(asteroid);
    this.asteroids.splice(removeIndex, 1);
  };

  Game.prototype.allObjects = function() {
    console.log(this.bullets);
    var all = this.asteroids.concat([this.ship]).concat(this.bullets);
    return all;
  };
})();
