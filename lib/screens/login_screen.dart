import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halls_city/services/firebase_auth.dart';
import 'package:halls_city/services/halls_data.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../Constants.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  String backImg = 'images/login.jpg';
  bool formVisible, showSpinner = false;
  int _formsIndex;
  HallsData _hallsData = HallsData();

  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: network_image3,
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
                          color: Colors.lightBlue,
                          textColor: Colors.white,
                          elevation: 0.2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
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
                          color: Colors.grey.shade700,
                          textColor: Colors.white,
                          elevation: 0.2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
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
                  OutlineButton.icon(
                    borderSide: BorderSide(color: Colors.lightBlue),
                    color: Colors.lightBlue,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    icon: Icon(const IconData(0xe900, fontFamily: 'icons')),
                    label: Text("Continue with Google"),
                    onPressed: () {},
                  ),
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
                                    ? Colors.lightBlue
                                    : Colors.white,
                                child: Text("Login"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
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
                                    ? Colors.lightBlue
                                    : Colors.white,
                                child: Text("Signup"),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
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
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(18.0),
        children: <Widget>[
          TextFormField(
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
            color: Colors.lightBlue,
            textColor: Colors.white,
            elevation: 0.2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
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

//class LoginForm extends StatelessWidget {
////  final _formKey = GlobalKey<FormState>();
//
//
//
////  void _login(){
////    if (_formKey.currentState.validate()) {
////      _formKey.currentState.save();
////      // Logging in the user to Firebase
////      AuthService.login(_email, _password);
////    }
////  }
//
//  //لسة هاكتب كود ال signUp لما نتفق علي طريقة
//
//
//}

class SignupForm extends StatefulWidget {
  final Function(bool) onSigup;
  final _auth = FirebaseAuth.instance;
  String _email, _password1, _password2;
  SignupForm({this.onSigup});

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(18.0),
        children: <Widget>[
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
            color: Colors.lightBlue,
            textColor: Colors.white,
            elevation: 0.2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
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
                          Toast.show("Done", context,
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

//
//class SignupForm extends StatelessWidget {
//  //باين من اسمة ولله
//
//
//
//}
