import 'package:chat/base/base_state.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/ui/login/login_viewModel.dart';
import 'package:chat/ui/registeration/register_screen.dart';
import 'package:chat/ui/reusable//button_form.dart';
import 'package:chat/ui/utils/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  bool securedPassword = true;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  LoginViewModel initViewModel() {
    // TODO: implement initViewModel
    return LoginViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill)),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Center(child: Text('Login')),
            ),
            body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),
                      const Text(
                        'Welcome back!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            const InputDecoration(labelText: 'E-mail Address'),
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter your e-mail address';
                          }
                          if (!ValidationUtils.isValidEmail(text)) {
                            return 'Please enter a valid e-mail';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: securedPassword,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: InkWell(
                                onTap: () {
                                  securedPassword = !securedPassword;
                                  setState(() {});
                                },
                                child: Icon(securedPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter your password';
                          }
                          if (text.length < 6) {
                            return 'Password should be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      FormButton(text: 'Login', onPressed: onLoginClick),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RegisterScreen.routeName);
                          },
                          child: const Text('Create Account ?'))
                    ],
                  ),
                )),
          )),
    );
  }

  void onLoginClick() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.login(emailController.text, passwordController.text);
  }

  @override
  goToHome(String routeName, MyUser user) {
    Navigator.pushReplacementNamed(context, routeName);
    var userProvider = Provider.of<UserProvider>(context);
    userProvider.user = user;
  }
}
