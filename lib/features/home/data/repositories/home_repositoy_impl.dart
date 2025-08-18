import 'package:chemical_compounds/features/home/data/datasources/home_remote_data_source.dart';

class HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepository(this.remoteDataSource);

  Future<void> getItems() async {
    return await remoteDataSource.fetchItems();
  }
}
