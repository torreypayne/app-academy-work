function Cat (name, owner) {
  this.name = name;
  this.owner = owner;
  this.cuteStatment = function() {
    return this.owner + " loves " + this.name +".";
  };
}

Cat.prototype.meow = function () {
  console.log('Meow! says ' + (this.name));
};

console.log(new Cat('Maxim', 'Tosca').cuteStatment());
(new Cat('Torrey', 'Gerry').meow());
