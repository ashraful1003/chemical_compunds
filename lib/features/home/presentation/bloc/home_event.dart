import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class FetchCompoundEvent extends HomeEvent {
  final String cids;

  FetchCompoundEvent({required this.cids});

  @override
  List<Object?> get props => <Object?>[cids];
}

class FetchSearchApiEvent extends HomeEvent {
  final String query;

  FetchSearchApiEvent({required this.query});

  @override
  List<Object?> get props => <Object?>[query];
}

class FetchCIDApiEvent extends HomeEvent {
  final String compoundName;

  FetchCIDApiEvent({required this.compoundName});

  @override
  List<Object?> get props => <Object?>[compoundName];
}
