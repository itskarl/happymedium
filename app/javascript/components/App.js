import React, { Component } from 'react';

import Aux from './hoc/Aux/Aux';
import Backdrop from './UI/Backdrop/Backdrop';
import NavigationItems from './Navigation/NavigationItems/NavigationItems';
class App extends Component {
    render () {
        return (
            <Aux>
                <Backdrop />
                <NavigationItems />
                <div>CONTAINER</div>
                <div>BODY</div>
            </Aux>

        );
    }
}



export default App;