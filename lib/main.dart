import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FeedPage(),
    );
  }
}

class FeedPage extends StatefulWidget {

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  final nameCon = new TextEditingController();
  final idCon = new TextEditingController();
  final feeds = new TextEditingController();
  String feedtext = "",month,year;


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  List<String> _feedbackType = <String>["Positive","Negative"];

  //refer flutter drop down by whatsapp coder to show from firebase
  String selectedType = "";
  bool _isListening = false;
  String selected = "first";
  String resultText = "";
  stt.SpeechToText _speech;
  String _text = 'Press the button and start speaking';
  void _listen() async {

    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );   // set a timer of 40 seconds to listen
      if (available) {
        setState(() => _isListening = true);

        _speech.listen(
          onResult: (val) => setState(() {
            //fix the double mic things
            _text = val.recognizedWords;
            feeds.text = _text;

          
          }),
        );
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();


      });
      _listen();




    }
  }


  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.book,
              color: Colors.white,
            ),
            onPressed: () {}),

        title: Container(
          alignment: Alignment.center,

          child: Text("Feeds",
              style: TextStyle(fontFamily: "CrimsonText-Bold",fontSize: 20,
                color: Colors.white,
              )),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.book,
              size: 20.0,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ],
      ),


      body: Form(

        key: _formKeyValue,
        autovalidate: true,

        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          children: <Widget>[
            new Padding(padding: EdgeInsets.all(10.0)),
            SizedBox(
              height: 10.0,
            ),


            SizedBox(
              height: 30.0,
            ),





            SizedBox(
              height: 10.0,
            ),
            //random chart and employee feeds waits until change happens in dropdowns .




            Container(
              width: 150.0,
              height:100,


              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 12.0,
              ),
              child:TextFormField(

                controller:feeds,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                minLines: 3,
                decoration: new InputDecoration(
                  hintText: 'Edit Your Feeds ',
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                  //fillColor: Colors.green
                ),


                onSaved: (val) =>  feedtext= feeds.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),

              ),

            ),
            FloatingActionButton(
              onPressed: _listen,
              child: Icon(Icons.mic ),
            ),
            RaisedButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Submit", style: TextStyle(fontSize: 24.0,fontFamily: "CrimsonText-Bold")),
                      ],

                    )),

                onPressed: ()  async {

                  //print(feeds.text.compareTo(n));





                } ,
                //Using Transactions
                // Firestore.instance.runTransaction((Transaction crudTransaction) async {
                //   CollectionReference reference =
                //       await Firestore.instance.collection('testcrud');

                //   reference.add(carData);
                // });


                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))),


          ],
        ),
      ),
    );
  }
}

