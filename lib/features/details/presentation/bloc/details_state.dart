import 'package:chemical_compounds/features/details/data/models/description_model.dart';
import 'package:chemical_compounds/features/details/data/models/synonyms_model.dart';
import 'package:equatable/equatable.dart';

abstract class DetailsState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class DetailInitial extends DetailsState {}

class DetailLoading extends DetailsState {}

class DetailLoaded extends DetailsState {
  final List<Description> listOfDescription;
  final List<Synonym> listOfSynonyms;

  DetailLoaded(this.listOfDescription, this.listOfSynonyms);

  @override
  List<Object?> get props => <Object?>[listOfDescription, listOfSynonyms];
}

class DetailError extends DetailsState {
  final String message;

  DetailError(this.message);

  @override
  List<Object?> get props => <Object?>[message];
}
