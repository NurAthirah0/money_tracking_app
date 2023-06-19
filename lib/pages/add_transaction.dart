import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_tracking_app/controllers/db_helper.dart';
import 'package:money_tracking_app/static.dart' as Static;
import 'homepage.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {

  //

  int? amount;
  String note="Milk";
  String types="income";
  DateTime date = DateTime.now();
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }


  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        persistentFooterButtons: const [

          SizedBox(

            width: 900,
            child: Text(
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

        body: ListView(
          padding: const EdgeInsets.all(12.0),
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Text("Add Transaction",
              textAlign: TextAlign.center,

              style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w700,
                  color: Colors.green),
            ),
            //
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Static.primaryMaterialColor,
                      borderRadius: BorderRadius.circular(16.0)
                  ),

                  padding: const EdgeInsets.all(12.0),
                  child:
                  const Icon(Icons.attach_money,size: 24.0,color: Colors.white,),

                ),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(

                  child:
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "RM",
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 24.0,),
                    onChanged: (val) {
                      try{
                        amount = int.parse(val);

                      }
                      catch(e) {}

                    },

                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly

                    ],
                    keyboardType: TextInputType.number,

                  ),

                ),


              ],
            ),
            const SizedBox(
              height: 20.0,
            ),

////////------------------------2nd
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Static.primaryMaterialColor,
                      borderRadius: BorderRadius.circular(16.0)
                  ),

                  padding: const EdgeInsets.all(12.0),
                  child:
                  const Icon(Icons.description,size: 24.0,color: Colors.white,),

                ),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(

                  child:
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "Reference",
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 24.0,
                    ),
                    onChanged: (val){
                      note=val;
                    },


                  ),

                ),


              ],
            ),

            const SizedBox(
              height: 20.0,
            ),

            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Static.primaryMaterialColor,
                      borderRadius: BorderRadius.circular(16.0)
                  ),

                  padding: const EdgeInsets.all(12.0),
                  child:
                  const Icon(Icons.moving_sharp,size: 24.0,color: Colors.white,
                  ),

                ),

                const SizedBox(
                  width: 12.0,
                ),

                ChoiceChip(label: Text("Income",   style: TextStyle(
                  fontSize: 16.0, color:  types == "Income" ? Colors.white:Colors.black,
                ),),

                  selectedColor: Static.primaryMaterialColor,
                  selected: types == "Income" ? true:false ,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        types = "Income";
                        if (note.isEmpty || note == "Expense") {
                          note = 'Income';
                        }
                      });
                    }
                  },),


                const SizedBox(
                  width: 12.0,
                ),

                ChoiceChip(label: Text("Expense",   style: TextStyle(
                  fontSize: 16.0, color:  types == "Income" ? Colors.white:Colors.black,
                ),),

                  selectedColor: Static.primaryMaterialColor,
                  selected: types == "Expense" ? true:false ,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        types = "Expense";
                        if (note.isEmpty || note == "Expense") {
                          note = 'Expense';
                        }
                      });
                    }
                  },),




              ],
            ),

            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 50.0,
              child:
              TextButton(
                onPressed: () {
                  _selectDate(context);
                },
                style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Static.primaryMaterialColor,
                        borderRadius: BorderRadius.circular(
                          16.0,
                        ),
                      ),
                      padding: const EdgeInsets.all(
                        12.0,
                      ),
                      child: const Icon(
                        Icons.date_range,
                        size: 24.0,
                        // color: Colors.grey[700],
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),

                    Text(
                      "${date.day} ${months[date.month - 1]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],

                ),
              ),
            ),

            const SizedBox(
              height: 20.0,
            ),

            SizedBox(
              height:50.0,
              child:
              ElevatedButton(onPressed: () {
                if (amount != null) {
                  DbHelper dbHelper = DbHelper();
                  dbHelper.addData(amount!, date, types, note);

                  Navigator.of(context).pop();
                }
                else {
                  print("Not ");
                }
                // print(amount);
                // print(note);
                // print(types);
                // print(date);
              }, child: const Text("Add",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),

              ),
              ),
            ),

            const SizedBox(
              height: 10.0,
            ),

            SizedBox(
              height:50.0,
              child:
              ElevatedButton(onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Homepage(),
                  ),
                );

              },
                child: const Text("Cancel", style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),

                ),
              ),
            ),
          ],
        )
    );
  }
}