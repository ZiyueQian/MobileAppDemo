import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenwaydispatch/data/dispatch_dao.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'bloc.dart';

class DispatchBloc extends Bloc<DispatchEvent, DispatchState> {
  DispatchDAO _dispatchDAO = DispatchDAO();

  // Display a loading indicator right from the start of the app
  @override
  DispatchState get initialState => DispatchesLoading();

  @override
  Stream<DispatchState> mapEventToState(
    DispatchEvent event,
  ) async* {
    if (event is LoadDispatches) {
      //home page
      // Indicating that dispatches are being loaded - display progress indicator.
      yield DispatchesLoading();
      yield* _reloadDispatches();
    }
//    else if (event is LoadHistory) {
//      //history page
//      // Indicating that dispatches are being loaded - display progress indicator.
//      yield HistoryLoading();
//      yield* _reloadHistory();
//    }
    else if (event is AddDispatch) {
      await _dispatchDAO.insert(event.newDispatch);
      yield* _reloadDispatches();
    } else if (event is DeleteDispatch) {
      await _dispatchDAO.delete(event.dispatch);
      yield* _reloadDispatches();
    }
//    else if (event is AddHistory) {
//      await _dispatchDAO.insertHistory(event.newDispatch);
//      yield* _reloadDispatches();
//    }
  }

  Stream<DispatchState> _reloadDispatches() async* {
    final dispatches = await _dispatchDAO.getDispatchesSortedByTime();
    // Yielding a state bundled with the Dispatches from the database.
    yield DispatchesLoaded(dispatches);
  }

//  Stream<DispatchState> _reloadHistory() async* {
//    final dispatchHistory = await _dispatchDAO.getHistorySortedByTime();
//    // Yielding a state bundled with the Dispatches from the database.
//    yield HistoryLoaded(dispatchHistory);
//  }
}
