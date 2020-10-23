import 'package:addie_soft_lab_test/utility/Toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _roll = new TextEditingController();
  TextEditingController _mobileNo = new TextEditingController();
  int selectedRadioCustodian;
  bool isFieldValueOkay = false;
  bool formPage = true;
  String headline = "Submit to";
  bool validationCondition = true;
  String validationStatus = "Problematic fields: ";
  Widget dataTableView;

  @override
  void initState() {
    super.initState();
    selectedRadioCustodian = 1;
  }

  // Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadioCustodian = val;
      isFieldValueOkay = false;
    });
  }

  /*---------------------------------all Functional method start----------------------------------------*/

  // save data to firebase
  addData() async {
    Map<String, dynamic> demoData = {
      "name": _name.text,
      "roll": int.parse(_roll.text),
      "mobileNo": _mobileNo.text,
      "gender": selectedRadioCustodian == 1 ? "Male" : "Female"
    };
    await FirebaseFirestore.instance.collection('student').add(demoData).then((value) {
      Toast.show("Student saved successfully", context,
          duration: Toast.LENGTH_LONG, backgroundColor: Colors.black, gravity: Toast.CENTER);
    }).catchError((error) {
      Toast.show("Failed to add student: $error", context,
          duration: Toast.LENGTH_LONG, backgroundColor: Colors.black, gravity: Toast.CENTER);
    });
  }

  // Retrieve data from firebase
  Future<void> retrieveData() async {
    List firebaseDataList = [];
    /* Map<String, dynamic>firebaseData=*/
    await FirebaseFirestore.instance.collection("student").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if (result.data() != null) {
          firebaseDataList.add((result.data()));
        }
        print("type of ${result.data().runtimeType}");
        print(result.data());
      });
      print("firebaseDataList ${firebaseDataList}");
      setState(() {
        dataTableView = dataTable(firebaseDataList);
      });
    });
  }
/*---------------------------------all Functional method end----------------------------------------*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {
                      formPage = true;
                      headline = "Submit to";
                    });
                  },
                ),
                Container(
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.filter_list),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                          onPressed: () {
                            // addData();
                          },
                        )
                      ],
                    ))
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('$headline',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                SizedBox(width: 10.0),
                Text('firebase',
                    style: TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 25.0))
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: formPage
                ? ListView(
                    primary: false,
                    padding: EdgeInsets.only(left: 25.0, right: 20.0),
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 45.0),
                          child: Container(
                              /*height: MediaQuery.of(context).size.height - 400.0,*/
                              child: Column(children: [
                            textFieldGen(controller: _name, labelText: "Name", keyBoardTypeNumber: false),
                            textFieldGen(controller: _roll, labelText: "Roll", keyBoardTypeNumber: true),
                            textFieldGen(
                                controller: _mobileNo, labelText: "Mobile number", keyBoardTypeNumber: true),
                            Row(
                              children: <Widget>[
                                Text("Gender ",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.grey[600],
                                    )),
                                SizedBox(
                                  width: 6,
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Radio(
                                    value: 1,
                                    groupValue: selectedRadioCustodian,
                                    activeColor: Colors.cyan[400],
                                    onChanged: (val) {
                                      print("Radio $val");
                                      setSelectedRadio(val);
                                    },
                                  ),
                                ),
                                InkWell(
                                  child: Text(
                                    'Male',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedRadioCustodian = 1;
                                      isFieldValueOkay = false;
                                    });
                                  },
                                ),
                                Radio(
                                  value: 2,
                                  groupValue: selectedRadioCustodian,
                                  activeColor: Colors.cyan[400],
                                  onChanged: (val) {
                                    print("Radio $val");
                                    setSelectedRadio(val);
                                  },
                                ),
                                InkWell(
                                  child: Text(
                                    'Female',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedRadioCustodian = 2;
                                      isFieldValueOkay = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ]))),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              height: 65.0,
                              width: 140.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [Text(" Save ")],
                                ),
                              ),
                            ),
                            onTap: () {
                              addData();
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              height: 65.0,
                              width: 140.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [Text(" Load")],
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                formPage = false;
                                headline = 'Retrieve from';
                                retrieveData();
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  )
                : ListView(
                    primary: false,
                    padding: EdgeInsets.only(left: 25.0, right: 20.0),
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  dataTableView != null ? dataTableView : Text('Loading'),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              height: 65.0,
                              width: 140.0,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [Icon(Icons.arrow_back, color: Colors.grey), Text(" Back ")],
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                formPage = true;
                                headline = "Submit to";
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }

//---------------------------------all widget method start----------------------------------------//
  //text field genarator
  Widget textFieldGen({
    TextEditingController controller,
    labelText,
    bool keyBoardTypeNumber,
  }) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: controller,
          validator: (value) {},
          decoration: InputDecoration(labelText: labelText),
          keyboardType: keyBoardTypeNumber ? TextInputType.number : TextInputType.text,
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  // table view
  Widget dataTable(firebaseDataList) {
    if (firebaseDataList != null && firebaseDataList.length > 0) {
      return Container(
        height: MediaQuery.of(context).size.height - 500.0,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FittedBox(
            child: DataTable(
              // columnSpacing: 10,

              columns: [
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Roll',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Mobile No',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Gender',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                )
              ],
              rows: firebaseDataList
                  .map<DataRow>(
                    (data) => DataRow(cells: [
                      DataCell(
                        Text(data['name'] != null ? data['name'] : ''),
                      ),
                      DataCell(
                        Text(data['roll'] != null ? data['roll'].toString() : ''),
                      ),
                      DataCell(
                        Text(data['mobileNo'] != null ? data['mobileNo'] : ''),
                      ),
                      DataCell(
                        Text(data['gender'] != null ? data['gender'] : ''),
                      ),
                    ]),
                  )
                  .toList(),
            ),
          ),
        ),
      );
    } else {
      return Text("No data Found");
    }
  }

//---------------------------------all widget method end----------------------------------------//
}
