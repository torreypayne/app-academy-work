(function () {
  if (window.Asteroids === undefined) {
    window.Asteroids = {};
  }

  var GameView = Asteroids.GameView = function(canvas) {
    this.game = new Asteroids.Game();
    this.ctx = canvas;
  };

  GameView.prototype.start = function() {
    var game = this.game;
    var that = this;
    setInterval(game.step.bind(game), 20);
    setInterval(game.draw.bind(game, this.ctx), 20);
    setInterval(that.bindKeyHandlers.bind(that), 10);
  };

  GameView.prototype.bindKeyHandlers = function() {
    var pressed = key.getPressedKeyCodes();
    console.log(pressed);
    if (pressed.length > 0) {
      for (var i = 0; i < pressed.length; i++) {
        if (pressed[i] === 87) {
          this.game.ship.power([0,-0.1]);
        } else if(pressed[i] === 65) {
          this.game.ship.power([-0.1,0]);
        } else if(pressed[i] === 83) {
          this.game.ship.power([0,0.1]);
        } else if(pressed[i] === 68) {
          this.game.ship.power([0.1,0]);
        } else if(pressed[i] === 32) {
          this.game.ship.fireBullet();
        }
      }
    }
    else {
      this.game.ship.vel = [0,0];
    }
  };
})();
