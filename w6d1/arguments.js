function sum () {
  var total = 0;
  for (var i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }
  return total;
}

Function.prototype.myBind = function (obj) {
  var fn = this;
  var theArgs = Array.prototype.slice.call(arguments, 0);
  var currentObj = theArgs.shift();
  return function() {
     return fn.apply(currentObj, theArgs);
  };
};

function curriedSum(numArgs) {
  var numbers = [];
  return function _curriedSum (num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      return sum.myBind(null, numbers)();
    }
    else {
      return _curriedSum;
    }
    return _curriedSum;
  };
}

Function.prototype.curry = function(numArgs) {
  var args = [];
  var fn = this;
  return function _curried (arg) {
    args.push(arg);
    if (args.length === numArgs) {
      return fn.apply(null, args);
    }
    else {
      return _curried;
    }
    return _curried;
  };
};

Function.prototype.inherits = function(parent) {
  function Surrogate() {}
  Surrogate.prototype = parent.prototype;
  this.prototype = new Surrogate();
};

function Animal(name) {
  this.name = name;
}

Animal.prototype.bark = function() {
  console.log("bark");
};

function Dog(name) {
  Animal.call(this, name);
}

Dog.inherits(Animal);
var littleDog = new Dog("Sparky");
littleDog.bark();
console.log(littleDog.name);


// var someTotal = curriedSum(3);
// console.log(someTotal(1)(2)(3));

// var curryTotal = sum.curry(4);
// // console.log(curryTotal);
// console.log(curryTotal(5)(30)(20)(1));


// console.log(sum(1,2,3,4));
// var myBoundFunction = sum.myBind(null, 1, 2);
// console.log(myBoundFunction());

// function times(num, fun) {
//   for (var i = 0; i < num; i++) {
//     fun(); // call is made "function-style"
//   }
// }
//
// var cat = {
//   age: 5,
//
//   ageOneYear: function () {
//     this.age += 1;
//     console.log(this.age);
//   }
// };
//
// times(10, cat.ageOneYear.myBind(cat));
