import 'package:auto_size_text/auto_size_text.dart';
import '../view_models/auth_view_model.dart';
import '../widgets/separator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  bool _login = true;
  int _index = 0;

  final FocusNode _userNameNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _usernameFieldKey = GlobalKey<FormFieldState>();
  final _emailFieldKey = GlobalKey<FormFieldState>();
  final _passwordFieldKey = GlobalKey<FormFieldState>();

  String? _userName;
  String? _email;
  String? _password;

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    void onBack() {
      if (widget._index == 0) {
        Navigator.of(context).maybePop();
      } else {
        widget._index--;
        setState(() {});
      }
    }

    void submit() async {
      // stop submit if the current field is wrong
      switch (widget._index) {
        case 0:
          if (!widget._usernameFieldKey.currentState!.validate()) return;
          break;
        case 1:
          if (widget._login ? !widget._passwordFieldKey.currentState!.validate() : !widget._emailFieldKey.currentState!.validate()) return;
          break;
        case 2:
          if (!widget._passwordFieldKey.currentState!.validate()) return;
          break;
      }

      // stop submit if it is not the last field
      int maxStack = widget._login ? 1 : 2;
      if (widget._index != maxStack) {
        FocusScope.of(context).unfocus(); // stop user from editing previous field
        widget._index++;
        switch (widget._index) {
          case 0:
            widget._userNameNode.requestFocus();
            break;
          case 1:
            widget._login ? widget._passwordNode.requestFocus() : widget._emailNode.requestFocus();
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

      widget._scaffoldKey.currentState!.showSnackBar(SnackBar(
        duration: Duration(seconds: 4),
        content: Row(
          children: <Widget>[CircularProgressIndicator(), Text(widget._login ? "    Signing In ..." : "    Creating Account ...")],
        ),
      ));
      AuthViewModel authViewModel = Provider.of<AuthViewModel>(context, listen: false);

      String? errorMessage = widget._login
          ? await authViewModel.loginWithUsernameIfNeeded(widget._userName, widget._password)
          : await authViewModel.createUser(widget._userName, widget._password, widget._email);

      widget._scaffoldKey.currentState!.hideCurrentSnackBar();

      if (errorMessage == null) {
        Navigator.of(context).pop();
        // TODO: the below two lines of code should not needed because we use ProxyProvider
        // UserViewModel userViewModel = Provider.of<UserViewModel>(context, listen: false);
        // userViewModel.updateIfNeeded();
      } else
        widget._scaffoldKey.currentState!.showSnackBar(SnackBar(
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
      widget._index = 0;
      setState(() {});
    }

    TextFormField usernameField = TextFormField(
      key: widget._usernameFieldKey,
      decoration: InputDecoration(labelText: "Username"),
      textInputAction: TextInputAction.next,
      focusNode: widget._userNameNode,
      validator: (value) {
        if (value!.isEmpty) return "Please enter your username";
        if (value.length > 64) return "Username needs to be shorter than 64 characters";
        return null;
      },
      onSaved: (value) {
        widget._userName = value;
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
        widget._email = value;
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
        if (value.length < 6 && value.length > 64) return "Password should be between 7 and 63 characters";
        if (int.tryParse(value) != null) return "Password should not be just numbers";
        return null;
      },
      onSaved: (value) {
        widget._password = value;
      },
      onFieldSubmitted: (string) => submit(),
    );

    return Scaffold(
        key: widget._scaffoldKey,
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
                        widget._login ? "Login" : "Register",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      // TODO: advanced validation on email(email format) and password(safety), and maybe on username to prevent special characters
                      IndexedStack(
                        index: widget._index,
                        children: [
                          usernameField,
                          widget._login ? passwordField : emailField,
                          widget._login
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
                          Text(widget._login ? "Don't have an account? " : "Already have an account? ",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.blueGrey,
                              )),
                          FlatButton(
                              onPressed: switchLogin,
                              child: Text(
                                widget._login ? "Create Account" : "Log in",
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.blueGrey, decoration: TextDecoration.underline),
                              ))
                        ],
                      ),
                      Separator(
                        height: 20,
                        color: Colors.transparent,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.all(10),
                        child: Text(
                            widget._login ? (widget._index == 1 ? "Login": "Next") : (widget._index == 2 ? "Create Account": "Next"),
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
