import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import RootReducer from '../reducers/root_reducer';

// import RootReducers from '../reducers/root_reducer'


const configureStore = () => {
  return createStore(RootReducer);
};

export default configureStore;
