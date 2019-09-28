// @ conditional rendering
    // # *** Conditional rendering the JavaScript way
        import React, { Component } from 'react';
        import Person from './Person/Person'

        export class Person extends Component {
            // state 
            state = {
                name = "Russell",
                persons: [
                    {name: "Max", age: 33},
                    {name: "Joe", age: 55},
                    {name: "Sam", age: 77}
                ]  
            }

            // Handler functions usually have the ending preference of handler
            switchNameHandler = (newName) => {
                console.log('Was click');
                // setState, Same name as in the array destructuring
                setState({
                    persons: [
                        {name: newName, age: 33},
                        {name: "Joe", age: 55},
                        {name: "Sam", age: 22}
                    ]
                })
            }

            // Name change handler function, two way binding
            nameChangHandler = (event) => {
                // setState
                setState({
                    persons: [
                        {name: 'Max', age: 33},
                        {name: event.target.value, age: 55},
                        {name: "Sam", age: 22}
                    ],
                    showPersons: false
                })
            }

            togglePersonsHandler = () => {
                // Set variable
                const doesShow = this.state.showPersons;
                // Change state
                this.setState({showPersons: !doesShow})
            }

            render() {
                // you can put in normal js

                // Conditional statement
                let persons = null;
                if (this.state.showPersons) {
                    persons = (
                        <div>
                            <Person 
                                name={this.state.persons[0].name} 
                                age={this.state.persons[0].age}
                                click={this.switchNameHandler.bind(this, 'Maximilian')}
                                changed={this.nameChangHandler} 
                            />
                        </div> 
                    );
                }

                // return the jsx 
                return (
                    <div>
                        {/*Send name handler*/}
                        <button onClick={this.togglePersonsHandler}>Switch Name</button>
                        {/* Creating a conditional statement */}
                        {persons}
                    </div>
                )
            }
        }

        export default Person

        // ? https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/8091068#overview

    // # conditional rendering ternary expression 
        import React, { Component } from 'react';
        import Person from './Person/Person'

        export class Person extends Component {
            // state 
            state = {
                name = "Russell",
                persons: [
                {name: "Max", age: 33},
                {name: "Joe", age: 55},
                {name: "Sam", age: 77}
                ]  
            }

            // Handler functions usually have the ending preference of handler
            switchNameHandler = (newName) => {
                console.log('Was click');
                // setState, Same name as in the array destructuring
                setState({
                    persons: [
                        {name: newName, age: 33},
                        {name: "Joe", age: 55},
                        {name: "Sam", age: 22}
                    ]
                })
            }

            // Name change handler function, two way binding
            nameChangHandler = (event) => {
                // setState
                setState({
                    persons: [
                        {name: 'Max', age: 33},
                        {name: event.target.value, age: 55},
                        {name: "Sam", age: 22}
                    ],
                    showPersons: false
                })
            }

            togglePersonsHandler = () => {
                // Set variable
                const doesShow = this.state.showPersons;
                // Change state
                this.setState({showPersons: !doesShow})
            }

            render() {
                return (
                    <div>
                        {/*Send name handler*/}
                        <button onClick={this.togglePersonsHandler}>Switch Name</button>
                        {/* Creating a conditional statement */}
                        { 
                            // if true
                            this.state.showPersons ? 
                                <div>
                                    <Person 
                                        name={this.state.persons[0].name} 
                                        age={this.state.persons[0].age}
                                        // pass method reference, and pass back info, 'Maximilian' gets passed as newName into the switchNameHandler Method
                                        click={this.switchNameHandler.bind(this, 'Maximilian')}
                                        changed={this.nameChangHandler} 
                                    />
                                </div> 
                            // if not true 
                            : null 
                        }
                    </div>
                )
            }
        }

        export default Person

        // ? https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/8091064#overview