import 'package:chemical_compounds/features/home/data/models/properties_model.dart';
import 'package:chemical_compounds/features/home/data/repositories/home_repositoy_impl.dart';
import 'package:chemical_compounds/features/home/presentation/bloc/home_event.dart';
import 'package:chemical_compounds/features/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<FetchCompoundEvent>((
      FetchCompoundEvent event,
      Emitter<HomeState> emit,
    ) async {
      emit(HomeLoading());
      try {
        final List<Property> items = await repository.getItems(
          cids: event.cids,
        );
        emit(HomeLoaded(items));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    // New event handler for search API call.
    on<FetchSearchApiEvent>((event, emit) async {
      emit(SearchApiLoading());
      try {
        final result = await repository.searchCompound(query: event.query);
        emit(SearchApiLoaded(result));
      } catch (e) {
        emit(SearchApiError(e.toString()));
      }
    });

    // New event handler for button API call.
    on<FetchCIDApiEvent>((event, emit) async {
      emit(CIDApiLoading());
      try {
        final result = await repository.getCID(
          compoundName: event.compoundName,
        );
        emit(CIDApiLoaded(result));
      } catch (e) {
        emit(CIDApiError(e.toString()));
      }
    });
  }
}
