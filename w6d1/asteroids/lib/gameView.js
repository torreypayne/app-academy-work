(function () {
  if (window.Asteroids === undefined) {
    window.Asteroids = {};
  }

  var GameView = Asteroids.GameView = function(canvas) {
    this.game = new Asteroids.Game();
    this.ctx = canvas;
  };

  GameView.prototype.start = function() {
    var that = this.game;
    setInterval(that.step.bind(that), 20);
    setInterval(that.draw.bind(that, this.ctx), 20);
    setInterval(this.bindKeyHandlers, 5);
  };

  GameView.prototype.bindKeyHandlers = function() {
    var pressed = key.getPressedKeyCodes();
    for (var i = 0; i < pressed.length; i++) {
      if (pressed[i] === "W" || pressed[i] === "w") {
        this.game.ship.power([0,1]);
      } else if(pressed[i] === "A" || pressed[i] === "a") {
        this.game.ship.power([-1,0]);
      } else if(pressed[i] === "S" || pressed[i] === "s") {
        this.game.ship.power([0,-1]);
      } else if(pressed[i] === "D" || pressed[i] === "d") {
        this.game.ship.power([1,0]);
      }
    }
  };
})();
