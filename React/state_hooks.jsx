// @ state
    // Information on state and props
    // ? https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/8124208#overview

    // # Stateful component, class component
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
            render() {
                return (
                    <div>
                       <Person name={this.state.persons[0].name} age={this.state.persons[0].age}></Person> 
                    </div>
                )
            }
        }
        
        export default Person

        // ? https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/13556100#overview

    // # Manipulating state
        // Changes to state and props trigger re-render changes
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
            switchNameHandler = () => {
                console.log('Was click');
                this.setState({
                    persons: [
                        {name: "Hamlet", age: 33},
                        {name: "Joe", age: 55},
                        {name: "Sam", age: 22}
                    ]
                })
            }

            render() {
                return (
                    <div>
                        <Person name={this.state.persons[0].name} age={this.state.persons[0].age}></Person>
                        {/*Send name handler*/}
                        <button onClick={this.switchNameHandler}>Switch Name</button>
                    </div>
                )
            }
        }

        export default Person

        // ? https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/13556154#overview

    // # React hooks
        // react 16.8 ***
            // Changes to state and props trigger re-render changes
            import React, { useState } from 'react';
            import Person from './Person/Person'

            const App = props => {
                
                // state
                // Array destructuring = [stateArr, setState]
                // ! It does not merge with the old state but replaces it
                // Allows the ability to have multiple states within a functional component, watch video
                    // stateArr = Access state information
                    // setStateArr = change state so that react recognizes the change
                const [stateArr, setStateArr] = useState({
                    name = "Russell",
                    persons: [
                        {name: "Max", age: 33},
                        {name: "Joe", age: 55},
                        {name: "Sam", age: 77}
                    ],
                    data = {
                        jobs: [1,2,3,4,5,6,7]
                    }    
                })

                // Handler functions usually have the ending preference of handler
                const switchNameHandler = () => {
                    console.log('Was click');
                    // ! It does not merge with the old state but replaces it
                    // setState, Same name as in the array destructuring
                    setStateArr({
                        persons: [
                            {name: "Hamlet", age: 33},
                            {name: "Joe", age: 55},
                            {name: "Sam", age: 22}
                        ],
                        // adding this so I don't lose it
                        data: stateArr.data
                    })
                }

                return (
                    <div>
                        <Person name={stateArr.persons[0].name} age={stateArr.persons[0].age}></Person>
                        {/*Send name handler*/}
                        <button onClick={switchNameHandler}>Switch Name</button>
                    </div>
                )
            }

            export default App

        // multiple use states
            // Changes to state and props trigger re-render changes
            import React, { useState } from 'react';
            import Person from './Person/Person'

            const App = props => {
                
                // state
                // Array destructuring = [stateArr, setState]
                // ! It does not merge with the old state but replaces it
                // Allows the ability to have multiple states within a functional component, watch video
                    // getPersons = Access state information
                    // setPersons = change state so that react recognizes the change
                // I split apart the state so I don't have to update all the state just the one I need
                const [getPersons, setPersons] = useState({
                    persons: [
                        {name: "Max", age: 33},
                        {name: "Joe", age: 55},
                        {name: "Sam", age: 77}
                    ]   
                })

                const [getData, setData] = useState({
                    data = {
                        jobs: [1,2,3,4,5,6,7]
                    }    
                })

                // Handler functions usually have the ending preference of handler
                const switchNameHandler = () => {
                    console.log('Was click');
                    // ! It does not merge with the old state but replaces it
                    // setPersons, Same name as in the array destructuring
                    setPersons({
                        persons: [
                            {name: "Hamlet", age: 33},
                            {name: "Joe", age: 55},
                            {name: "Sam", age: 22}
                        ]
                    })
                }

                return (
                    <div>
                        <Person name={getPersons.persons[0].name} age={getPersons.persons[0].age}></Person>
                        {/*Send name handler*/}
                        <button onClick={switchNameHandler}>Switch Name</button>
                    </div>
                )
            }

            export default App

            // ? https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/13556164#overview
            // ? https://www.udemy.com/course/react-the-complete-guide-incl-redux/learn/lecture/13556164#overview