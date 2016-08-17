import React from 'react';
import _ from 'lodash';

export default class SearchComponent extends React.Component {
    constructor(props) {
        super(props);
        this.state = {searchValue: ''};
        this.onTextChange = this.onTextChange.bind(this);
        this.search = _.debounce(props.search, 300, {leading: false});
    }

    onTextChange(event) {
        const value = event.target.value;
        this.setState({searchValue: value});

        this.search(value);
    }

    render() {
        return (
            <div className="search">
                <div className="cui__input giant">
                    <input className="cui__input__input" placeholder="Type your search query" onChange={this.onTextChange} />
                </div>
            </div>
        )
    }
  }
