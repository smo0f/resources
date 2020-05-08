// @ built in functions
    // # map()
        // ? https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map
        // performed a function on each item in an array
        // makes a new array
        const numbers = [1, 2, 3, 4];
        const doubleNumArray = numbers.map((num) => {
            return num * 2;
        });

        console.log(numbers); // [ 1, 2, 3, 4 ]
        console.log(doubleNumArray); // [ 2, 4, 6, 8 ]

    // # find()
        // ? https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/find

    // # findIndex()
        // ? https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/findIndex

    // # filter()
        // ? https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter

    // # reduce()
        // ? https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce?v=b

    // # concat()
        // ? https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/concat?v=b

    // # slice()
        // ? https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/slice

    // # splice()
        // ? https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/splice

    // # parseFloat()
        console.log(parseFloat('1.33'));
        // ? https://www.udemy.com/course/javascript-the-complete-guide-2020-beginner-advanced/learn/lecture/15853246#overview
    // # parseInt()
        console.log(parseInt('1.33'));
        console.log(+'1.33'); // makes number
        console.log(1 + +'1.33'); // makes number
        // ? https://www.udemy.com/course/javascript-the-complete-guide-2020-beginner-advanced/learn/lecture/15853246#overview