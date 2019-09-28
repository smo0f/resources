// @ Two way binding
    // # Two way binding
        import React, { Component } from 'react';
        import Person from './Person/Person'

        export class Person extends Component {
            // state 
            // state is a reserved word
            state = {
                name = "Russell",
                persons: [
                {name: "Max", age: 33},
                {name: "Joe", age: 55},
                {name: "Sam", age: 77}
                ],
                data = {
                    jobs: [1,2,3,4,5,6,7]
                }    
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

            nameChangHandler = (event) => {
                // setState
                setState({
                    persons: [
                        {name: 'Max', age: 33},
                        {name: event.target.value, age: 55},
                        {name: "Sam", age: 22}
                    ]
                })
            }

            render() {
                return (
                    <div>
                        <Person 
                            name={this.state.persons[0].name} 
                            age={this.state.persons[0].age}
                            // pass method reference, and pass back info, 'Maximilian' gets passed as newName into the switchNameHandler Method
                            click={this.switchNameHandler.bind(this, 'Maximilian')}
                            changed={this.nameChangHandler} 
                        />
                        {/*Send name handler*/}
                        <button onClick={this.switchNameHandler}>Switch Name</button>
                    </div>
                )
            }
        }

        export default Person

        // Inside person component
        import React from 'react'
        
        const person = (props) => {
            return (
                <div>
                    <p onClick={props.click}>{props.name}</p> 
                    <input type="text" onChange={props.changed} value={props.name}/>
                </div>
            )
        }
        
        export default person

        // ? https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/8090892#overview