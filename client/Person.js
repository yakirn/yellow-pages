import React from 'react';
export default ({person: {name, age, address, phone, picture}}) => {
    return (
        <div className="cui__selector--direct__item">
          <img className="user-avatar" src={picture} />
          <div className="cui__selector--direct__label">
            {name}
          </div>
          <p className="cui__selector--direct__description">
            {address}
          </p>
        </div>
    )
}
