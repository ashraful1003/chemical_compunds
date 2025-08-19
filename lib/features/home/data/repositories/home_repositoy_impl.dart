import 'package:chemical_compounds/features/home/data/datasources/home_remote_data_source.dart';
import 'package:chemical_compounds/features/home/data/models/properties_model.dart';

class HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepository(this.remoteDataSource);

  Future<List<Property>> getItems({
    required String compoundName,
    required String properties,
  }) async {
    return await remoteDataSource.fetchItems(
      compoundName: compoundName,
      properties: properties,
    );
  }
}
