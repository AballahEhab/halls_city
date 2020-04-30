import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halls_city/services/firebase_auth.dart';
import 'package:halls_city/services/halls_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'dart:convert' show json;

import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Constants.dart';
import 'home_screen.dart';

//GoogleSignIn _googleSignIn = GoogleSignIn(
//  scopes: <String>[
//    'email',
//    'https://www.googleapis.com/auth/contacts.readonly',
//  ],
//);

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  String backImg = 'images/login.jpg';
  bool formVisible, showSpinner = false;
  int _formsIndex;
  HallsData _hallsData = HallsData();

//  GoogleSignIn _googleSignIn = GoogleSignIn();
//  final _auth = FirebaseAuth.instance;
//
//  Future<void> _handelsignIn() async {
//    Toast.show(1.toString(), context,
//        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//
//    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//
//    Toast.show(2.toString(), context,
//        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//
//    GoogleSignInAuthentication googleSignInAuthentication =
//        await googleSignInAccount.authentication;
//
//    Toast.show(3.toString(), context,
//        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//
//    AuthCredential authCredential = GoogleAuthProvider.getCredential(
//        idToken: googleSignInAuthentication.idToken,
//        accessToken: googleSignInAuthentication.accessToken);
//
//    Toast.show(4.toString(), context,
//        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//    AuthResult _result = (await _auth.signInWithCredential(authCredential));
//
//    Toast.show(_result.user.toString(), context,
//        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//  }

//  GoogleSignInAccount _currentUser;
//  String _contactText;

  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;
//    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//      setState(() {
//        _currentUser = account;
//      });
//      if (_currentUser != null) {
//        _handleGetContact();
//      }
//    });
//    _googleSignIn.signInSilently();
  }

//  Future<void> _handleGetContact() async {
//    setState(() {
//      _contactText = "Loading contact info...";
//    });
//    final http.Response response = await http.get(
//      'https://people.googleapis.com/v1/people/me/connections'
//      '?requestMask.includeField=person.names',
//      headers: await _currentUser.authHeaders,
//    );
//    if (response.statusCode != 200) {
//      setState(() {
//        _contactText = "People API gave a ${response.statusCode} "
//            "response. Check logs for details.";
//      });
//      print('People API ${response.statusCode} response: ${response.body}');
//      return;
//    }
//    final Map<String, dynamic> data = json.decode(response.body);
//    final String namedContact = _pickFirstNamedContact(data);
//    setState(() {
//      if (namedContact != null) {
//        _contactText = "I see you know $namedContact!";
//      } else {
//        _contactText = "No contacts to display.";
//      }
//    });
//  }
//
//  String _pickFirstNamedContact(Map<String, dynamic> data) {
//    final List<dynamic> connections = data['connections'];
//    final Map<String, dynamic> contact = connections?.firstWhere(
//      (dynamic contact) => contact['names'] != null,
//      orElse: () => null,
//    );
//    if (contact != null) {
//      final Map<String, dynamic> name = contact['names'].firstWhere(
//        (dynamic name) => name['displayName'] != null,
//        orElse: () => null,
//      );
//      if (name != null) {
//        return name['displayName'];
//      }
//    }
//    return null;
//  }
//
//  Future<void> _handleSignIn() async {
//    try {
//      await _googleSignIn.signIn();
//    } catch (error) {
//      print(error);
//    }
//  }
//
//  Future<void> _handleSignOut() => _googleSignIn.disconnect();
//
//  Widget _buildBody() {
//    if (_currentUser != null) {
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          ListTile(
//            leading: GoogleUserCircleAvatar(
//              identity: _currentUser,
//            ),
//            title: Text(_currentUser.displayName ?? ''),
//            subtitle: Text(_currentUser.email ?? ''),
//          ),
//          const Text("Signed in successfully."),
//          Text(_contactText ?? ''),
//          RaisedButton(
//            child: const Text('SIGN OUT'),
//            onPressed: _handleSignOut,
//          ),
//          RaisedButton(
//            child: const Text('REFRESH'),
//            onPressed: _handleGetContact,
//          ),
//        ],
//      );
//    } else {
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          const Text("You are not currently signed in."),
//          RaisedButton(
//            child: const Text('SIGN IN'),
//            onPressed: _handleSignIn,
//          ),
//        ],
//      );
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/loginBackground.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.black45,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: kToolbarHeight + 40),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Halls City",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 33.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "Halls & workSpaces Booking App",
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: RaisedButton(
                          color: main_light_color,
                          textColor: Colors.white,
                          elevation: 0.2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text("Login"),
                          onPressed: () {
                            setState(() {
                              formVisible = true;
                              _formsIndex = 1;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: RaisedButton(
                          color: main_dark_color,
                          textColor: Colors.white,
                          elevation: 0.2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text("Signup"),
                          onPressed: () {
                            setState(() {
                              formVisible = true;
                              _formsIndex = 2;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10.0),
                    ],
                  ),
                  const SizedBox(height: 40.0),
//                  OutlineButton.icon(
//                    borderSide: BorderSide(color: main_light_color),
//                    textColor: Colors.white,
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(12.0),
//                    ),
//                    icon: Icon(const IconData(0xe900, fontFamily: 'icons')),
//                    label: Text("Continue with Google"),
//                    onPressed: () async {
//                      setState(() {
//                        showSpinner = true;
//                      });
//                      await _handelsignIn();
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => HomeScreen()));
//                      setState(() {
//                        showSpinner = true;
//                      });
//                    },
//                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: (!formVisible)
                  ? null
                  : Container(
                      color: Colors.black54,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                textColor: _formsIndex == 1
                                    ? Colors.white
                                    : Colors.black,
                                color: _formsIndex == 1
                                    ? main_light_color
                                    : Colors.white,
                                child: Text("Login"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: circularBorder),
                                onPressed: () {
                                  setState(() {
                                    _formsIndex = 1;
                                  });
                                },
                              ),
                              const SizedBox(width: 10.0),
                              RaisedButton(
                                textColor: _formsIndex == 2
                                    ? Colors.white
                                    : Colors.black,
                                color: _formsIndex == 2
                                    ? main_light_color
                                    : Colors.white,
                                child: Text("Signup"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: circularBorder),
                                onPressed: () {
                                  setState(() {
                                    _formsIndex = 2;
                                  });
                                },
                              ),
                              const SizedBox(width: 10.0),
                              IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.clear), //دي بتقفل الفورم
                                onPressed: () {
                                  setState(() {
                                    formVisible = false;
                                  });
                                },
                              )
                            ],
                          ),
                          Container(
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 200),
                              child: _formsIndex == 1
                                  ? LoginForm(
                                      onLogin: (newvalue) {
                                        setState(() {
                                          showSpinner = newvalue;
                                        });
                                      },
                                    )
                                  : SignupForm(
                                      onSigup: (newValue) {
                                        setState(() {
                                          showSpinner = newValue;
                                        });
                                      },
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
            )
          ],
        ),
      )),
    );
  }
}

