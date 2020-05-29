import 'package:chat_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final username = FocusNode();
  final password = FocusNode();

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = "";
  String _username = "";
  String _userPassword = "";

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  UserImagePicker(),
                  TextFormField(
                    key: ValueKey("email"),
                    onSaved: (newValue) => _userEmail = newValue,
                    validator: (value) {
                      if (value.isEmpty || !value.contains("@")) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).requestFocus(username),
                    decoration: InputDecoration(
                      labelText: "Email",
                    ),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey("username"),
                      onSaved: (newValue) => _username = newValue,
                      validator: (value) {
                        if (value.isEmpty || value.length < 8) {
                          return "username must be at least 8 characters";
                        }
                        return null;
                      },
                      focusNode: username,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) =>
                          FocusScope.of(context).requestFocus(password),
                      decoration: InputDecoration(labelText: "Username"),
                    ),
                  TextFormField(
                    key: ValueKey("password"),
                    onSaved: (newValue) => _userPassword = newValue,
                    validator: (value) {
                      if (value.isEmpty || value.length < 8) {
                        return "Password must be at least 8 characters";
                      }
                      return null;
                    },
                    focusNode: password,
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (widget.isLoading)
                    CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  if (!widget.isLoading)
                    RaisedButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: _submitForm,
                        child: Text(_isLogin ? "Login" : "Sign Up")),
                  if (!widget.isLoading)
                    FlatButton(
                      child: Text(_isLogin
                          ? "Create new account"
                          : "Already have an account"),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _username.trim(),
          _isLogin, context);
    }
  }
}
