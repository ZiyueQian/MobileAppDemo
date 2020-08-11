import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greenwaydispatch/data/api_response.dart';
import 'package:greenwaydispatch/data/dispatch_dao.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'bloc.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:greenwaydispatch/models/Dispatch_insert.dart';

class DispatchBloc extends Bloc<DispatchEvent, DispatchState> {
  DispatchBloc() : super(DispatchesLoading());
  var apiURL =
      "https://my-json-server.typicode.com/ZiyueQian/MobileAppDemo/dispatches";
  static const headers = {
    'apiKey': '08d771e2-7c49-1789-0eaa-32aff09f1471',
    'Content-Type': 'application/json'
  };

  DispatchDAO _dispatchDAO = DispatchDAO();

  // Display a loading indicator right from the start of the app
  @override
  DispatchState get initialState => DispatchesLoading();

  @override
  Stream<DispatchState> mapEventToState(
    DispatchEvent event,
  ) async* {
    if (event is LoadDispatches) {
      //home page
      // Indicating that dispatches are being loaded - display progress indicator.
      yield DispatchesLoading();
      yield* _reloadDispatches();
    } else if (event is AddDispatch) {
      await _dispatchDAO.insert(event.newDispatch);
      yield* _reloadDispatches();
    } else if (event is DeleteDispatch) {
      await _dispatchDAO.delete(event.dispatch);
      yield* _reloadDispatches();
    }
  }

  Stream<DispatchState> _reloadDispatches() async* {
    final dispatches = await _dispatchDAO.getDispatchesSortedByTime();
    // Yielding a state bundled with the Dispatches from the database.
    yield DispatchesLoaded(dispatches);
  }

  Future<void> fetchDispatches() async {
    var response = await http.get(apiURL);
    var jsonResponse = convert.jsonDecode(response.body);
    var dispatchesJson = jsonResponse as List;
    List<Dispatch> dispatches = List<Dispatch>();

    dispatchesJson.forEach((dispatch) {
      _dispatchDAO.insert(Dispatch.fromJson(dispatch));
    });

    return dispatches;
  }

  Future<APIResponse<bool>> createDispatch(DispatchInsert item) {
    var dispatch = {
      "dispatchRecord": "testing",
      "dispatchAmount": 5,
      "dispatchType": "truck",
      "dispatchTime": "2020-02-02 21:40",
      "dispatchConfirmation": "confirm",
      "truckNumber": "A11",
      "contactPerson": "Ankit",
      "contactNumber": 123456,
      "alternativeContactNumber": 1234567,
      "docketNumber": "ABC123",
      "recipientPerson": "Mohit",
      "recipientContactNumber": 12345678,
      "containerNumber": "ABCDEF",
      "customsClearingPoint": "Delhi",
      "description": "describing dispatch"
    };

    return http
        .post(apiURL, headers: headers, body: convert.jsonEncode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

//  Future<APIResponse<bool>> postDispatches() async {
////    Future<List<Dispatch>> dispatches =
////        _dispatchDAO.getDispatchesSortedByTime();
////
////    dispatches.forEach((dispatch) {
////      convert.jsonEncode(dispatch);
////    });
//    print("post dispatches");
//    var dispatch = {
//      "dispatchRecord": "testing",
//      "dispatchAmount": 5,
//      "dispatchType": "truck",
//      "dispatchTime": "2020-02-02 21:40",
//      "dispatchConfirmation": "confirm",
//      "truckNumber": "A11",
//      "contactPerson": "Ankit",
//      "contactNumber": 123456,
//      "alternativeContactNumber": 1234567,
//      "docketNumber": "ABC123",
//      "recipientPerson": "Mohit",
//      "recipientContactNumber": 12345678,
//      "containerNumber": "ABCDEF",
//      "customsClearingPoint": "Delhi",
//      "description": "describing dispatch"
//    };
//    //final http.Response response = await
//    return http.post(
//      apiURL,
//      headers: {"Content-Type": "application/json"},
//      body: convert.jsonEncode(),
//    ) {
//    };
//  }
}
