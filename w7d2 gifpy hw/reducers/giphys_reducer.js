import { RECEIVE_SEARCH_GIPHYS } from '../actions/giphy_actions';

let initialState = [];

const GiphyReducer(previous_state=initialState, action) => {

  switch (action.type) {
    case RECEIVE_SEARCH_GIPHYS:
      return action.giphys;
    default:
      return previous_state;
  }
};

export default GiphysReducer;
