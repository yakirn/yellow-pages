import React from 'react';
import SearchComponent from './SearchComponent';
import ResultsComponent from './ResultsComponent';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = { peopleSearch: { people: [], err: false }};
    this.searchPeople = this.searchPeople.bind(this);
  }

  searchPeople(searchString) {
      const searchArgs = getSearchArgs(searchString);
      callSearchApi(searchArgs)
      .then(results => this.setState({peopleSearch: { people: results.people, err: false }}))
      .catch(error => {
            console.error(error);
            this.setState({peopleSearch: { people: [], err: true}})
        });
  }

  render() {
    return (
      <div className="search">
        <SearchComponent search={this.searchPeople} />
        <ResultsComponent {...this.state.peopleSearch} />
      </div>
    );
  }
}

const searchUrl = '/api/v1/people/search?',
    argsRegExs = new Map();
    // argsRegExs.set('name', /([[a-zA-Z\.]+]{1,})/u);
    argsRegExs.set('phone', /(\d{3,})/g);
    argsRegExs.set('age', /(^|\s)(\d{1,2})($|\s)/g);

function callSearchApi(searchArgs){
    return fetch(`${searchUrl}${searchArgs}`)
            .then(response => response.json())
}

function getSearchArgs(searchString){
    const args = [];
    argsRegExs.forEach((regEx, argName) => {
        const match = regEx.exec(searchString);
        if (match && match.length) {
            // removing all found instances from the search string
            searchString = searchString.replace(regEx, '')
            args.push(`${argName}=${match[0].trim()}`);
        }
    });
    // Now the reamining string is the name
    searchString = searchString.trim();
    if (searchString.length) args.push(`name=${searchString}`);
    return args.join('&');
}
