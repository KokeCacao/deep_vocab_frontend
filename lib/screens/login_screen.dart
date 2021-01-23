import 'package:auto_size_text/auto_size_text.dart';
import 'package:deep_vocab/view_models/auth_view_model.dart';
import 'package:deep_vocab/view_models/user_view_model.dart';
import 'package:deep_vocab/widgets/separator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  bool _login = true;

  final FocusNode _userNameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _userName;
  String _email;
  String _password;

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    void submit() async {
      if (!widget._formKey.currentState.validate()) return;
      widget._formKey.currentState.save();
      widget._scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 4),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text(widget._login
                ? "    Signing In ..."
                : "    Creating Account ...")
          ],
        ),
      ));
      AuthViewModel authViewModel =
          Provider.of<AuthViewModel>(context, listen: false);

      String errorMessage = widget._login
          ? await authViewModel.loginWithUsername(
              widget._userName, widget._password)
          : await authViewModel.createUser(
              widget._userName, widget._password, widget._email);

      widget._scaffoldKey.currentState.hideCurrentSnackBar();

      if (errorMessage == null) {
        Navigator.of(context).pop();
        UserViewModel userViewModel =
            Provider.of<UserViewModel>(context, listen: false);
        userViewModel.updateIfNeeded();
      } else
        widget._scaffoldKey.currentState.showSnackBar(SnackBar(
          duration: Duration(seconds: 4),
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: AutoSizeText(
              errorMessage,
              overflow: TextOverflow.fade,
              maxLines: 1,
            ),
          ),
        ));
    }

    void switchLogin() {
      widget._login = !widget._login;
      setState(() {});
    }

    return Scaffold(
        key: widget._scaffoldKey,
        appBar: CupertinoNavigationBar(
          previousPageTitle: "Back",
        ),
        body: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Center(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: widget._formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text(
                        widget._login ? "Login" : "Register",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      // TODO: advanced validation on email(email format) and password(safety), and maybe on username to prevent special characters
                      TextFormField(
                        decoration: InputDecoration(labelText: "Username"),
                        textInputAction: TextInputAction.next,
                        focusNode: widget._userNameNode,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Please enter your username";
                          if (value.length > 64)
                            return "Username needs to be shorter than 64 characters";
                          return null;
                        },
                        onSaved: (value) {
                          widget._userName = value;
                        },
                      ),
                      widget._login
                          ? Separator(
                              height: 0,
                              color: Colors.transparent,
                            )
                          : TextFormField(
                              decoration: InputDecoration(labelText: "Email"),
                              textInputAction: TextInputAction.next,
                              focusNode: widget._emailNode,
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Please enter your email address";
                                return null;
                              },
                              onSaved: (value) {
                                widget._email = value;
                              },
                            ),
                      TextFormField(
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                            labelText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                _passwordVisible = !_passwordVisible;
                                setState(() {
                                });
                              },
                            )),
                        textInputAction: TextInputAction.done,
                        focusNode: widget._passwordNode,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Please enter your password";
                          if (value.length < 6 && value.length > 64)
                            return "Password should be between 7 and 63 characters";
                          if (int.tryParse(value) != null)
                            return "Password should not be just numbers";
                          return null;
                        },
                        onSaved: (value) {
                          widget._password = value;
                        },
                        onFieldSubmitted: (string) => submit(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              widget._login
                                  ? "Don't have an account? "
                                  : "Already have an account? ",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.blueGrey,
                              )),
                          FlatButton(
                              onPressed: switchLogin,
                              child: Text(
                                widget._login ? "Create Account" : "Log in",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      ),
                      Separator(
                        height: 20,
                        color: Colors.transparent,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.all(10),
                        child: Text(widget._login ? "Login" : "Create Account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: submit,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
