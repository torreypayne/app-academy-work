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

var merge = function (arr1, arr2) {
  var result = [];
  while (arr1.length > 0) {
    if (arr1[0] < arr2[0] || arr2.length === 0) {
      result.push(arr1.shift());
    } else {
      result.push(arr2.shift());
    }

  }

  while (arr2.length > 0) {
    result.push(arr2.shift());
  }
  return result;
};

var mergeSort = function (array) {
  if (array.length < 2) {
    return array;
  }
  else {
    return merge(mergeSort(array.slice(0,array.length / 2)), mergeSort(array.slice(array.length/2, array.length)));
  }
};

var myUniq = function (array) {
  var newArray = [];
  for (var i = 0; i < array.length; i++) {
    if (newArray.indexOf(array[i]) === -1) {
      newArray.push(array[i]);
    }
  }
  return newArray;
};

var myEach = function (array, funct) {
  for (var i = 0; i < array.length; i++) {
    funct(array[i]);
  }
  return array;
};

var subsets = function (array) {
  if (array.length === 0) {
    return [[]];
  }
  else {
    var result = [array];
    for (var i = 0; i < array.length; i++) {
      var newArray = array;
      newArray.splice(i,1);
      result.concat(subsets(newArray));
    }
  }

  return result;
};

// console.log(makeChange([10, 7, 1], 14));
// console.log(mergeSort([5,4,3,2,1]));
console.log(subsets([1,2,3]));
