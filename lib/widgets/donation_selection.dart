import 'package:flutter/material.dart';

/*
This widget appears on the Non-profit Screen to allow the user to select, confirm, and transfer their donation amount.
The user must tap the desired donation amount, they will then be prompted to confirm this amount by tapping that amount again (now highlighted).
After two taps, the donation is processed.
*/

// TODO figure out how we want to implement the "monthly" payment option
// TODO add an option to donate a custom amount??

/* these are the possible states for each donation amount option
    SELECTION STATES:
        0 => default -- no donation amount has been selected
        1 => donation amount has been selected but not confirmed
        2 => donation amount has been confirmed
  */

class DonationSelection extends StatefulWidget {
  @override
  _DonationSelectionState createState() =>
      _DonationSelectionState();
}

class _DonationSelectionState extends State<DonationSelection> {
  var _selectionState = [0, 0, 0, 0, 0]; //keeps track of the state of each option
  var _index = 0; //keeps track of which option has been tapped

  void _updateSelection(int i, int state) { //'state' will either be 0, 1, or 2 (see "selection states" key for details)
    setState(() {
      _index = i;
      _selectionState[i] = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Text("Show your support:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              )),
          _selectionState[_index] == 1
              ? Text(
                  "Tap amount again to confirm selection",
                  style: TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                )
              : Text(
                  "Tap to select donation amount",
                  style: TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
          Row(
            children: <Widget>[
              // $5 DONATION OPTION
              GestureDetector(
                onTap: () {
                  if (_selectionState[0] != 2) {
                    _updateSelection(0, _selectionState[0] + 1);
                  }
                },
                child: Container(
                  child: Text("\$5"),
                  color: _selectionState[0] != 0
                      ? Colors.amber[800]
                      : Colors.white,
                ),
              ),
              //$10 DONATION OPTION
              GestureDetector(
                onTap: () {
                  if (_selectionState[1] != 2) {
                    _updateSelection(1, _selectionState[1] + 1);
                  }
                },
                child: Container(
                  child: Text("\$10"),
                  color: _selectionState[1] != 0
                      ? Colors.amber[800]
                      : Colors.white,
                ),
              ),
              //$20 DONATION OPTION
              GestureDetector(
                onTap: () {
                  if (_selectionState[2] != 2) {
                    _updateSelection(2, _selectionState[2] + 1);
                  }
                },
                child: Container(
                  child: Text("\$20"),
                  color: _selectionState[2] != 0
                      ? Colors.amber[800]
                      : Colors.white,
                ),
              ),
              //$50 DONATION OPTION
              GestureDetector(
                onTap: () {
                  if (_selectionState[3] != 2) {
                    _updateSelection(3, _selectionState[3] + 1);
                  }
                },
                child: Container(
                  child: Text("\$50"),
                  color: _selectionState[3] != 0
                      ? Colors.amber[800]
                      : Colors.white,
                ),
              ),
              //MONTHLY DONATION OPTION
              GestureDetector(
                onTap: () {
                  if (_selectionState[4] != 2) {
                    _updateSelection(4, _selectionState[4] + 1);
                  }
                },
                child: Container(
                  child: Text("Monthly"),
                  color: _selectionState[4] != 0
                      ? Colors.amber[800]
                      : Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
