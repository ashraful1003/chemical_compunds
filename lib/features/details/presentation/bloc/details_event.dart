import 'package:equatable/equatable.dart';

abstract class DetailsEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class FetchDetailsEvent extends DetailsEvent {
  final int cid;

  FetchDetailsEvent(this.cid);

  @override
  List<Object?> get props => <Object?>[cid];
}
