import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';

@immutable
abstract class HistoryState extends Equatable {
  HistoryState([List props = const []]) : super(props);
}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Dispatch> dispatches;
  HistoryLoaded(this.dispatches) : super([dispatches]);
}
