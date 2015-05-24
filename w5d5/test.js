function times(num, fun) {
  for (var i = 0; i < num; i++) {
    fun(); // call is made "function-style"
  }
}

var cat = {
  age: 5,

  ageOneYear: function () {
    this.age += 1;
  }
};

// cat.ageOneYear(); // works
times(10, function () {
  cat.ageOneYear();  // Function arg so that ageOneYear is a closure.
});                  // What's important to notice here is that we refer
// directly to the cat object itself, thereby ensuring that this is in the
// correct context. Otherwise, cat.ageOneYear() will let 'this' loose, literally.


// This, however, is the best way to address problems of context:

times(10, cat.ageOneYear.bind(cat));  // Here, we set: this = cat ; which was defined earlier.

// What does bind do? Here, bind ensures that the cat.ageOneYear function is called on the cat object, effectively method-style.
// bind returns a function! Don't forget! But also, the function returned by cat.ageOneYear.bind(cat) will still be called function-style,
// but inside it will call ageOneYear on cat method style.

// Again, bind effectively closes cat.ageOneYear over the cat's context; think of it as jumping into the cat's scope or running code from that line of code again.


// console.log(times(10, cat.ageOneYear));
// // console.log(cat);
// console.log(cat.age);
