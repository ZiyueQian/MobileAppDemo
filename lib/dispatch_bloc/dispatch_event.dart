import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';

@immutable
abstract class DispatchEvent extends Equatable {
  DispatchEvent([List props = const []]) : super(props);
}

class LoadDispatches extends DispatchEvent {}

//class LoadHistory extends DispatchEvent {}

class AddDispatch extends DispatchEvent {
  final Dispatch newDispatch;

  AddDispatch(this.newDispatch) : super([newDispatch]);
}

//class AddHistory extends DispatchEvent {
//  final Dispatch newDispatch;
//
//  AddHistory(this.newDispatch) : super([newDispatch]);
//}

class DeleteDispatch extends DispatchEvent {
  final Dispatch dispatch;

  DeleteDispatch(this.dispatch) : super([dispatch]);
}
