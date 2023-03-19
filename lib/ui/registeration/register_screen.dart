import 'package:chat/base/base_state.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/ui/login/login_screen.dart';
import 'package:chat/ui/registeration/register_viewModel.dart';

import 'package:chat/ui/utils/validation_utils.dart';
import 'package:chat/ui/reusable/button_form.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, RegisterViewModel>
    implements RegisterNavigator {
  bool securedPassword = true;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();

  @override
  RegisterViewModel initViewModel() {
    // TODO: implement initViewModel
    return RegisterViewModel();
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
              title: const Center(child: Text('Create Account')),
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
                      TextFormField(
                        controller: nameController,
                        decoration:
                            const InputDecoration(labelText: 'Full Name'),
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
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
                      FormButton(
                          text: 'Create Account',
                          onPressed: onCreateAccountClick),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child: const Text('Already have an account?'))
                    ],
                  ),
                )),
          )),
    );
  }

  void onCreateAccountClick() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.register(
        emailController.text, passwordController.text, nameController.text);
  }

  @override
  goToHome(String routeName, MyUser user) {
    Navigator.pushReplacementNamed(context, routeName);
    var userProvider = Provider.of<UserProvider>(context);
    userProvider.user = user;
  }
}
