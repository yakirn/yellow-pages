import React from 'react';
import Person from './Person.js'
export default ({people}) => {
    return (
        <div>
            {
                people.map(person => (<Person key={person.id} person={person} />))
            }
        </div>
    )
}
