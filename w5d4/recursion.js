var exp1 = function (b, n) {
  if ( n === 0) {return 1;}
  else if (n === 1) {return b;}
  else {return b * exp1(b, (n -1));}
};

// console.log(exp1(3,4));

var exp2 = function (b, n) {
  if ( n === 0) {
    return 1;
  } else if (n === 1) {
    return b;
  } else if (n % 2 === 0) {
    return exp2(b, n / 2) * exp2(b, n / 2);
  } else {
    return b * (exp2(b, (n - 1) / 2) * exp2(b, (n - 1) / 2));
  }
};

// console.log(exp2(4,4));

var fibonacci = function (num) {
  if ( num === 1) {
    return [0];
  } else if ( num === 2) {
    return [0, 1];
  } else {
    var lastFib = fibonacci(num-1);
    var len = lastFib.length;
    var newFib = lastFib[len-1] + lastFib[len-2];
    lastFib.push(newFib);
    return lastFib;
  }
};

// console.log(fibonacci(18));

var binarySearch = function (array, target) {
  var pivot = Math.floor(array.length / 2);

  if (array[pivot] > target) {
    return binarySearch(array.slice(0,pivot), target);

  } else if (array[pivot] < target) {
    return pivot + binarySearch(array.slice(pivot+1, array.length), target);

  } else {
    return pivot;
  }
};

// console.log(binarySearch([1, 2, 3], 1));

var makeChange = function (coins, target) {
  if(coins.length === 0) { return null; }

  if (coins[0] === target) {
    return [coins[0]];
  } else if (coins[0] > target) {
    return makeChange(coins.slice(1), target);
  } else {
    var choice1 = [coins[0]].concat(makeChange(coins, target - coins[0]));
    var choice2 = makeChange(coins.slice(1), target);
    if (choice2 === null || choice2.length > choice1.length) {
      return choice1;
    } else {
      return choice2;
    }
  }
};

console.log(makeChange([10, 7, 1], 14));
