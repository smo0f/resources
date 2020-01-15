// @ props
    // # props
        // functional components receive "props" (props as a default argument that comes in)
            // {props.name}
            // <Person name="Russell (props.name)"></Person>
            
        import React from 'react'
        
        const person = (props) => {
            return (
                <div>
                    <p>{props.name}</p> 
                </div>
            )
        }
        
        export default person
        
        // When using class-based components props is referred to as "this.props"
            // {this.props.name}
            // <Person name="Russell (this.props.name)" />

        import React, { Component } from 'react'
        
        export class Person extends Component {
            render() {
                return (
                    <div>
                        <p>{this.props.name}</p>
                    </div>
                )
            }
        }
        
        export default Person
        
        // ? lesson 35 Working with Props, https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/8090870#overview

    // # props children
        /* 
            <Person name="Russell (props.name)">
                Some text (props.children) 
            </Person>
        */

        import React from 'react'
            
        const person = (props) => {
            return (
                <div>
                    <p>{props.name}</p> 
                    <p>{props.children}</p> 
                </div>
            )
        }
        
        export default person

        // ? lesson 36 Understanding the Children Property, https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/8090872#overview

// Information on state and props
// ? https://www.udemy.com/react-the-complete-guide-incl-redux/learn/lecture/8124208#overview
