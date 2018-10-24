// @ reference and primitive types

// # primitive types = numbers, strings, boolean
// this means when I create a new variable based off of that variable that it will make a copy of the first variable
let number = 1;
let num2 = number;
number = 2;

console.log(num2); // 1
console.log(number); // 2

// # reference type = arrays and objects
// this means when I create a new variable based off of another array or object that it will make a reference to that object or an array
const person = {
    name: 'russell'
}
const secondPerson = person;
person.name = 'max';

// because it's a reference
console.log(person); // max
console.log(secondPerson); // max

secondPerson.name = 'russell';

// because it's a reference
console.log(person); // russell
console.log(secondPerson); // russell

// to copy immutable way, make a real copy
const person3 = {...person};
person3.name = 'ham';

secondPerson.name = 'max';

console.log(person); // max
console.log(secondPerson); // max
console.log(person3); // ham