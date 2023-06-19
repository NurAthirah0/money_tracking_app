//  will ask use for their name here

import 'package:money_tracking_app/controllers/db_helper.dart';
import 'package:money_tracking_app/pages/homepage.dart';
import 'package:flutter/material.dart';

class AddName extends StatefulWidget {
  const AddName({Key? key}) : super(key: key);

  @override
  _AddNameState createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  //
  DbHelper dbHelper = DbHelper();

  String name = "";

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
      //
      // backgroundColor: Color(0xffe2e7ef),
      //
      body: Padding(
        padding: const EdgeInsets.all(
          12.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              padding: const EdgeInsets.all(
                16.0,
              ),
              child: Image.asset(
                "lib/assets/money_tracking_app_logo.png",
                width: 64.0,
                height: 64.0,
              ),
            ),*/
            //
            const SizedBox(
              height: 20.0,
            ),
            //
            const Text(
              "Let's track your money!",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            //
            const SizedBox(
              height: 20.0,
            ),
            //
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter Your Nick Name",
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                maxLength: 12,
                onChanged: (val) {
                  name = val;
                },
              ),
            ),
            //
            const SizedBox(
              height: 20.0,
            ),
            //
            SizedBox(
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                          label: "OK",
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                        backgroundColor: Colors.white,
                        content: const Text(
                          "Oops! We need your nick name",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    );
                  } else {
                    DbHelper dbHelper = DbHelper();
                    await dbHelper.addName(name);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Let's Track!",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(
                      Icons.arrow_right_alt,
                      size: 24.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}