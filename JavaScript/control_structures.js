// @ control structures
    // # Boolean operators or logical operators
        // * preferred, forces you to write better code 
        // all log statements are true
        // == equals 
            console.log(2 == 2);
            console.log(2 == '2');
        // * === strict equals, vale and type
            console.log(2 == 2);
        // != not equal
            console.log(2 != 3);
            console.log(2 != '3'); 
        // * !== strict not equal, vale and type
            console.log(2 !== '2'); 
        // > greater than
            console.log(15 > 10); 
            console.log('f' > 'a'); 
            console.log('a' > 'B'); 
        // >= greater than or equal to
            console.log(10 >= 10); 
            console.log('a' >= 'a'); 
        // < less than
            console.log(5 < 10); 
            console.log('a' < 'f'); 
        // <= less than equal to
            console.log(10 <= 10); 
            console.log('f' <= 'f'); 
        // ! not/opposite
            console.log(!false);
        // !! converts from falsy or truthy to true or false
            console.log(!!''); // false
            console.log(!!0); // false
            console.log(!!'false');
            console.log(!!3);
            // ? https://www.udemy.com/course/javascript-the-complete-guide-2020-beginner-advanced/learn/lecture/15918518#overview
        // interesting comparison with objects and arrays ===, !==
            // ? https://www.udemy.com/course/javascript-the-complete-guide-2020-beginner-advanced/learn/lecture/15918374#overview
            
    // # combining conditions
        // &&, and
        // ||, or

    // # if
        const num1 = 3;
        if (num1 > 5) {
            console.log('Number is greater than five.');
        } else {
            console.log('Number is less than five.');
        }

    // # switch
        const num4 = 5;
        switch (num4) {
            case 1: console.log('Number is 1.'); break;
            case 2: console.log('Number is 2.'); break;
            case 3: console.log('Number is 3.'); break;
            case 4: console.log('Number is 4.'); break;
            case '5': console.log('Number is a string 5.'); break;
            case 5: console.log('Number is 5.'); break;
            default: console.log('Something else.'); break;
        }
        // ? switch statement comparison always compare like ===, both the quality and type
        // ? https://www.udemy.com/course/javascript-the-complete-guide-2020-beginner-advanced/learn/lecture/15918524#overview

    // # Ternary operator
        const ternaryValue = typeof num1 !== 'undefined' ? num1:null; 
        console.log(ternaryValue);
        // nested Ternary expressions, not very nice to read though
        const num3 = 70
        const nestedTernaryValue = num3 > 10 ? 
            num3 > 60 ? 'num3 > 60': '10 < num3 < 60': 
            num3 < 5 ? 'num3 < 5' : '5 < num3 < 10';
        console.log(nestedTernaryValue); 
        // makeshift ternary operator
        const fName = '';
        const username = 'Gogo!';
        const makeshiftTernaryOperator = fName || username;
        console.log(makeshiftTernaryOperator); 
        // ? https://www.udemy.com/course/javascript-the-complete-guide-2020-beginner-advanced/learn/lecture/15918518#overview
        // another weird one with the and operator
        const loggedIn = true;
        const username = 'Gogo2!';
        const makeshiftTernaryOperator2 = loggedIn && username;
        console.log(makeshiftTernaryOperator2); 
        // ? https://www.udemy.com/course/javascript-the-complete-guide-2020-beginner-advanced/learn/lecture/15918518#overview
        

    // # switch 
        const num2 = 6;
        switch (num2) {
            case 1: console.log('Number is 1.'); break;
            case 2: console.log('Number is 2.'); break;
            case 3: console.log('Number is 3.'); break;
            case 4: console.log('Number is 4.'); break;
            case 5: console.log('Number is 5.'); break;
            default: console.log('Number is greater than five.'); break;
        }
    
    // # truthy and falsy values
        let guess;
        const values = {
            'empty array': [], // truthy
            'empty object': {}, // truthy
            'empty string': "", // falsy
            'false': false, // falsy
            'true': true, // truthy
            'full array': [1,2,3], // truthy
            'full object': {
                name: 'Russell',
                age: 32
            }, // truthy
            'null': null,  // falsy
            'guess': guess, // falsy 
            'zero': 0, // falsy 
            'NaN': NaN // falsy 
        } 
        // loop over object
        for (const property in values) {
            const value = values[property];
            if (value) {
                console.log(`${property}: ${values[property]}, truthy`);
            } else {
                console.log(`${property}: ${values[property]}, falsy`);
            }
        }

    // # loops
        // ? https://www.udemy.com/course/javascript-the-complete-guide-2020-beginner-advanced/learn/lecture/15918528#overview
        // * for
            const array1 = ['Sam', 'Joe', 'Sammy', 'Jonny', 'Russell']
            for (let i = 0; i < array1.length; i++) {
                const name = array1[i];
                console.log(`Hi ${name}, how are you?`);
            }
        // * for of
            const array2 = ['Fred', 'Mike', 'Solly', 'Ginger', 'Alexander']
            for (const name of array2) {
                console.log(`Hi ${name}, how are you?`);
            }
        // * for in
            const obj = {
                name: 'Russell Moore',
                age: 32,
                hobbies: 'Coding!!!',
                degree: 'Master of Management Information Systems (MMIS)'
            }
            for (const key in obj) {
                console.log(`${key.toUpperCase()}: ${obj[key]}`);
            }
        // * while