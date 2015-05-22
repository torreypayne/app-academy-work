
console.log([3,5,1,1,3].length);


var myUniq = function (array) {
  var newArray = [];
  for (var i = 0; i < array.length; i++) {
    if (newArray.indexOf(array[i]) === -1) {
      newArray.push(array[i]);
    }
  }
  return newArray;
};

var twoSum = function (array) {
  var results = [];
  for (var i = 0; i < array.length; i++) {
    for (var j = i+1; j < array.length; j++) {
      if (array[i] + array[j] === 0) {
        results.push([i, j]);
      }
    }
  }
  return results;
};

var myTranspose = function (array) {
  var newArray = new Array(array.length);


  for (var i = 0; i < array.length; i++) {
    newArray[i] = new Array(array.length);
    for (var j = 0; j < array.length; j++) {
      newArray[i][j] = array[j][i];
    }
  }
  return newArray;
};

console.log(myUniq([3,5,1,1,3]));
console.log(twoSum([-1, 0, 2, -2, 1]));
var rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ];
console.log(myTranspose(rows));
