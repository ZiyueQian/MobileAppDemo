import 'package:flutter/material.dart';
import 'infoView.dart';
import 'package:greenwaydispatch/models/Dispatch.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InOrOutBoundView extends StatefulWidget {
  final Dispatch dispatch;
  InOrOutBoundView({Key key, @required this.dispatch}) : super(key: key);
  @override
  _InOrOutBoundViewState createState() => _InOrOutBoundViewState();
}

class _InOrOutBoundViewState extends State<InOrOutBoundView> {
  var selectedCard = 'PLACEHOLDER';
  List<bool> isSelected = [false, false];

  List<bool> isSelectedArea = [false, false];
  List<String> areaList = ["domestic", "international"];
  String selectedArea = '';

  List choices = ["inbound", "outbound"];
  List choicesIcons = [Icon(MdiIcons.import), Icon(MdiIcons.export)];
  double screenPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New dispatch'),
        ),
        body: Padding(
            padding: EdgeInsets.all(screenPadding),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                  Text(
//                    "Select:",
//                    style: TextStyle(color: Colors.black, fontSize: 16.0),
//                  ),
//                  SizedBox(
//                    height: 20,
//                  ),
                  Container(
                      width:
                          MediaQuery.of(context).size.width - screenPadding * 2,
                      child: LayoutBuilder(builder: (context, constraints) {
                        return ToggleButtons(
                          constraints: BoxConstraints.expand(
                              height: 100.0,
                              width: constraints.maxWidth / 2 -
                                  2), //3 is the number of buttons, 2 is for the borders
                          borderColor: Colors.grey[500],
                          fillColor: Colors.green[200],
                          borderWidth: 1.0,
                          color: Colors.grey[600],
                          selectedBorderColor: Colors.black,
                          selectedColor: Colors.black,
                          borderRadius: BorderRadius.circular(4.0),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Inbound',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Outbound',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                          onPressed: (int index) {
                            setState(() {
                              for (int i = 0; i < isSelected.length; i++) {
                                if (i == index) {
                                  isSelected[i] = true;
                                } else {
                                  isSelected[i] = false;
                                }
                              }
                            });
                          },
                          isSelected: isSelected,
                        );
                      })),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      width:
                          MediaQuery.of(context).size.width - screenPadding * 2,
                      child: LayoutBuilder(builder: (context, constraints) {
                        return ToggleButtons(
                          constraints: BoxConstraints.expand(
                              height: 100.0,
                              width: constraints.maxWidth / 2 -
                                  2), //3 is the number of buttons, 2 is for the borders
                          borderColor: Colors.grey[500],
                          fillColor: Colors.green[200],
                          borderWidth: 1.0,
                          color: Colors.grey[600],
                          selectedBorderColor: Colors.black,
                          selectedColor: Colors.black,
                          borderRadius: BorderRadius.circular(4.0),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Domestic',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'International',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                          onPressed: (int index) {
                            setState(() {
                              for (int i = 0; i < isSelectedArea.length; i++) {
                                if (i == index) {
                                  isSelectedArea[i] = true;
                                  selectedArea = areaList[i];
                                  print(selectedArea);
                                } else {
                                  isSelectedArea[i] = false;
                                }
                              }
                            });
                          },
                          isSelected: isSelectedArea,
                        );
                      })),
                  Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FlatButton(
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DispatchInfoView(
                                          dispatch: widget.dispatch,
                                          area: selectedArea)));
                            })),
                  )
                ])));
  }

  Widget _buildInfoCard(Icon iconName, String text) {
    return InkWell(
        onTap: () {
          selectCard(text);
        },
        child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: text == selectedCard ? Colors.green[200] : Colors.white,
              border: Border.all(
                  color: text == selectedCard
                      ? Colors.transparent
                      : Colors.grey.withOpacity(0.3),
                  style: BorderStyle.solid,
                  width: 0.75),
            ),
            height: 20.0,
            width: 20.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
//              Padding(
//                padding: const EdgeInsets.only(top: 8.0),
//                child: iconName,
//              ),
                  Text(text,
                      style: TextStyle(fontSize: 14.0
                          //color: text == selectedCard ? Colors.white : Colors.black,
                          )),
                ])));
  }

  selectCard(text) {
    setState(() {
      selectedCard = text;
    });
  }
}
