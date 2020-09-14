import 'models/Dispatch.dart';

class DispatchesService {
  List<Dispatch> getDispatchesList() {
    return [
      new Dispatch(
          "TESTING",
          5,
          "truck",
          "2020-02-02 21:40",
          "confirm",
          "A11",
          "Ankit",
          123456,
          1234567,
          "ABC123",
          "Mohit",
          12345678,
          "ABCDEF",
          "Delhi",
          "describing dispatch"),
    ];
  }
}
