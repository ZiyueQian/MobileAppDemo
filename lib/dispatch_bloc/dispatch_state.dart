import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';

@immutable
abstract class DispatchState extends Equatable {
  DispatchState([List props = const []]) : super(props);
}

//class DispatchInitial extends DispatchState {}

class DispatchesLoading extends DispatchState {}

class DispatchesLoaded extends DispatchState {
  final List<Dispatch> dispatches;
  DispatchesLoaded(this.dispatches) : super([dispatches]);
}
