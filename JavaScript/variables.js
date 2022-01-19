// @ variables
    // # variables
        // var = old way
        // difference between var, let, and const
            // ? https://www.udemy.com/course/javascript-the-complete-guide-2020-beginner-advanced/learn/lecture/15942558#overview
        // let = able to change (type: number, obj, string, array)
            // make variable
            let name = 'Sam';
            // change variable
            name = 'Joe';
            // can't do this once name has ben declared
            let name = 'Sam'; 
            let name = 'Kim';
            // var can
            var name = 'Sam'; 
            var name = 'Kim';
        // const = unable to change (type: number, obj, string, array)
            // make variable, can't change a constant
            const fName = 'Sam';
            // Some constants can change the inner parts just not its type/self
                // objects
                const obj = {
                    num1: 1,
                    num2: 2,
                    num3: 3
                };
                console.log(obj);
                obj.num1 = 4;
                obj.num2 = 5;
                obj.num3 = 6;
                console.log(obj);
                // arrays
                const array = [1,2,3];
                console.log(array);
                array[0] = 4;
                array[1] = 5;
                array[2] = 6;
                console.log(array);
    // # best practices
        // camel case variables 
            const lName;
            const userName;
            const GLOBAL_CONSTANT; // global constant convention 
        // Cases sensitive, Different variables below
            const NAMES;
            const names;
    // # allows and not
        const user_name;
        // ! Other special characters not allowed
        const $user_name;
        // ! don't start with a number
        const userName1;
        // ! no key words
        // let
        // const
        // class
    // # Copy versus reference
        // Copping a variable
            let num1 = 2;
            let num2 = num1 + 2;
            console.log(num1); // 2
            console.log(num2); // 4
            
        // Referencing a variable 
            const array2 = [1,2,3];
            const array3 = array2;
            array3[0] = 22;
            console.log(array2); // [ 22, 2, 3 ]
            console.log(array3); // [ 22, 2, 3 ]