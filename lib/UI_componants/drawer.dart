import 'package:flutter/material.dart';
import 'package:halls_city/UI_componants/oval-right-clipper.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

class _LinkTextSpan extends TextSpan {
  _LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                urlLauncher.launch(url);
              });
}

///shows the about dialog.
showAbout(BuildContext context) {
  final TextStyle linkStyle =
      Theme.of(context).textTheme.body2.copyWith(color: Colors.blue);
  final TextStyle bodyStyle =
      new TextStyle(fontSize: 15.0, color: Colors.black);

  return showAboutDialog(
      context: context,
      applicationIcon: Center(
        child: Image(
          height: 100.0,
          fit: BoxFit.fitWidth,
          image: AssetImage("images/darkLogo.png"),
        ),
      ),
      children: <Widget>[
        new Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: new RichText(
                textAlign: TextAlign.start,
                text: new TextSpan(children: <TextSpan>[
                  new TextSpan(
                      style: bodyStyle,
                      text: 'Hello,  We are flutter developers, we have many amazing apps with flutter,' +
                          ' If you have any business/organisation/ideas and you want to build an app for it ,then  feel free to contact . we will build the app in the lowest price possible. '
                              "\n\n"),
                  new TextSpan(
                    style: bodyStyle,
                    text: 'for Business Queries:' + "\n\n",
                  ),
                  new _LinkTextSpan(
                      style: linkStyle,
                      text: 'Send an E-mail' + "\n\n",
                      url:
                          'mailto:sarahabdelhakim13@gmail.com?subject=Toughest&body=For business queries'),
                  new TextSpan(
                    style: bodyStyle,
                    text: 'for FeedBack:' + "\n\n",
                  ),
                  new _LinkTextSpan(
                    style: linkStyle,
                    text: 'Send a Whatsapp message' + "\n\n",
                    url: 'https://api.whatsapp.com/send?phone=+201017406795',
                  ),
                ]))),
      ]);
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  bool darkTheme = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("App"),
        ),
        body: Center(),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Dark Theme"),
                trailing: Switch(
                  value: darkTheme,
                  onChanged: (changed) {
                    setState(() {
                      darkTheme = changed;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
      theme: darkTheme ? ThemeData.dark() : ThemeData.light(),
    );
  }
}

class BuildDrawer extends StatelessWidget {
  static final String path = "lib/screens/Ui_components/drawer.dart";
  final Color primary = Colors.white;
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.blue;

  @override
  Widget build(BuildContext context) {
//    final String image = images[0];
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 100,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: active,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.blue, Colors.blueAccent])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__340.jpg'),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "sara",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "@sara",
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),

                  ///I have to make these drawer list widgets manually cause it is containing different methods.

                  _buildDivider(),
                  _buildRow(Icons.message, "Messages", showBadge: true),
                  _buildDivider(),
                  _buildRow(Icons.notifications, "Notifications",
                      showBadge: true),
                  _buildDivider(),
                  _buildRow(Icons.info_outline, "Help"),
                  _buildDivider(),
                  _buildRow(Icons.email, "Contact us"),
                  _buildDivider(),
                  InkWell(
                      child: _buildRow(Icons.person, "About Us"),
                      onTap: () => showAbout(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(IconData icon, String title, {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: active,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
        if (showBadge)
          Material(
            color: Colors.blue,
            elevation: 5.0,
            shadowColor: Colors.blueAccent,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                "10+",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
      ]),
    );
  }
}
