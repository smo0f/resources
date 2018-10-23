// @ Arrow functions
// normal function
function name(params) {
    // code...  
}

// Arrow function
const name = (params) => {
    // code...
}

// examples
// run here, https://jsbin.com/?js,console
const printMyName = (name) => {
    console.log(name);
}

printMyName('Max');

// alternative syntax for one argument
const printMyName = name => {
    console.log(name);
}

printMyName('Max');

// no argument
const printMyName = () => {
    console.log('name');
}

// alternative syntax one-liner, the return word is omitted
const printMyName = name => console.log(name);

printMyName('Max');

// @ Import and export statements/modules
// import default
import Person from "./module1";
import per from "./module1";
// import specific module
import { name } from "./module1";
// import specific module with alias
import { age as AGE } from "./module1";
// for importing all as a JavaScript object
import * as bundle from "./module1";

console.log(Person); 
console.log(per); 
console.log(name);
console.log(AGE);
console.log(bundle.name, bundle.age, bundle.Person.age);

// @ classes
// class syntax
// run here, https://jsbin.com/?js,console // ES6/Babel settings
// *** more modern syntax for classes
// # ES7 js
class Human3 {
    gender = 'male';

    printGender = () => {
        console.log(this.gender);
    }
}

class Person3 extends Human3 {
    name = 'Max$$$';
    // override Human3 class gender value
    gender = 'MALE';
    printMyName = () => {
        console.log(this.name);   
    }
}

const person = new Person3();
person.printMyName();
person.printGender();

// # other syntax for classes ES6
// run here, https://jsbin.com/?js,console
class Human {
    constructor() {
        this.gender = 'male';
    }

    printGender() {
        console.log(this.gender);
    }
}

class Person2 extends Human {
    // on instant create properties
    constructor() {
        // if you are extending a class and use a constructor function you must include the super function
        super();
        // property
        this.name = 'Max!!!';
    }
    // method
    printMyName() {
        console.log(this.name);   
    }
}

const person = new Person2();
person.printMyName();
person.printGender();

// @ Spread & Rest operator
// ...
// run here, https://jsbin.com/?js,console // ES6/Babel settings

// # Spread
// used to split up an array elements or object properties
// allows you to take an old array or object and copy it and then add new array or object pieces
// array
const numbers = [1, 2, 3, 4];
const newNumbers = [...numbers, 5, 6, 7];

console.log(newNumbers); // [1, 2, 3, 4, 5, 6, 7]

// object
const person4 = {
    name: 'max'
}

const newPerson4 = {
    ...person4,
    age: 45
}

console.log(newPerson4.name, newPerson4.age); // "max" 45

// # Rest
// turns a list of arguments into an array, used in a function
const filter = (...args) => {
    return args;
}

console.log(filter(1, 2, 3, 4, 'gogo', 'ham', 'soso')); // [1, 2, 3, 4, "gogo", "ham", "soso"]

// @ destructuring
// allows you to pull out elements of an array or an object and assign it to a variable
// run here, https://jsbin.com/?js,console // ES6/Babel settings
// array
const numbers2 = [1, 2, 3, 4];

[a,b] = ['Hello', 'Max'];
console.log(a); // Hello
console.log(b); // Max

[ , ,c,f] = numbers2;
console.log(c); // 3
console.log(f); // 4

// object, commented out so it doesn't throw an error
// {name} = {name: 'Max', age: 28};
// console.log(name); // Max
// console.log(age); // undefined