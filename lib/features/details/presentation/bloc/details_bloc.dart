import 'package:chemical_compounds/features/details/data/models/description_model.dart';
import 'package:chemical_compounds/features/details/data/models/synonyms_model.dart';
import 'package:chemical_compounds/features/details/data/repositories/details_repository_impl.dart';
import 'package:chemical_compounds/features/details/presentation/bloc/details_event.dart';
import 'package:chemical_compounds/features/details/presentation/bloc/details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final DetailsRepository repository;

  DetailsBloc(this.repository) : super(DetailInitial()) {
    on<FetchDetailsEvent>((
      FetchDetailsEvent event,
      Emitter<DetailsState> emit,
    ) async {
      emit(DetailLoading());
      try {
        final List<Description> listOfDescription = await repository
            .getDescription(event.cid);
        final List<Synonym> listOfSynonyms = await repository.getSynonyms(
          event.cid,
        );
        emit(DetailLoaded(listOfDescription, listOfSynonyms));
      } catch (e) {
        emit(DetailError(e.toString()));
      }
    });
  }
}
