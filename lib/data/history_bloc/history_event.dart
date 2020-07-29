import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';

@immutable
abstract class HistoryEvent extends Equatable {
  HistoryEvent([List props = const []]) : super(props);
}

class LoadHistory extends HistoryEvent {}

class AddHistory extends HistoryEvent {
  final Dispatch newDispatch;

  AddHistory(this.newDispatch) : super([newDispatch]);
}

class DeleteHistory extends HistoryEvent {
  final Dispatch dispatch;

  DeleteHistory(this.dispatch) : super([dispatch]);
}
