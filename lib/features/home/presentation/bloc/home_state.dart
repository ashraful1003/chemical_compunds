// import 'package:chemical_compounds/features/home/data/models/properties_model.dart';
// import 'package:equatable/equatable.dart';
//
// abstract class HomeState extends Equatable {
//   @override
//   List<Object?> get props => <Object?>[];
// }
//
// class HomeInitial extends HomeState {}
//
// class HomeLoading extends HomeState {}
//
// //load data from shared preferences
// class HomeLoaded extends HomeState {
//   final List<Property> items;
//
//   HomeLoaded(this.items);
//
//   @override
//   List<Object?> get props => <Object?>[items];
// }
//
// class HomeError extends HomeState {
//   final String message;
//
//   HomeError(this.message);
//
//   @override
//   List<Object?> get props => <Object?>[message];
// }
//
// // search api states
// class SearchApiLoading extends HomeState {}
//
// class SearchApiLoaded extends HomeState {
//   final List<String> result;
//
//   SearchApiLoaded(this.result);
//
//   @override
//   List<Object?> get props => <Object?>[result];
// }
//
// class SearchApiError extends HomeState {
//   final String message;
//
//   SearchApiError(this.message);
//
//   @override
//   List<Object?> get props => <Object?>[message];
// }
//
// // cid api states
// class CIDApiLoading extends HomeState {}
//
// class CIDApiLoaded extends HomeState {
//   final List<int> result;
//
//   CIDApiLoaded(this.result);
//
//   @override
//   List<Object?> get props => <Object?>[result];
// }
//
// class CIDApiError extends HomeState {
//   final String message;
//
//   CIDApiError(this.message);
//
//   @override
//   List<Object?> get props => <Object?>[message];
// }

import 'package:chemical_compounds/features/home/data/models/properties_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<Property> compounds;
  final List<String> searchResults;
  final List<int> cids;
  final bool isCompoundLoading;
  final bool isSearchLoading;
  final String? error;

  const HomeState({
    this.compounds = const <Property>[],
    this.searchResults = const <String>[],
    this.cids = const <int>[],
    this.isCompoundLoading = false,
    this.isSearchLoading = false,
    this.error,
  });

  HomeState copyWith({
    List<Property>? compounds,
    List<String>? searchResults,
    List<int>? cids,
    bool? isCompoundLoading,
    bool? isSearchLoading,
    String? error,
  }) {
    return HomeState(
      compounds: compounds ?? this.compounds,
      searchResults: searchResults ?? this.searchResults,
      cids: cids ?? this.cids,
      isCompoundLoading: isCompoundLoading ?? this.isCompoundLoading,
      isSearchLoading: isSearchLoading ?? this.isSearchLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    compounds,
    searchResults,
    cids,
    isCompoundLoading,
    isSearchLoading,
    error,
  ];
}
