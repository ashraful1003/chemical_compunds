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
