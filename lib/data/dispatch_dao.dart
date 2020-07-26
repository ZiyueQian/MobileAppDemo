//data access object
import 'package:sembast/sembast.dart';
import 'app_database.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';

class DispatchDAO {
  static const String dispatchNow = 'dispatches';
  static const String dispatchHistory = 'dispatchesHistory';

  //store with int keys and Map<String,dynamic> values
  final _dispatchStore = intMapStoreFactory.store(dispatchNow);
  final _historyStore = intMapStoreFactory.store(dispatchHistory);

  //private getter to get a singleton instance of an opened database
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Dispatch dispatch) async {
    await _dispatchStore.add(await _db, dispatch.toMap());
  }

  Future insertHistory(Dispatch dispatch) async {
    await _historyStore.add(await _db, dispatch.toMap());
  }

  Future update(Dispatch dispatch) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(dispatch.id));
    await _dispatchStore.update(
      await _db,
      dispatch.toMap(),
      finder: finder,
    );
  }

  Future delete(Dispatch dispatch) async {
    final finder = Finder(filter: Filter.byKey(dispatch.id));
    await _dispatchStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Dispatch>> getDispatchesSortedByTime() async {
    // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('dispatchTime'),
    ]);

    final recordSnapshots = await _dispatchStore.find(
      await _db,
      finder: finder,
    );

    // Making a List<Dispatch> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final dispatch = Dispatch.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      dispatch.id = snapshot.key;
      return dispatch;
    }).toList();
  }

  Future<List<Dispatch>> getHistorySortedByTime() async {
    // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('dispatchTime'),
    ]);

    final recordSnapshots = await _historyStore.find(
      await _db,
      finder: finder,
    );

    // Making a List<Dispatch> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final dispatch = Dispatch.fromMap(snapshot.value);
      // An ID is a key of a record from the database.
      dispatch.id = snapshot.key;
      return dispatch;
    }).toList();
  }
}
