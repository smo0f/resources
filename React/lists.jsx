// @ lists
    // # Outputting lists
    import React, { Component } from 'react';
    import Person from './Person/Person'

    export class Person extends Component {
        // state 
        state = {
            name = "Russell",
            persons: [
                {id: 1, name: "Max", age: 33},
                {id: 2, name: "Joe", age: 55},
                {id: 3, name: "Sam", age: 77}
            ]  
        }

        // Deletes a person when clicked on
        deletePersonHandler = (personId) => {
            // make new array
            // const persons = this.state.persons.slice();
            // or
            const persons = [...this.state.persons];
            //  delete person
            persons.splice(personId, 1);
            // set state
            this.setState({persons: persons})

        }

        // Name change handler function, two way binding
        nameChangHandler = (event, id) => {
            // Find the person
            const personIndex = [...this.state.persons.findIndex(p => {
                return p.id === id;
            })];
            // Get the person, new object
            const person = {...this.state.persons[personIndex]};
            // Change the person
            person.name = event.target.value;
            // get state
            const persons = [...this.state.persons];
            persons[personIndex] = person;
            // setState
            setState({persons: persons})
        }

        // Toggles the hide and show of the person elements
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
                    // out put list
                    <div>
                        {this.state.persons.map(person => {
                            return
                                <Person 
                                    // important for efficiency, react expects 
                                    key={person.id}
                                    name={person.name} 
                                    age={person.age}
                                    // this might brake
                                    click={this.deletePersonHandler.bind(this, person.id)}
                                    // this is what he did
                                    // click={ () => this.deletePersonHandler.(person.id)}
                                    changed={this.nameChangHandler.bind(this, person.id)}
                                    // this is what he did 
                                    // changed={(event) => this.nameChangHandler(event, person.id)} 
                                />
                        })}
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

    // ? https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/8091072#overview
    // ? https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/8111600#overview
    // ? https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/8091074#overview
    // ? https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/8091076#overview
    // ? https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/8091078#overview