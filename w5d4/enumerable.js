var myEach = function (array, funct) {
  for (var i = 0; i < array.length; i++) {
    funct(array[i]);
  }
  return array;
};

var say = function (num) {
  return (num + 2);
};

var myMap = function (array, fun1) {
  var result = [];

  var gutFun = function (num) {
     result.push(fun1(num));
  };

  myEach(array, gutFun);
  return result;
};

var adder = function(x,y) {
  return x + y;
};

var myInject = function(array, funct) {
  var accumulator = array.shift();
  var inject_funct = function (num) {
    accumulator = funct(accumulator, num);
  }
  myEach(array, inject_funct);
  return accumulator;
};

var myInject1 = function(array, funct) {
  var accumulator = array[0];
  for (var i = 1; i < array.length; i++) {
    accumulator = funct(accumulator, array[i]);
  }
  return accumulator;
};

// myEach([1,2,3], say);

// myEach([1,2,3], console.log);

// console.log(myMap([1,2,3], say));
console.log(myInject([1,2,3], adder));
// console.log(myInject1([1,2,3], adder));
