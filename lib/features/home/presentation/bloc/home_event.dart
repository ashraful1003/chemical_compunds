import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class FetchItemsEvent extends HomeEvent {
  final String compoundName;
  final String properties;

  FetchItemsEvent({required this.compoundName, required this.properties});

  @override
  List<Object?> get props => <Object?>[compoundName, properties];
}
