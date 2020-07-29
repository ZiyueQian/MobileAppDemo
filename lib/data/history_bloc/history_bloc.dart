import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenwaydispatch/data/history_dao.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'history_bloc.dart';
import 'history_state.dart';
import 'history_event.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryLoading());

  HistoryDAO _historyDAO = HistoryDAO();

  // Display a loading indicator right from the start of the app
  @override
  HistoryState get initialState => HistoryLoading();

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is LoadHistory) {
      //home page
      // Indicating that dispatches are being loaded - display progress indicator.
      yield HistoryLoading();
      yield* _reloadHistory();
    } else if (event is AddHistory) {
      await _historyDAO.insertHistory(event.newDispatch);
      yield* _reloadHistory();
    } else if (event is DeleteHistory) {
      await _historyDAO.deleteHistory(event.dispatch);
      yield* _reloadHistory();
    }
  }

  Stream<HistoryState> _reloadHistory() async* {
    final dispatches = await _historyDAO.getHistorySortedByTime();
    // Yielding a state bundled with the Dispatches from the database.
    yield HistoryLoaded(dispatches);
  }
}
