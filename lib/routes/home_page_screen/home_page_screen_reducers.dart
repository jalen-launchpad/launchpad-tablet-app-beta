import 'package:redux/redux.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen_actions.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen_state.dart';

HomePageScreenState Function(HomePageScreenState, dynamic) rootReducer =
    combineReducers([
  TypedReducer<HomePageScreenState, UpdateSidebarClassAction>(
      updateSidebarClassReducer),
]);

final Function(HomePageScreenState, UpdateSidebarClassAction)
    updateSidebarClassReducer =
    (HomePageScreenState state, UpdateSidebarClassAction action) {
  return state.copyWith(
    sidebarClass: action.workoutDetails,
  );
};
