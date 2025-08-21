import 'package:chemical_compounds/features/home/data/models/properties_model.dart';
import 'package:chemical_compounds/features/home/data/repositories/home_repositoy_impl.dart';
import 'package:chemical_compounds/features/home/presentation/bloc/home_event.dart';
import 'package:chemical_compounds/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc(this.repository) : super(const HomeState()) {
    on<FetchCompoundEvent>((
      FetchCompoundEvent event,
      Emitter<HomeState> emit,
    ) async {
      emit(state.copyWith(isCompoundLoading: true, error: null));
      try {
        final List<Property> items = await repository.getItems(
          cids: event.cids,
          compoundName: event.compoundName,
        );
        emit(state.copyWith(isCompoundLoading: false, compounds: items));
      } catch (e) {
        emit(state.copyWith(isCompoundLoading: false, error: e.toString()));
      }
    });

    on<FetchSearchApiEvent>((
      FetchSearchApiEvent event,
      Emitter<HomeState> emit,
    ) async {
      emit(state.copyWith(isSearchLoading: true, error: null));
      try {
        final List<String> result = await repository.searchCompound(
          query: event.query,
        );
        emit(state.copyWith(isSearchLoading: false, searchResults: result));
      } catch (e) {
        emit(state.copyWith(isSearchLoading: false, error: e.toString()));
      }
    });

    on<FetchCIDApiEvent>((
      FetchCIDApiEvent event,
      Emitter<HomeState> emit,
    ) async {
      emit(state.copyWith(isCompoundLoading: true, error: null));
      try {
        final List<int> result = await repository.getCID(
          compoundName: event.compoundName,
        );
        emit(state.copyWith(isCompoundLoading: false, cids: result));
        if (result.isNotEmpty) {
          add(
            FetchCompoundEvent(
              cids: result[0].toString(),
              compoundName: event.compoundName,
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(isCompoundLoading: false, error: e.toString()));
      }
    });
  }
}
