import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class FetchItemsEvent extends HomeEvent {
  final String cids;

  FetchItemsEvent({required this.cids});

  @override
  List<Object?> get props => <Object?>[cids];
}
