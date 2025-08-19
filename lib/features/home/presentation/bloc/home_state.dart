import 'package:chemical_compounds/features/home/data/models/properties_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Property> items;

  HomeLoaded(this.items);

  @override
  List<Object?> get props => <Object?>[items];
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
