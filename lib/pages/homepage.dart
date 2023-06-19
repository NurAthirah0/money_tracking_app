import 'package:money_tracking_app/controllers/db_helper.dart';
import 'package:money_tracking_app/models/Transaction_model.dart';
import 'package:money_tracking_app/pages/Add_rename.dart';
import 'package:money_tracking_app/pages/add_transaction.dart';
import 'package:money_tracking_app/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:money_tracking_app/static.dart' as Static;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  late Box box;
  late SharedPreferences preferences;
  DbHelper dbHelper = DbHelper();
  Map? data;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;

  DateTime today = DateTime.now();
  DateTime now = DateTime.now();
  int index = 1;
  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  void initState() {
    super.initState();
    getPreference();
    box = Hive.box('money');
    fetch();
  }

  getPreference() async {
    preferences = await SharedPreferences.getInstance();
  }


  Future<List<TransactionModel>> fetch() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      // return Future.value(box.toMap());
      List<TransactionModel> items = [];
      box
          .toMap()
          .values
          .forEach((element) {
        // print(element);
        items.add(
          TransactionModel(
            element['amount'] as int,
            element['note'],
            element['date'] as DateTime,
            element['type'],
          ),
        );
      });
      return items;
    }
  }

  getTotalBalance(List<TransactionModel> entireData) {
    totalExpense = 0;
    totalIncome = 0;
    totalBalance = 0;

    for (TransactionModel data in entireData) {
      if (data.date.month == today.month) {
        if (data.type == "Income") {
          totalBalance += data.amount;
          totalIncome += data.amount;
        }
        else {
          totalBalance -= data.amount;
          totalExpense += data.amount;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        toolbarHeight: 0.0,
      ),

      persistentFooterButtons: [

        Container(

          width: 900,
          child: const Text(
            'CryptoTech©',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontWeight: FontWeight.bold
            ),
          ),
        )
      ],

      //backgroundColor: Color(0xffe2e7ef),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddTransaction()
            ,),
        ).whenComplete(() {
          setState(() {});
        });
      },
        backgroundColor: Static.primaryMaterialColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)),
        child: const Icon(Icons.add, size: 32.0,),


      ),
      body: FutureBuilder<List<TransactionModel>>(
          future: fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Error!"),);
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("Please add your transactions!"),);
              }
              getTotalBalance(snapshot.data!);
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            children: [
                              /*Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32.0),
                                    color: Colors.white70,
                                  ),


                                  /*child: CircleAvatar(
                                    maxRadius: 32.0,
                                    child: Image.asset("assets/face.png",
                                      width: 64.0,),
                                  ),*/
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),*/

                              Text(
                                "Welcome, ${preferences.getString('name')}",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                  color: Static.primaryMaterialColor[800],
                                ),

                              ),
                            ]
                        ),
                        Container(

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white70,
                          ),

                          padding: const EdgeInsets.all(17.0),
                          child: IconButton(
                            icon: const Icon(
                                Icons.settings,
                                size: 45.0,
                                color: Color(0xff3E454C)
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const AddReName(),
                                ),
                              );
                            },
                          ),
                        ),


                        // child: Icon(Icons.settings,
                        // size: 32.0,
                        //   color: Color(0xff3E454C),
                        // ),


                      ],
                    ),
                  ),

                  Container(

                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9,
                    margin: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Static.primaryMaterialColor,
                            Colors.green,
                          ],),
                          borderRadius: const BorderRadius.all(Radius
                              .circular(24.0))
                      ),


                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 8.0),
                      child: Column(children: [
                        const Text("Total Balance",
                          textAlign: TextAlign.center, style: TextStyle
                            (fontSize: 22.0, color: Colors.white)
                          ,),

                        const SizedBox(
                          height: 12.0,
                        ),

                        Text("RM$totalBalance ", textAlign: TextAlign.center,
                          style: const TextStyle
                            (fontSize: 26.0, color: Colors.white)
                          ,),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Padding(padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              cardIncome(totalIncome.toString()
                              ),
                              cardExpense(totalExpense.toString())
                            ],
                          ),

                        )

                      ],),
                    ),
                  ),


                  /////
                  ////
                  ////

                  const Padding(
                    padding: EdgeInsets.all(
                      12.0,
                    ),
                    child: Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 26.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length + 1,
                      itemBuilder: (context, index) {
                        TransactionModel dataAtIndex;
                        try {
                          // dataAtIndex = snapshot.data![index];
                          dataAtIndex = snapshot.data![index];
                        } catch (e) {
                          // deleteAt deletes that key and value,
                          // hence making it null here., as we still build on the length.
                          return Container();
                        }


                        if (dataAtIndex.type == "Income") {
                          return incomeTile(
                              dataAtIndex.amount, dataAtIndex.note,
                              dataAtIndex.date, index);
                        }
                        else {
                          return expenseTile(
                              dataAtIndex.amount, dataAtIndex.note
                              , dataAtIndex.date, index);
                        }
                      }
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),

                ],
              );
            }
            else {
              return const Center(child: Text("Error!"),);
            }
          }
      ),
    );
  }


  Widget cardIncome(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: const EdgeInsets.all(6.0
          ),
          margin: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.arrow_upward,
            size: 28.0, color: Colors.green[700],

          ),

        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Income",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,

              ),
            ),
            Text(
              "RM$value",
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }


  ///////////////


  Widget cardExpense(String value) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              20.0,
            ),
          ),
          padding: const EdgeInsets.all(6.0
          ),
          margin: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.arrow_downward,
            size: 28.0, color: Colors.red[700],

          ),

        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Expense",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white70,

              ),
            ),
            Text(
              "RM$value",
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }


