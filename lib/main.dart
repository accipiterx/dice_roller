import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(DiceRoller());
}

enum diceType { d4, d6, d8, d10, d20, d100 }

class DiceRoller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(32, 34, 40, 1),
        primarySwatch: Colors.deepPurple,
      ),
      title: 'D&D Dice Roller',
      home: RollScreen(),
    );
  }
} 
class RollScreen extends StatefulWidget {
  @override
  _RollScreenState createState() => _RollScreenState();
}

class _RollScreenState extends State<RollScreen> {
  //vars
  String rollOutput = '--';
  String modifValue = '';
  int modifSign = 1;
  bool signChange = false;
  String chooseText = 'd20';
  void rollFunc() {
    int modif = 0;
    print('newroll');
    String temp1 = chooseText.replaceAll('d', '');
    int die = int.parse(temp1);
    if (modifValue != '') {
      modif = int.parse(modifValue) * modifSign;
    }
    print(die);
    Random random = new Random();
    int temp2 = random.nextInt(die) + 1 + modif;
    rollOutput = temp2.toString();
    print(modifValue);
    print(rollOutput);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingAmmount = screenWidth / 20;
    double rowHieght = screenHeight / 8;
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            appBar: AppBar(
                title: Text(
                  'D&D Dice Roller',
                  style: TextStyle(color: Colors.black54),
                ),
                centerTitle: true),
            body: Padding(
              padding: EdgeInsets.all(paddingAmmount),
              child: Column(children: [
                Container(
                  height: rowHieght,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Modifier',
                          style: TextStyle(
                              fontSize: 20, color: Colors.deepPurpleAccent)),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth / 50),
                            child: Container(
                              width: screenWidth / 4.2,
                              child: TextField(
                                  style: TextStyle(
                                      color: Colors.deepPurpleAccent,
                                      fontSize: 18),
                                  showCursor: false,
                                  enableInteractiveSelection: false,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: screenHeight / 100),
                                    hintText: '0',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.deepPurpleAccent)),
                                    prefixIcon: IconButton(
                                      color: Colors.deepPurpleAccent,
                                      icon: signChange
                                          ? Icon(Icons.horizontal_rule)
                                          : Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          signChange = !signChange;
                                          modifSign *= -1;
                                          print(modifSign);
                                        });
                                      },
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(2),
                                  ],
                                  onChanged: (String value) {
                                    modifValue = value;
                                    print(value);
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 3,
                ),
                Container(
                  height: rowHieght,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Choose a die ',
                          style: TextStyle(
                              fontSize: 20, color: Colors.deepPurpleAccent)),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(chooseText,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.deepPurpleAccent)),
                        ),
                      ),
                      Container(
                        width: screenWidth / 10,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              cardColor: Color.fromRGBO(32, 34, 40, 1)),
                          child: PopupMenuButton<diceType>(
                              icon: Icon(Icons.list,
                                  color: Colors.deepPurpleAccent),
                              onSelected: (selected) {
                                setState(() {
                                  String temp = selected.toString();
                                  temp = temp.replaceAll('diceType.', '');
                                  chooseText = temp;
                                  print(chooseText);
                                });
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<diceType>>[
                                    const PopupMenuItem<diceType>(
                                        value: diceType.d4,
                                        child: Text('d4',
                                            style: TextStyle(
                                                color:
                                                    Colors.deepPurpleAccent))),
                                    const PopupMenuItem<diceType>(
                                        value: diceType.d6,
                                        child: Text('d6',
                                            style: TextStyle(
                                                color:
                                                    Colors.deepPurpleAccent))),
                                    const PopupMenuItem<diceType>(
                                        value: diceType.d8,
                                        child: Text('d8',
                                            style: TextStyle(
                                                color:
                                                    Colors.deepPurpleAccent))),
                                    const PopupMenuItem<diceType>(
                                        value: diceType.d10,
                                        child: Text('d10',
                                            style: TextStyle(
                                                color:
                                                    Colors.deepPurpleAccent))),
                                    const PopupMenuItem<diceType>(
                                        value: diceType.d20,
                                        child: Text('d20',
                                            style: TextStyle(
                                                color:
                                                    Colors.deepPurpleAccent))),
                                    const PopupMenuItem<diceType>(
                                        value: diceType.d100,
                                        child: Text('d100',
                                            style: TextStyle(
                                                color:
                                                    Colors.deepPurpleAccent))),
                                  ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: rowHieght / 1.2,
                      width: screenWidth * 0.9,
                      child: Padding(
                        padding: EdgeInsets.all(paddingAmmount),
                        child: ElevatedButton(
                            onPressed: () {
                              rollFunc();
                              setState(() {
                                rollOutput = rollOutput;
                              });
                            },
                            child: Text('Role Die',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 17))),
                      ),
                    ),
                  ],
                ),
                Text(''),
                Text('You rolled a:',
                    style: TextStyle(
                        fontSize: 18, color: Colors.deepPurpleAccent)),
                Text(rollOutput,
                    style: TextStyle(
                        fontSize: 40, color: Colors.deepPurpleAccent)),
              ]),
            )));
  }
}