class LoginForm extends StatefulWidget {
  final Function(bool) onLogin;
  final _auth = FirebaseAuth.instance;
  String _email, _password;
  LoginForm({this.onLogin});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: circularBorder,
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(18.0),
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Enter your E-mail",
              border: OutlineInputBorder(),
            ),
//            onSaved:(input) => _email = input,
            onChanged: (newValue) {
              print(num.tryParse(newValue) != null);
              widget._email = newValue;
              print(widget._email);
            },
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter your password",
              border: OutlineInputBorder(),
            ),
//            onSaved: (input) => _password = input,
            onChanged: (newValue) {
              print(newValue);
              widget._password = newValue;
              print(widget._password);
            },
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: main_light_color,
            textColor: Colors.white,
            elevation: 0.2,
            shape: RoundedRectangleBorder(
              borderRadius: circularBorder,
            ),
            child: Text("Login"),
            onPressed: () async {
              widget.onLogin(true);
              if (widget._email == null || widget._email == '') {
                Toast.show('email can\'t be empty', context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              } else {
                if (widget._password == null || widget._password == '') {
                  Toast.show("password can\'t be empty", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                } else {
                  try {
                    final user = await widget._auth.signInWithEmailAndPassword(
                        email: widget._email, password: widget._password);
                    if (user != null) {
                      Toast.show("Done", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
//                      SharedPreferences prefs =
//                          await SharedPreferences.getInstance();
//                      prefs?.setBool("isLoggedIn", true);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }
                  } catch (e) {
                    Toast.show(e.toString(), context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  }
                  widget._email = '';
                  widget._password = '';
                }
              }
              widget.onLogin(false);
            },
          ),
        ],
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  final Function(bool) onSigup;
  final _auth = FirebaseAuth.instance;
  String _name, _email, _password1, _password2;
  SignupForm({this.onSigup});

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: circularBorder,
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(18.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                      'Upload a personal images : ${_image == null ? '' : _image.path.substring(_image.path.lastIndexOf('/'))}'),
                ),
                IconButton(
                    icon: Icon(Icons.photo_library),
                    onPressed: () async {
                      await getImage();
                    }),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Enter your Name",
              border: OutlineInputBorder(),
            ),
            onChanged: (newValue) {
              widget._name = newValue;
            },
          ),
          const SizedBox(height: 10.0),
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Enter your E-mail",
              border: OutlineInputBorder(),
            ),
            onChanged: (newValue) {
              widget._email = newValue;
            },
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter a password",
              border: OutlineInputBorder(),
            ),
            onChanged: (newValue) {
              widget._password1 = newValue;
            },
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Repeat the password",
              border: OutlineInputBorder(),
            ),
            onChanged: (newValue) {
              widget._password2 = newValue;
            },
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: main_light_color,
            textColor: Colors.white,
            elevation: 0.2,
            shape: RoundedRectangleBorder(
              borderRadius: circularBorder,
            ),
            child: Text("SignUp"),
            onPressed: () async {
              widget.onSigup(true);
              if (widget._email == null || widget._email == '') {
                Toast.show("The email feild can't be empty", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              } else {
                if (widget._password1 == null || widget._password1 == '') {
                  Toast.show("invalid password", context,
                      duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                } else {
                  if (widget._password1 == widget._password2) {
                    if (widget._password1.length < 6) {
                      Toast.show(
                          "password should be at least 6 characters", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    } else {
                      try {
                        final newUser = await widget._auth
                            .createUserWithEmailAndPassword(
                                email: widget._email,
                                password: widget._password1);
                        if (newUser != null) {
                          widget._email = '';
                          widget._password1 = '';
                          widget._password2 = '';
                          Toast.show("Signed up sucsessful", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
//                          SharedPreferences prefs =
//                              await SharedPreferences.getInstance();
//                          prefs?.setBool("isLoggedIn", true);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }
                      } catch (e) {
                        Toast.show(e.toString(), context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      }
                    }
                  } else {
                    Toast.show("The password is not identical", context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  }
                }
              }
              widget.onSigup(false);
            },
          ),
        ],
      ),
    );
  }
}
