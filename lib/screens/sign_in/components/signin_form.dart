import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/jumpingDots_button.dart';
import '../../../components/custom_suffix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

import '../../../models/Auth.dart';

import '../../../screens/home/home_screen.dart';
import '../../../screens/forgot_password/forgot_password_screen.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool kRemember = false;
  bool _isLoading = false;

  //manual auth
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  //remember me
  Future<void> _rememberMe(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('kRemember', value);
  }

  //auth
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).login(
        _authData['email'],
        _authData['password'],
      );

      Navigator.of(context).pushNamed(HomeScreen.routeName);
    } catch (error) {
      print(error);
      var errorMessage = 'Could not authenticate you. Please try again';
      if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = kEmailNotFound;
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = kInvalidPassword;
      }
      addError(error: errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionScreenHeight(13)),
          FormError(errors: errors),
          SizedBox(height: getProportionScreenHeight(10)),
          Row(
            children: [
              Checkbox(
                value: kRemember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    kRemember = value;
                    _rememberMe(true);
                  });
                },
              ),
              Text('Remember me'),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushNamed(ForgotPasswordScreen.routeName),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(
                    'Forgot password',
                    style: TextStyle(
                      shadows: [
                        Shadow(color: kTextColor, offset: Offset(0, -5))
                      ],
                      color: Colors.transparent,
                      decoration: TextDecoration.underline,
                      decorationColor: kPrimaryColor,
                      decorationThickness: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionScreenHeight(10)),
          Container(
            child: _isLoading
                ? JumpingDotsButton()
                : DefaultButton(
                    // text: _isLoading ? 'Working on it ...' : 'Continue',
                    text: 'Continue',
                    press: () {
                      _submit();
                    },
                  ),
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: passwordController,
      onSaved: (value) {
        _authData['password'] = value;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return;
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      onSaved: (value) {
        _authData['email'] = value;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Mail.svg",
        ),
      ),
    );
  }
}
