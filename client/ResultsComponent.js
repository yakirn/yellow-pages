import React from 'react';
import PeopleList from './PeopleList';

const getResultsComponent = (people, err) => {
    if (err) return (<div>An error occured.</div>);
    if (!people || !people.length ) return (<div>No results, please review your search or try a different one</div>)

    return <PeopleList people={people} />
}

export default ({people, err}) => {
    return (
        <div className="results">
          <div className="cui__selector--direct title">
            <h2 className="cui__selector--direct__title">
              Search results
            </h2>
            {
                getResultsComponent(people, err)
            }
          </div>
        </div>
    )
}
