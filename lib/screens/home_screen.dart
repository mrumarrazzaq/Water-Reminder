import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:water_reminder/colors.dart';
import 'package:water_reminder/constants.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:water_reminder/sql_database/sql_helper.dart';
import 'package:water_reminder/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDateTime = DateTime.now();
  String _selectedDateTimeToString = '';
  bool _isTipVisible = false;
  bool _isLoading = true;
  List<Map<String, dynamic>> _dataCollection = [];

  // void _refreshData() async {
  //   final data = await SQLHelper.getRecords();
  //   setState(() {
  //     _dataCollection = data;
  //     _isLoading = false;
  //   });
  // }
  //
  // Future<void> _addWaterGlass({required String time}) async {
  //   await SQLHelper.createRecord(time: time);
  //   _refreshData();
  // }
  //
  // Future<void> _updateWaterGlass(
  //     {required int id, required String time}) async {
  //   await SQLHelper.updateRecord(id: id, time: time);
  //   _refreshData();
  // }
  //
  // Future<void> _deleteWaterGlass(int id) async {
  //   await SQLHelper.deleteRecord(id);
  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     content: Text('Record Deleted Successfully'),
  //   ));
  //   _refreshData();
  // }

  @override
  void initState() {
    // _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(color: blackColor),
        ),
        leading: const Text(''),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_isTipVisible == false) {
                        _isTipVisible = true;
                      } else if (_isTipVisible == true) {
                        _isTipVisible = false;
                      }
                    });
                  },
                  child: Image.asset(
                    'assets/water_drop.png',
                    width: 128 / 2.5,
                    height: 132 / 2.5,
                  ),
                ),
                Visibility(
                  visible: _isTipVisible,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ChatBubble(
                      clipper:
                          ChatBubbleClipper4(type: BubbleType.receiverBubble),
                      alignment: Alignment.topRight,
                      margin: const EdgeInsets.only(top: 5),
                      backGroundColor: lightWaterColor,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: const Text(
                          'Do not drink cold water immediately after hot water.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 2.0,
            margin: margin,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/drink.png',
                            width: 85.3 / 3,
                            height: 85.3 / 3,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text('Ideal Water Intake'),
                          ),
                          const Text('2810ml', style: boldBlackTextStyle),
                        ],
                      ),
                    ),
                    VerticalDivider(color: darkWaterColor, width: 5.0),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/trophy.png',
                            width: 85.3 / 3,
                            height: 85.3 / 3,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text('Ideal Water Intake'),
                          ),
                          const Text('2400ml', style: boldBlackTextStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 2.0,
            margin: margin,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: 100,
                        height: 200,
                        decoration: BoxDecoration(
                          color: lightWaterColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          // color: darkWaterColor,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                            colors: [
                              lightWaterColor,
                              darkWaterColor,
                            ],
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: '', // default text style
                          children: <TextSpan>[
                            TextSpan(
                              text: '800',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: darkWaterColor,
                                  fontSize: 35.0),
                            ),
                            TextSpan(
                              text: '/2600',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: blackColor,
                                  fontSize: 35.0),
                            ),
                            TextSpan(
                              text: 'ml',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: blackColor,
                                  textBaseline: TextBaseline.alphabetic),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.5,
                            ),
                            child: const Text(
                                'You have completed 30% of Daily Target.')),
                      ),
                      Material(
                        color: lightWaterColor,
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(10.0),
                        child: MaterialButton(
                          onPressed: () {
                            openDialog(null);
                          },
                          color: lightWaterColor,
                          minWidth: 150.0,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('assets/glass_of_water.png',
                                  height: 20.0, width: 20.0, color: whiteColor),
                              const SizedBox(width: 8.0),
                              Text(
                                'Add 250ml',
                                style: TextStyle(color: whiteColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Card(
              elevation: 2.0,
              margin: margin,
              child: Column(
                children: [
                  const Text(
                    'Today\'s Record',
                    style: boldBlackTextStyle,
                  ),
                  Expanded(
                    child: _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2.0, color: lightWaterColor),
                          )
                        : ListView.builder(
                            itemCount: _dataCollection.length,
                            itemBuilder: (context, index) {
                              print(
                                  '_dataCollection.length ${_dataCollection.length}');
                              return _dataCollection.isEmpty
                                  ? const Text('No record added')
                                  : SwipeActionCell(
                                      key: ObjectKey(
                                          _dataCollection[index]['createdAt']),
                                      leadingActions: [
                                        SwipeAction(
                                          title: "Edit",
                                          style: TextStyle(
                                              fontSize: 12, color: whiteColor),
                                          color: Colors.green,
                                          icon: Icon(Icons.edit,
                                              color: whiteColor),
                                          onTap: (CompletionHandler
                                              handler) async {
                                            openDialog(
                                                _dataCollection[index]['id']);
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                      trailingActions: [
                                        SwipeAction(
                                          title: "Delete",
                                          style: TextStyle(
                                              fontSize: 12, color: whiteColor),
                                          color: Colors.red,
                                          icon: Icon(Icons.delete,
                                              color: whiteColor),
                                          onTap: (CompletionHandler
                                              handler) async {
                                            openDeleteDialog(
                                                _dataCollection[index]['id']);
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                      child: ListTile(
                                        leading: Image.asset(
                                            'assets/glass_of_water.png',
                                            height: 20.0,
                                            width: 20.0),
                                        title: const Text(
                                          '250 ml',
                                          style: boldBlackTextStyle,
                                        ),
                                        trailing: Text(
                                            _dataCollection[index]['time']),
                                      ),
                                    );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  openDialog(int? id) => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            if (_selectedDateTime.hour > 12) {
              _selectedDateTimeToString =
                  '${_selectedDateTime.hour - 12} : ${_selectedDateTime.minute} PM';
            } else {
              _selectedDateTimeToString =
                  '${_selectedDateTime.hour} : ${_selectedDateTime.minute} AM';
            }
            var width = MediaQuery.of(context).size.width;
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              title: Center(
                  child: Image.asset(
                'assets/alarm.png',
                width: 50.0,
                height: 50.0,
              )),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: width,
                  height: 180.0,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 70,
                        child: CupertinoTheme(
                          data: const CupertinoThemeData(
                              brightness: Brightness.light),
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (time) {
                              setState(() {
                                _selectedDateTime = time;
                                if (_selectedDateTime.hour > 12) {
                                  _selectedDateTimeToString =
                                      '${_selectedDateTime.hour - 12} : ${_selectedDateTime.minute} PM';
                                } else {
                                  _selectedDateTimeToString =
                                      '${_selectedDateTime.hour} : ${_selectedDateTime.minute} AM';
                                }
                                log('Selected Time : $_selectedDateTimeToString');
                              });
                            },
                          ),
                        ),
                      ),
                      Material(
                        color: lightWaterColor,
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(15.0),
                        child: MaterialButton(
                          onPressed: () {
                            if (id == null) {
                              // _addWaterGlass(time: _selectedDateTimeToString);
                            } else {
                              // _updateWaterGlass(
                              //     id: id, time: _selectedDateTimeToString);
                            }
                            Navigator.pop(context);
                          },
                          color: lightWaterColor,
                          minWidth: 150.0,
                          height: 50.0,
                          child: Text(
                            id == null ? 'Save' : 'Update',
                            style: TextStyle(color: whiteColor),
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            );
          },
        ),
      );
  openDeleteDialog(int id) => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            var width = MediaQuery.of(context).size.width;
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              title: const Center(child: Text('Delete Record')),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: width,
                  height: 40.0,
                  child: Center(
                      child: Column(
                    children: const [
                      Text('Do you want to delete record'),
                      Text('Deleted record cannot be recovered',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 10,
                              color: Colors.red)),
                    ],
                  )),
                ),
              ),
              actions: [
                //CANCEL Button
                TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                //CREATE Button
                TextButton(
                  onPressed: () async {
                    // await _deleteWaterGlass(id);

                    Navigator.of(context, rootNavigator: true).pop('dialog');
                  },
                  child: const Text(
                    'DELETE',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        ),
      );
}
