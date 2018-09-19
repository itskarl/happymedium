import React from 'react';

import './Backdrop.css';
import Aux from '../../hoc/Aux/Aux';

const backdrop = () => (
    <Aux>
        <div className="Fullscreen-bg">
        <video loop="loop" muted="muted" autoplay="autoplay" poster="img/videoframe.jpg" className="Fullscreen-bg__video">
            <source src="sky.mp4" type="video/mp4" />
        </video>

        </div>
        <div className="City"></div>

    </Aux>

);

export default backdrop;

