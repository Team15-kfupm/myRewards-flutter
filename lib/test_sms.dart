import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

class TestSMS extends StatefulWidget {
  const TestSMS({Key? key}) : super(key: key);

  @override
  State<TestSMS> createState() => _TestSMSState();
}

class _TestSMSState extends State<TestSMS> {
  List<SmsMessage> messages = [];
  String sms = "";
  Telephony telephony = Telephony.instance;

  @override
  void initState() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print(message.address); //+977981******67, sender nubmer
        print(message.body); //sms text
        print(message.date); //1659690242000, timestamp
        setState(() {
          sms = message.body.toString();
        });
      },
      listenInBackground: false,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Listen Incoming SMS in Flutter"),
          backgroundColor: Colors.redAccent),
      body: Container(
          padding: EdgeInsets.only(top: 50, left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recieved SMS Text:",
                style: TextStyle(fontSize: 30),
              ),
              Divider(),
              Text(
                "SMS Text:" + sms,
                style: TextStyle(fontSize: 20),
              ),
              Container(
                color: Colors.blue,
                child: Text(messages.length == 0
                    ? "No SMS"
                    : messages[7].body.toString()),
              )
            ],
          )),
      floatingActionButton: IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () async {
          messages = await telephony.getInboxSms(
            columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.DATE],
          );
          setState(() {});
        },
      ),
    );
  }
}
