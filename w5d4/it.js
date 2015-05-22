 var bubbleSort = function (array) {
   for (var i = 0; i < array.length; i++) {
      var sorted = false;
      while (sorted === false) {
        sorted = true;
        for (var j = i+1; j < array.length; j++) {
          var iVal = array[i];
          var jVal = array[j];
          if (iVal > jVal) {
            array[i] = jVal;
            array[j] = iVal;
            sorted = false;
          }
        }
      }
   }
   return array;
 };


// console.log(bubbleSort([5,4,3,23,1]));

var myUniq = function (array) {
  var newArray = [];
  for (var i = 0; i < array.length; i++) {
    if (newArray.indexOf(array[i]) === -1) {
      newArray.push(array[i]);
    }
  }
  return newArray;
};

var subStrings = function (string) {
  var results = [];
  for (var i = 0; i < string.length; i++) {
    for (var j = i+1; j < string.length; j++) {
      results.push(string.substring(i, j));
    }
  }
  return myUniq(results);
};

console.log(subStrings('Pancakes'));
