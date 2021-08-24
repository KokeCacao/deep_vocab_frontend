import 'package:auto_size_text/auto_size_text.dart';
import 'package:deep_vocab/utils/snack_bar_manager.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/separator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  final FocusNode _userNameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _usernameFieldKey = GlobalKey<FormFieldState>();
  final _emailFieldKey = GlobalKey<FormFieldState>();
  final _passwordFieldKey = GlobalKey<FormFieldState>();

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  late bool _passwordVisible;
  bool _login = true;
  int _index = 0;

  String? _userName;
  String? _email;
  String? _password;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    void onBack() {
      if (_index == 0) {
        Navigator.of(context).maybePop();
      } else {
        _index--;
        setState(() {});
      }
    }

    void submit() async {
      // stop submit if the current field is wrong
      switch (_index) {
        case 0:
          if (!widget._usernameFieldKey.currentState!.validate()) return;
          break;
        case 1:
          if (_login
              ? !widget._passwordFieldKey.currentState!.validate()
              : !widget._emailFieldKey.currentState!.validate()) return;
          break;
        case 2:
          if (!widget._passwordFieldKey.currentState!.validate()) return;
          break;
      }

      // stop submit if it is not the last field
      int maxStack = _login ? 1 : 2;
      if (_index != maxStack) {
        FocusScope.of(context)
            .unfocus(); // stop user from editing previous field
        _index++;
        switch (_index) {
          case 0:
            widget._userNameNode.requestFocus();
            break;
          case 1:
            _login
                ? widget._passwordNode.requestFocus()
                : widget._emailNode.requestFocus();
            break;
          case 2:
            widget._passwordNode.requestFocus();
            break;
        }
        setState(() {});
        return;
      }

      // start submit
      if (!widget._formKey.currentState!.validate()) return;
      widget._formKey.currentState!.save();

      SnackBarManager.showPersistentSnackBar(context, _login ? "    Signing In ..." : "    Creating Account ...");

      AuthViewModel authViewModel =
          Provider.of<AuthViewModel>(context, listen: false);

      String? errorMessage = _login
          ? await authViewModel.loginWithUsernameIfNeeded(_userName, _password)
          : await authViewModel.createUser(_userName, _password, _email);

      SnackBarManager.hideCurrentSnackBar(context);

      if (errorMessage == null) {
        Navigator.of(context).pop();
        // TODO: the below two lines of code should not needed because we use ProxyProvider
        // UserViewModel userViewModel = Provider.of<UserViewModel>(context, listen: false);
        // userViewModel.updateIfNeeded();
      } else
        SnackBarManager.showSnackBar(context, errorMessage);
    }

    void switchLogin() {
      _login = !_login;
      _index = 0;
      setState(() {});
    }

    TextFormField usernameField = TextFormField(
      key: widget._usernameFieldKey,
      decoration: InputDecoration(labelText: "Username"),
      textInputAction: TextInputAction.next,
      focusNode: widget._userNameNode,
      validator: (value) {
        if (value!.isEmpty) return "Please enter your username";
        if (value.length > 64)
          return "Username needs to be shorter than 64 characters";
        return null;
      },
      onSaved: (value) {
        _userName = value;
      },
    );

    TextFormField emailField = TextFormField(
      key: widget._emailFieldKey,
      decoration: InputDecoration(labelText: "Email"),
      textInputAction: TextInputAction.next,
      focusNode: widget._emailNode,
      validator: (value) {
        if (value!.isEmpty) return "Please enter your email address";
        return null;
      },
      onSaved: (value) {
        _email = value;
      },
    );

    TextFormField passwordField = TextFormField(
      key: widget._passwordFieldKey,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
          labelText: "Password",
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              _passwordVisible = !_passwordVisible;
              setState(() {});
            },
          )),
      textInputAction: TextInputAction.done,
      focusNode: widget._passwordNode,
      validator: (value) {
        if (value!.isEmpty) return "Please enter your password";
        if (value.length < 6 && value.length > 64)
          return "Password should be between 7 and 63 characters";
        if (int.tryParse(value) != null)
          return "Password should not be just numbers";
        return null;
      },
      onSaved: (value) {
        _password = sha256.convert(utf8.encode(value!)).toString();
      },
      onFieldSubmitted: (string) => submit(),
    );

    return Scaffold(
        appBar: CupertinoNavigationBar(
          leading: CupertinoButton(
            child: Icon(Icons.arrow_back_ios),
            padding: EdgeInsets.zero,
            onPressed: onBack,
          ),
          backgroundColor: Colors.transparent,
          border: Border(bottom: BorderSide(color: Colors.transparent)),
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
                        _login ? "Login" : "Register",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      // TODO: advanced validation on email(email format) and password(safety), and maybe on username to prevent special characters
                      IndexedStack(
                        index: _index,
                        children: [
                          usernameField,
                          _login ? passwordField : emailField,
                          _login
                              ? Separator(
                                  height: 0,
                                  color: Colors.transparent,
                                )
                              : passwordField,
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              _login
                                  ? "Don't have an account? "
                                  : "Already have an account? ",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.blueGrey,
                              )),
                          TextButton(
                              onPressed: switchLogin,
                              child: Text(
                                _login ? "Create Account" : "Log in",
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
                      ElevatedButton(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                              _login
                                  ? (_index == 1 ? "Login" : "Next")
                                  : (_index == 2 ? "Create Account" : "Next"),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
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
