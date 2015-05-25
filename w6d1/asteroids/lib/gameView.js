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
    setInterval(that.moveObjects.bind(that), 20);
    setInterval(that.draw.bind(that, this.ctx), 20);
  };
})();
