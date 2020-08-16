import 'package:flutter/material.dart';
import 'mqtt_stream.dart';
import 'Adafruit_feed.dart';

class MqttPage extends StatefulWidget {
  MqttPage({this.title});
  final String title;

  @override
  MqttPageState createState() => MqttPageState();
}

class MqttPageState extends State<MqttPage> {
  // Instantiate an instance of the class that handles
  // connecting, subscribing, publishing to Adafruit.io
  AppMqttTransactions myMqtt = AppMqttTransactions();
  final myTopicController = TextEditingController();
  final myTopicController2 = TextEditingController();
  final myValueController = TextEditingController();
  final myValueController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _body(),
    );
  }

  //
  // The body of the page.  The children contain the main components of
  // the UI.
  Widget _body() {
    return Column(
      children: <Widget>[
        _subscriptionInfo(),
        _subscriptionData(),
        _publishInfo(),
      ],
    );
  }

//
// The UI to get and subscribe to the mqtt topic.
//
  Widget _subscriptionInfo() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Topico:',
                style: TextStyle(fontSize: 24),
              ),
              // To use TextField within a row, it needs to be wrapped in a Flexible
              // widget.  See Stackoverflow: https://bit.ly/2IkzqBk
              Flexible(
                child: TextField(
                  controller: myTopicController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Topico',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 10.0)),
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Subscribirse'),
                onPressed: () {
                  subscribe(myTopicController.text);
                },
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              Text(
                'Topico2:',
                style: TextStyle(fontSize: 24),
              ),
              // To use TextField within a row, it needs to be wrapped in a Flexible
              // widget.  See Stackoverflow: https://bit.ly/2IkzqBk
              Flexible(
                child: TextField(
                  controller: myTopicController2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Topico2',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 10.0)),
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Subscribirse2'),
                onPressed: () {
                  subscribe(myTopicController2.text);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _subscriptionData() {
    return StreamBuilder(
        stream: AdafruitFeed.sensorStream,
        builder: (context, snapshot) {
         
          // if (!snapshot.hasData) {
          //   return CircularProgressIndicator();
          // }
          //String reading = "hAS DATA";
          String reading = snapshot.data;
          if (reading == null) {
            reading = 'No hay datos';
          }
          
          return Text(reading);
          
        });
  }

  
  Widget _publishInfo() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Valor:',
                style: TextStyle(fontSize: 24),
              ),
              // To use TextField within a row, it needs to be wrapped in a Flexible
              // widget.  See Stackoverflow: https://bit.ly/2IkzqBk
              Flexible(
                child: TextField(
                  controller: myValueController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Valor a publicar',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 10.0)),
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Publicar'),
                onPressed: () {
                  publish(myTopicController.text, myValueController.text);
                },
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              Text(
                'Valor2:',
                style: TextStyle(fontSize: 24),
              ),
              // To use TextField within a row, it needs to be wrapped in a Flexible
              // widget.  See Stackoverflow: https://bit.ly/2IkzqBk
              Flexible(
                child: TextField(
                  controller: myValueController2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Valor2 a publicar',
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 10.0)),
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Publicar2'),
                onPressed: () {
                  publish(myTopicController2.text, myValueController2.text);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void subscribe(String topic) {
    myMqtt.subscribe(topic);
  }

  void publish(String topic, String value) {
    myMqtt.publish(topic, value);
  }
}

// void publish(String topic) {
// AppMqttTransactions mySubscribe = AppMqttTransactions();
// myPublish.publish(topic,3);
// }
