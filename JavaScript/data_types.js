// @ data_types
    // # strings
        let name = 'Sam';
        name = "Sam";
        name = `Sam`;
            // const dynamicString = `Sam is ${num3} years old`;
            // or
            const dynamicString = `Sam is ${num3 + num2} years old`;
            console.log(dynamicString);
    // # numbers
        const num1 = 1;
        const num2 = -3;
        const num3 = 22.96; // also called a float
    // # booleans
        // true, false 
        let toggleSwitch = true;
        console.log(toggleSwitch); // true

        toggleSwitch = false;
        console.log(toggleSwitch); // false

        toggleSwitch = !toggleSwitch;
        console.log(toggleSwitch); // true
    // # arrays
        const array = [1,2,3,['Sam','Joe','Dan', {name: 'Russell', age: 32,}]];
        console.log(array);
        console.log(array[0]);
        console.log(array[2]);
        console.log(array[3]);
        console.log(array[3][0]);
        console.log(array[3][2]);
        console.log(array[3][3]);
        console.log(array[3][3].name);
        console.log(array[3][3]['name']);
        
        // add to array 
        array.push(4);
        console.log(array);
        console.log(array[4]);
    // # objects
        const user = {
            name: 'Russell',
            age: 32,
            items: {
                sword: 'Grilthorp Blade',
                shield: 'LionHart',
                otherItems: {
                    potion: {number:3, hpEffect: 75}
                }
            }
        };
        console.log(user);
        console.log(user.name);
        console.log(user['name']);
        console.log(user.items.shield);
        console.log(user.items.otherItems.potion.number);
        console.log(user['items']['otherItems']['potion']['number']);