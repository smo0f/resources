// @ component lifecycle
// Only in statefull components

// @ creation
    // https://www.udemy.com/react-the-complete-guide-incl-redux/learn/v4/t/lecture/8103740?start=0

    // # constructor()
    // Do not cause side effects, asynchronous calls/Ajax

    // # componentWillMount()
    // Do not cause side effects, asynchronous calls/Ajax

    // # render()
    // Do not cause side effects, asynchronous calls/Ajax
    // Prepare and structure your JSX code
    // Renders child components

    // # componentDidMount()
    // You can cause side effects, asynchronous calls/Ajax

// @ update
    // https://www.udemy.com/react-the-complete-guide-incl-redux/learn/v4/t/lecture/8103746?start=0

    // # componentWillReceiveProps()
    // sync state to props
    // Do not cause side effects, asynchronous calls/Ajax

    // # shouldComponentUpdate()
    // * can save performers, if used wisely
    // https://www.udemy.com/react-the-complete-guide-incl-redux/learn/v4/t/lecture/8103748?start=0
    // can cancel the update
    // Do not cause side effects, asynchronous calls/Ajax

    // # componentWillUpdate()
    // sync state to props
    // Do not cause side effects, asynchronous calls/Ajax

    // # render()
    // update child props

    // # componentDidUpdate
    // You can cause side effects, asynchronous calls/Ajax
    // don't update state

// @ others
    // https://www.udemy.com/react-the-complete-guide-incl-redux/learn/v4/t/lecture/8103752?start=0