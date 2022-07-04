import 'dart:convert';
import 'function.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String url = '';
  var data;
  String Query = 'Query';
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Color(0xFC2156DC),
          title: Text('Sms Spam Detection')),
      body: Center(
        child: Container(
          width: 300.0,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image.asset(
              'assets/logo_spam.png',
              height: 200,
            ),
            TextField(
              onChanged: (value) {
                url = 'http://10.0.2.2:5000/predict?Query=' + value.toString();
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                hintText: 'Enter the Message.....',
                hintStyle: TextStyle(fontSize: 15.0, color: Colors.blue),
              ),
              minLines: 1,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              controller: myController,
            ),
            SizedBox(
              //Use of SizedBox
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  data = await fetchdata(url);
                  var decoded = jsonDecode(data);
                  setState(() {
                    Query = decoded['Query'];
                  });
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                    padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                    textStyle: MaterialStateProperty.all(
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
                child: Text(
                  'Check',
                  style: TextStyle(fontSize: 20),
                )),
            SizedBox(
              //Use of SizedBox
              height: 60,
            ),
            Text(
              Query,
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );
  }
}
