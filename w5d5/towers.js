var readline = require('readline');

var reader = readline.createInterface({
  // MAGICK!!
  input: process.stdin,
  output: process.stdout
});


function HanoiGame () {
  var  that = this;
  var stacks = [[3,2,1],[],[]];
  var isValidMove = function(startTowerIdx, endTowerIdx) {
    if (that.stacks[startTowerIdx].length === 0) {
      return false;
    } else if (stacks[endTowerIdx].length === 0) {
      return true;
    } else {
      var startTower = that.stacks[startTowerIdx];
      var startLength = startTower.length;
      var endTower = that.stacks[endTowerIdx];
      var endLength = endTower.length;
      return (startTower[startLength-1] < endTower[endLength-1]);
    }
  };
  var move = function(startTowerIdx, endTowerIdx) {
    if (isValidMove(startTowerIdx, endTowerIdx)) {
      that.stacks[endTowerIdx].push(that.stacks[startTowerIdx].pop);
      return true;
    } else {
      return false;
    }
  };
  var print = function() {
    console.log(JSON.stringify(that.stacks));
  };
  var promptMove = function(callback) {
    that = this;
    that.print();
    reader.question("Where would you like to move a stack(from, to)?", function(answer) {
      var response = answer.split(",");
      var moveTo = parseInt(response[0]);
      var moveFrom = parseInt(response[1]);

      if (move(moveTo, moveFrom)) {
        callback(moveFrom, moveTo);
      } else {
        console.log("invalid move");
      }
      that.run(callback);
    });
  };
  var run = function(reader, completionCallback) {
    this.promptMove(reader, (function (startTowerIdx, endTowerIdx) {
      if (!this.move(startTowerIdx, endTowerIdx)) {
        console.log("Invalid move!");
      }

      if (!this.isWon()) {
        // Continue to play!
        this.run(reader, completionCallback);
      } else {
        this.print();
        console.log("You win!");
        completionCallback();
      }
    }).bind(this));
  };

}

HanoiGame.prototype.isWon = function() {
  return (this.stacks[1].length === 3) || (this.stacks[2].length === 3);
};


// Other way of defining HanoiGame is as a method... right?

// var hanoiGame = function () {
//
//   function startGame() {
//
//   }
//
// };

// By doing this, we define a singleton, which means we only have one instance
// of the class at any time; we cannot create more objects of the same class.
