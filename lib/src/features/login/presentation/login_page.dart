import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/design_system/design_system.dart';
import '../../../core/widgets/textfield_widget.dart';
import '../../authentication/bloc/authentication_cubit.dart';
import 'bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        context.read<AuthenticationCubit>(),
      ),
      child: const LoginPageView(),
    );
  }
}

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  bool visibility = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Login',
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: IntrinsicHeight(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height / 1.2,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopify,
                        color: primaryColor50,
                        size: 48,
                      ),
                      Text(
                        'Klontong',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w600,
                          color: primaryColor50,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Username',
                            ),
                          ),
                          const SizedBox(height: 10),
                          MyTextField(
                            controller: _usernameController,
                            suffixIcon: const Icon(Icons.person),
                            validator: (string) {
                              if (string == null || string == "") {
                                return "Username tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Password',
                            ),
                          ),
                          const SizedBox(height: 10),
                          MyTextField(
                            controller: _passwordController,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visibility = !visibility;
                                });
                              },
                              icon: Icon(
                                visibility
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            validator: (string) {
                              if (string == null || string == "") {
                                return "Password tidak boleh kosong!";
                              }
                              return null;
                            },
                            obscureText: visibility,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          BlocListener<LoginBloc, LoginState>(
                            listener: (_, state) {
                              if (state is LoginLoading) {
                                showDialog(
                                  useRootNavigator: true,
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (ctx) => const AlertDialog.adaptive(
                                    icon: Icon(Icons.warning_amber),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator.adaptive(),
                                        Text(
                                          'Authenticating...',
                                          style: TextStyle(),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else if (state is LoginFailure) {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog.adaptive(
                                    icon: const Icon(Icons.warning_amber),
                                    content: Text(
                                      state.errorModel,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                        child: const Text(
                                          'Back',
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (state is LoginSucceed) {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                _logginUser(context);
                              }
                            },
                            child: SizedBox(
                              height: 48,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  backgroundColor: primaryColor50,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  _onTapButtonLogin(context);
                                },
                                child: const Text(
                                  'Login',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _logginUser(BuildContext context) {}

  void _onTapButtonLogin(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
            LoginUserEvent(
              _usernameController.value.text,
              _passwordController.value.text,
            ),
          );
    }
  }
}
