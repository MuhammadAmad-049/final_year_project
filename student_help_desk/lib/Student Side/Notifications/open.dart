import 'package:flutter/material.dart';
import 'notifications.dart';


class Open_Notificatons extends StatefulWidget {
  @override
  _Open_NotificatonsState createState() => _Open_NotificatonsState();
}

class _Open_NotificatonsState extends State<Open_Notificatons> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1967),
      appBar: AppBar(
        backgroundColor: Color(0xff1E1967),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Student_Notifications()),
            );
          },
        ),
        centerTitle: true,
        title: Text(
          'Details',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                children: <Widget>[
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                              backgroundColor: Colors.grey[50],
                              radius: 40,
                              backgroundImage:
                              AssetImage("images/Man-profile.jpeg")),
                        ),
                      ],
                    ),
                  ),
                    Center(
                      child: Text(
                        'DOO',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Card(
                        shadowColor: Colors.blueAccent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Image.asset(
                              "images/Cafe.png",
                              alignment: Alignment.center,
                              height: 60,
                              width: 60,
                            ),
                            const ListTile(
                              title: Text(
                                'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
                                    'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
                                    'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
                                    'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
                                    'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
                                    'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
                                    'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
                                    'aaaaaaaaaaaaaaaaaaaaa',
                                style: TextStyle(
                                   fontSize: 17,
                                ),
                              ),
                              // subtitle: Text(''),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.5),
                      child: Text(
                        'DOO has approved your Issue',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                    ],
              ),
              ]
            ),
          ),
          ),
        ],
      ),
    );
  }
}
