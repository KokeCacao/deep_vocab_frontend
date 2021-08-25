import 'package:f_logs/f_logs.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import '../view_models/auth_view_model.dart';
import '../widgets/separator.dart';
import '../utils/snack_bar_manager.dart';

class LoginScreen extends StatefulWidget {
  final FocusNode _userNameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordTestNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _verificationNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _usernameFieldKey = GlobalKey<FormFieldState>();
  final _emailFieldKey = GlobalKey<FormFieldState>();
  final _passwordFieldKey = GlobalKey<FormFieldState>();
  final _passwordTestFieldKey = GlobalKey<FormFieldState>();
  final _verificationFieldKey = GlobalKey<FormFieldState>();

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
  String? _verification;
  String? _tmp_password;

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
      _passwordVisible = false;
      if (_login) {
        switch (_index) {
          case 0:
            if (!widget._usernameFieldKey.currentState!.validate()) return;
            // stop user from editing previous field
            FocusScope.of(context).unfocus();
            _index++;
            setState(() {});
            widget._passwordNode.requestFocus();
            return;
          case 1:
            if (!widget._passwordFieldKey.currentState!.validate()) return;

            // start submit
            if (!widget._formKey.currentState!.validate()) return;
            widget._formKey.currentState!.save();

            SnackBarManager.showPersistentSnackBar(
                context, "    Signing In ...");

            AuthViewModel authViewModel =
                Provider.of<AuthViewModel>(context, listen: false);

            String? errorMessage = await authViewModel
                .loginWithUsernameIfNeeded(_userName, _password);

            SnackBarManager.hideCurrentSnackBar(context);

            if (errorMessage == null) {
              Navigator.of(context).pop();
              // TODO: the below two lines of code should not needed because we use ProxyProvider
              // UserViewModel userViewModel = Provider.of<UserViewModel>(context, listen: false);
              // userViewModel.updateIfNeeded();
            } else
              SnackBarManager.showSnackBar(context, errorMessage);
            return;
          default:
            FLog.severe(
                text: "[LoginScreen] Reached Unsupported Index when login");
            return;
        }
      } else {
        switch (_index) {
          case 0:
            if (!widget._usernameFieldKey.currentState!.validate()) return;
            // stop user from editing previous field
            FocusScope.of(context).unfocus();
            _index++;
            setState(() {});
            widget._emailNode.requestFocus();
            return;
          case 1:
            if (!widget._emailFieldKey.currentState!.validate()) return;
            FocusScope.of(context).unfocus();
            _index++;
            setState(() {});
            widget._passwordNode.requestFocus();
            return;
          case 2:
            if (!widget._passwordFieldKey.currentState!.validate()) return;
            FocusScope.of(context).unfocus();
            _index++;
            setState(() {});
            widget._passwordTestNode.requestFocus();
            return;
          case 3:
            if (!widget._passwordTestFieldKey.currentState!.validate()) return;
            FocusScope.of(context).unfocus();

            // send request for email verification
            if (!widget._usernameFieldKey.currentState!.validate()) return;
            if (!widget._emailFieldKey.currentState!.validate()) return;
            if (!widget._passwordFieldKey.currentState!.validate()) return;
            if (!widget._passwordTestFieldKey.currentState!.validate()) return;
            widget._formKey.currentState!.save();

            SnackBarManager.showPersistentSnackBar(context,
                "    We are sending the verification code to your email  ...");

            AuthViewModel authViewModel =
                Provider.of<AuthViewModel>(context, listen: false);

            String? errorMessage = await authViewModel.requestEmailVerification(
                _userName!, _password!, _email!);

            SnackBarManager.hideCurrentSnackBar(context);

            if (errorMessage == null) {
              _index++;
              setState(() {});
              widget._verificationNode.requestFocus();
              SnackBarManager.showSnackBar(
                  context, "Please check your Email for Verification Code");
              return;
            } else
              SnackBarManager.showSnackBar(context, errorMessage);
            return;
          case 4:
            if (!widget._verificationFieldKey.currentState!.validate()) return;

            // start submit
            if (!widget._formKey.currentState!.validate()) return;
            widget._formKey.currentState!.save();

            SnackBarManager.showPersistentSnackBar(
                context, "    Creating Account ...");

            AuthViewModel authViewModel =
                Provider.of<AuthViewModel>(context, listen: false);

            String? errorMessage =
                await authViewModel.createUser(_userName!, _password!, _email!, _verification!);

            SnackBarManager.hideCurrentSnackBar(context);

            if (errorMessage == null) {
              Navigator.of(context).pop();
              // TODO: the below two lines of code should not needed because we use ProxyProvider
              // UserViewModel userViewModel = Provider.of<UserViewModel>(context, listen: false);
              // userViewModel.updateIfNeeded();
            } else
              SnackBarManager.showSnackBar(context, errorMessage);
            return;
          default:
            FLog.severe(
                text:
                    "[LoginScreen] Reached Unsupported Index when registering");
            return;
        }
      }
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
      // controller: TextEditingController(), // for getting temporary value
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
      textInputAction: TextInputAction.next,
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
      onChanged: (value) {
        _tmp_password = value;
      },
    );

    TextFormField passwordTestField = TextFormField(
      key: widget._passwordTestFieldKey,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
          labelText: "Repeat Password",
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              _passwordVisible = !_passwordVisible;
              setState(() {});
            },
          )),
      textInputAction: TextInputAction.next,
      focusNode: widget._passwordTestNode,
      validator: (value) {
        if (_tmp_password != value) return "Password does not match";
        return null;
      },
      onSaved: (value) {
        _password = sha256.convert(utf8.encode(value!)).toString();
      },
    );

    TextFormField verificationField = TextFormField(
      key: widget._verificationFieldKey,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration:
          InputDecoration(labelText: "Verification Code From Your Email"),
      textInputAction: TextInputAction.done,
      focusNode: widget._verificationNode,
      validator: (value) {
        if (value!.isEmpty) return "Please enter your verification code";
        if (value.length != 6) return "Verification code should be 6 digits";
        return null;
      },
      onSaved: (value) {
        _verification = value;
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
                        children: _login
                            ? [usernameField, passwordField]
                            : [
                                usernameField,
                                emailField,
                                passwordField,
                                passwordTestField,
                                verificationField,
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
                                  : (_index == 3 ? "Send Email" : "Next"),
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