/////////////

  Widget expenseTile(int value, String note, DateTime date, int index) {
    return InkWell(
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
          context,
          "WARNING",
          "This will delete the expense record! This action is irreversible! Do you want to continue ?",
        );
        if (answer != null && answer) {
          await dbHelper.deleteData(index);
          setState(() {});
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(color: const Color(0xfffac5c5),
            borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_circle_down_outlined,
                      size: 28.0,
                      color: Colors.red[700],
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    const Text("Expense",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    )

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "${date.day} ${months[date.month - 1]} ${date.year}",
                    style: TextStyle(
                      color: Colors.grey[800],
                      // fontSize: 24.0,
                      // fontWeight: FontWeight.w700

                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(" - RM$value", style: const TextStyle(
                  fontSize: 24.0, fontWeight: FontWeight.w700,
                ),
                ),
                Text(note, style: TextStyle(
                    color: Colors.grey[800]
                  // fontSize: 24.0,
                  // fontWeight: FontWeight.w700,
                ),
                ),
              ],
            )
          ],
        ),


      ),
    );
  }

////////////////


  Widget incomeTile(int value, String note, DateTime date, int index) {
    return InkWell(
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
          context,
          "WARNING",
          "This will delete the expense record! This action is irreversible! Do you want to continue?",
        );
        if (answer != null && answer) {
          await dbHelper.deleteData(index);
          setState(() {});
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(color: const Color(0xffd8fac5),
            // Color(0xffced4eb),
            borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_circle_up_outlined,
                      size: 28.0,
                      color: Colors.green[700],
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    const Text("Income",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    )

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "${date.day} ${months[date.month - 1]} ${date.year}",
                    style: TextStyle(
                      color: Colors.grey[800],
                      // fontSize: 24.0,
                      // fontWeight: FontWeight.w700

                    ),
                  ),
                ),

              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(" + RM$value",
                  style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700),
                ),
                Text(note,
                  style: TextStyle(
                    color: Colors.grey[800],
                    // fontSize: 24.0,
                    // fontWeight: FontWeight.w700

                  ),
                ),
              ],
            )
          ],
        ),


      ),

    );
  }
}