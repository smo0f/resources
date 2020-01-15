// # function-based component
import React from 'react'

export default function Person() {
    return (
        <div>
            
        </div>
    )
}

// # class base component

import React, { Component } from 'react'

export default class Person extends Component {
    render() {
        return (
            <div>
                
            </div>
        )
    }
}

// # important component
    // import Person from './components.jsx';
    import Person from './components';

    // now use it in a class or functional component
    import React, { Component } from 'react'
    
    export default class OtherComponent extends Component {
        render() {
            return (
                <div>
                    {/* 
                        <Person name='Sam' (props.name)>
                            Some text (props.children), {code} (ability to insert dynamic code) 
                        </Person> 
                    */}
                    <Person name='Sam'>Some text, {code}</Person>    
                </div>
            )
        }
    }
    
