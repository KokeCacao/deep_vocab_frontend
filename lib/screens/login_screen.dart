import 'package:f_logs/f_logs.dart' hide Constants;
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import '../view_models/auth_view_model.dart';
import '../widgets/separator.dart';
import '../utils/snack_bar_manager.dart';
import '../utils/constants.dart';

enum LoginScreenEnum {
  login,
  register,
  recover,
}

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

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  late bool _passwordVisible;
  LoginScreenEnum _state = LoginScreenEnum.register;
  int _index = 0;

  String? _userName;
  String? _email;
  String? _password;
  String? _verification;
  String? _tmpPassword;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    final ModalRoute? _ = ModalRoute.of(context);
    if (_ != null) {
      final Map<String, dynamic>? arguments = _.settings.arguments as Map<String, dynamic>?;
      if (arguments != null) {
        if (arguments.containsKey("index")) _index = arguments["index"];
        if (arguments.containsKey("state")) _state = arguments["state"];
      }
    }

    void onBack() {
      if (_index == 0) {
        Navigator.of(context).maybePop();
      } else {
        _index--;
        setState(() {});
      }
    }

    void switchToLogin() {
      _state = LoginScreenEnum.login;
      _index = 0;
      widget._userNameNode.requestFocus();
      setState(() {});
    }

    void switchToRegister() {
      _state = LoginScreenEnum.register;
      _index = 0;
      widget._userNameNode.requestFocus();
      setState(() {});
    }

    void switchToRecover() {
      _state = LoginScreenEnum.recover;
      _index = 0;
      widget._emailNode.requestFocus();
      setState(() {});
    }

    void submit() async {
      // stop submit if the current field is wrong
      _passwordVisible = false;
      switch (_state) {
        case LoginScreenEnum.login:
          {
            switch (_index) {
              case 0:
                if (!widget._usernameFieldKey.currentState!.validate()) return;
                FocusScope.of(context).unfocus();
                _index++;
                setState(() {});
                widget._passwordNode.requestFocus();
                return;
              case 1:
                if (!widget._formKey.currentState!.validate()) return;
                FocusScope.of(context).unfocus();
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
          }
        case LoginScreenEnum.register:
          {
            switch (_index) {
              case 0:
                if (!widget._usernameFieldKey.currentState!.validate()) return;
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
                if (!widget._passwordTestFieldKey.currentState!.validate())
                  return;
                FocusScope.of(context).unfocus();

                // send request for email verification
                if (!widget._usernameFieldKey.currentState!.validate()) return;
                if (!widget._emailFieldKey.currentState!.validate()) return;
                if (!widget._passwordFieldKey.currentState!.validate()) return;
                if (!widget._passwordTestFieldKey.currentState!.validate())
                  return;
                widget._formKey.currentState!.save();

                SnackBarManager.showPersistentSnackBar(
                    context, "    Sending verification code  ...");

                AuthViewModel authViewModel =
                    Provider.of<AuthViewModel>(context, listen: false);

                String? errorMessage = await authViewModel
                    .requestEmailVerification(_userName!, _password!, _email!);

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
                // no need to validate verification code because
                // it already validated before calling this function
                if (!widget._formKey.currentState!.validate()) return;
                FocusScope.of(context).unfocus();
                widget._formKey.currentState!.save();

                SnackBarManager.showPersistentSnackBar(
                    context, "    Creating Account ...");

                AuthViewModel authViewModel =
                    Provider.of<AuthViewModel>(context, listen: false);

                String? errorMessage = await authViewModel.createUser(
                    _userName!, _password!, _email!, _verification!);

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
        case LoginScreenEnum.recover:
          {
            switch (_index) {
              case 0:
                if (!widget._emailFieldKey.currentState!.validate()) return;
                FocusScope.of(context).unfocus();
                widget._formKey.currentState!.save();

                SnackBarManager.showPersistentSnackBar(
                    context, "    Sending verification code  ...");

                AuthViewModel authViewModel =
                    Provider.of<AuthViewModel>(context, listen: false);

                String? errorMessage = await authViewModel
                    .requestEmailVerification("", "", _email!);

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
              case 1:
                // no need to validate verification code because
                // it already validated before calling this function
                if (!widget._emailFieldKey.currentState!.validate()) return;
                FocusScope.of(context).unfocus();
                widget._formKey.currentState!.save();

                SnackBarManager.showPersistentSnackBar(
                    context, "    Creating Account ...");

                AuthViewModel authViewModel =
                    Provider.of<AuthViewModel>(context, listen: false);

                String? errorMessage = await authViewModel.createUser(
                    "", "", _email!, _verification!);

                SnackBarManager.hideCurrentSnackBar(context);

                if (errorMessage == null) {
                  _index++;
                  setState(() {});
                  widget._passwordNode.requestFocus();
                  SnackBarManager.showSnackBar(
                      context, "Now Type your new password");
                  return;
                } else
                  SnackBarManager.showSnackBar(context, errorMessage);
                return;
              case 2:
                if (!widget._passwordFieldKey.currentState!.validate()) return;
                FocusScope.of(context).unfocus();
                _index++;
                setState(() {});
                widget._passwordTestNode.requestFocus();
                return;
              case 3:
                // no need to validate verification code because
                // it already validated before calling this function
                if (!widget._formKey.currentState!.validate()) return;
                FocusScope.of(context).unfocus();
                widget._formKey.currentState!.save();

                SnackBarManager.showPersistentSnackBar(
                    context, "    Resetting Password ...");

                AuthViewModel authViewModel =
                    Provider.of<AuthViewModel>(context, listen: false);

                String? errorMessage = await authViewModel.createUser(
                    "", _password!, _email!, _verification!);

                SnackBarManager.hideCurrentSnackBar(context);

                if (errorMessage == null) {
                  Navigator.of(context).pop();
                } else
                  SnackBarManager.showSnackBar(context, errorMessage);
                return;
              default:
                FLog.severe(
                    text:
                        "[LoginScreen] Reached Unsupported Index when recovering");
                return;
            }
          }
      }
    }

    TextFormField usernameField = TextFormField(
      key: widget._usernameFieldKey,
      decoration: InputDecoration(labelText: "Username"),
      textInputAction: TextInputAction.next,
      focusNode: widget._userNameNode,
      validator: (value) {
        if (value == null || value.isEmpty) return "Please enter your username";
        if (value.length < 4 || value.length > 64)
          return "Username is between [4, 64] characters";
        if (!RegExp(Constants.REGEXP_USERNAME, unicode: true).hasMatch(value))
          return "Invalid characters";
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
        if (value == null || value.isEmpty)
          return "Please enter your email address";
        if (value.length < 4 || value.length > 64)
          return "Email is between [4, 64] characters";
        if (RegExp(Constants.REGEXP_EMAIL, unicode: true).hasMatch(value))
          return null;
        return "Invalid email";
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
      textInputAction: TextInputAction.next,
      focusNode: widget._passwordNode,
      validator: (value) {
        if (value!.isEmpty) return "Please enter your password";
        if (value.length < 6 || value.length > 64)
          return "Password is between [6, 64] characters";
        if (!RegExp(Constants.REGEXP_PASSWORD).hasMatch(value))
          return "Password should contain at least one letter and one number";
        return null;
      },
      onSaved: (value) {
        _password = sha256.convert(utf8.encode(value!)).toString();
      },
      onChanged: (value) {
        _tmpPassword = value;
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
        if (_tmpPassword != value) return "Password does not match";
        return null;
      },
      onSaved: (value) {
        _password = sha256.convert(utf8.encode(value!)).toString();
      },
    );

    // TextFormField verificationField = TextFormField(
    //   key: widget._verificationFieldKey,
    //   keyboardType: TextInputType.number,
    //   inputFormatters: <TextInputFormatter>[
    //     FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    //   ],
    //   decoration:
    //       InputDecoration(labelText: "Verification Code From Your Email"),
    //   textInputAction: TextInputAction.done,
    //   focusNode: widget._verificationNode,
    //   validator: (value) {
    //     if (value!.isEmpty) return "Please enter your verification code";
    //     if (value.length != 6) return "Verification code should be 6 digits";
    //     return null;
    //   },
    //   onSaved: (value) {
    //     _verification = value;
    //   },
    //   onFieldSubmitted: (string) => submit(),
    // );

    String? pinCodeValidator(String? value) {
      if (value == null || value.isEmpty)
        return "Please enter verification code";
      if (!RegExp(Constants.REGEXP_CODE).hasMatch(value))
        return "Validation Code contains 6 digits";
      return null;
    }

    PinCodeTextField verificationField = PinCodeTextField(
      autoDisposeControllers: false, // don't dispose [FocusNode]
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: widget._verificationNode,
      validator: pinCodeValidator,
      appContext: context,
      length: 6,
      obscureText: false,
      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      pastedTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      useHapticFeedback: false,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeColor: Colors.black,
        selectedColor: Colors.black,
        inactiveColor: Colors.black,
        activeFillColor: Colors.black12,
        selectedFillColor: Colors.transparent,
        inactiveFillColor: Colors.transparent,
      ),
      animationType: AnimationType.slide,
      animationDuration: Duration(milliseconds: 10),
      backgroundColor: Colors.transparent,
      cursorColor: Colors.black,
      enableActiveFill: false,
      onCompleted: (string) => {if (pinCodeValidator(string) == null) submit()},
      onSaved: (value) {
        _verification = value;
      },
      onChanged: (String value) {},
      beforeTextPaste: (text) => pinCodeValidator(text) == null,
    );

    List<Widget> getEnumRoute(LoginScreenEnum e) {
      switch (e) {
        case LoginScreenEnum.login:
          return [usernameField, passwordField];
        case LoginScreenEnum.register:
          return [
            usernameField,
            emailField,
            passwordField,
            passwordTestField,
            Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: verificationField),
          ];
        case LoginScreenEnum.recover:
          return [
            emailField,
            Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: verificationField),
            passwordField,
            passwordTestField,
          ];
      }
    }

    String getEnumName(LoginScreenEnum e) {
      switch (e) {
        case LoginScreenEnum.login:
          return "Login";
        case LoginScreenEnum.register:
          return "Register";
        case LoginScreenEnum.recover:
          return "Reset Password";
      }
    }

    String getEnumButtonName(int index, LoginScreenEnum e) {
      switch (e) {
        case LoginScreenEnum.login:
          return index == 1 ? "Login" : "Next";
        case LoginScreenEnum.register:
          return index == 3 ? "Send Email" : "Next";
        case LoginScreenEnum.recover:
          return "Next";
      }
    }

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
                        getEnumName(_state),
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      IndexedStack(
                        index: _index,
                        children: getEnumRoute(_state),
                      ),
                      if (_state != LoginScreenEnum.recover)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                _state == LoginScreenEnum.login
                                    ? "Don't have an account? "
                                    : "Already have an account? ",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                )),
                            TextButton(
                                onPressed: _state == LoginScreenEnum.login
                                    ? switchToRegister
                                    : switchToLogin,
                                child: Text(
                                  _state == LoginScreenEnum.login
                                      ? "Create Account"
                                      : "Log in",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      decoration: TextDecoration.underline),
                                ))
                          ],
                        ),
                      if (_state != LoginScreenEnum.recover)
                        TextButton(
                            onPressed: switchToRecover,
                            child: Text(
                              "Forgot Password",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  decoration: TextDecoration.underline),
                            )),
                      Separator(
                        height: 20,
                        color: Colors.transparent,
                      ),
                      ElevatedButton(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(getEnumButtonName(_index, _state),
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
