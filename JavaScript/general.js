// @ general
    // # help
        // google, MDN 
        // developer tools, Google
        // ? https://www.udemy.com/course/javascript-the-complete-guide-2020-beginner-advanced/learn/lecture/15918032#overview
        // Google Chrome DevTools Docs: 
        // ? https://developers.google.com/web/tools/chrome-devtools/
    // # global versus local/block scope
        let number1; // global scope
        console.log("number1 =", number1);
        const add = (num1, num2) => {
            number1 = num1 + num2; // global scope
            const number2 = num1 + num2; // function based or local/block scope
            console.log("number2, inside function =", number2);
            return number2;
        }    
        add(55, 66);
        console.log("number1 =", number1);
        // console.log("number2, out side function", number2); // error
        console.log("add(55, 66) =", add(55, 66));

        // also can also call global functions inside of a function
    // # shadowing
        let userName = 'Max';
        function greetUser(name) {
            let userName = name; // shadowing, re-declaring a variable within a different scope 
            console.log(userName);
        }
        userName = 'Manu';
        greetUser('Max');
    // # defer
        // defender allows you to load the JavaScript and then run it once the page is loaded (html is parsed).
        // <script scr="some/path.js" defer></script>
        // ? https://www.udemy.com/course/javascript-the-complete-guide-2020-beginner-advanced/learn/lecture/15853282#overview
        // ? https://www.udemy.com/course/javascript-the-complete-guide-2020-beginner-advanced/learn/lecture/15855662#overview
    // # async
        // once it loads it will run, but it doesn't stop the HTML from being parsed
        // <script scr="some/path.js" async></script>
        // ! using async runs the script as soon as it's ready, all dependencies should be in that file. Otherwise you have no assurance that you get all necessary dependence at the right time.
        // ? https://www.udemy.com/course/javascript-the-complete-guide-2020-beginner-advanced/learn/lecture/15853282#overview
        // ? https://www.udemy.com/course/javascript-the-complete-guide-2020-beginner-advanced/learn/lecture/15855662#overview
        