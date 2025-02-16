import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:fake_store_app/common/bloc/button/cubit/button_cubit.dart';
import 'package:fake_store_app/common/bloc/button/cubit/button_state.dart';
import 'package:fake_store_app/common/widgets/button/basic_app_button.dart';
import 'package:fake_store_app/core/configs/app_theme.dart';
import 'package:fake_store_app/core/data/models/signin_req_params.dart';
import 'package:fake_store_app/core/domain/usecases/login.dart';
import 'package:fake_store_app/helpers/widgets/custom_text_field.dart';
import 'package:fake_store_app/routers/router_name.dart';
import 'package:fake_store_app/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();

    usernameController.addListener(_validateInputs);
    passwordController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      isButtonEnabled = usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider.value(
          value: ButtonStateCubit(),
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if (state is ButtonSuccess) {
                context.pushReplacementNamed(RouterName.home);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login success')),
                );
                //close state
                context.read<ButtonStateCubit>().close();
              }
              if (state is ButtonFailure) {
                var snackBar = SnackBar(content: Text(state.errorMessage));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(100),
                    Center(
                      child: Image.asset(
                        'assets/images/logo_store.png',
                        width: 200,
                      ),
                    ),
                    const Gap(20),
                    const Text(
                      "Welcome back!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Gap(5),
                    const Text(
                      "Log in with username & username available on fakestoreapi",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    const Gap(20),
                    CustomTextField(
                      height: 60,
                      controller: usernameController,
                      hintText: 'Username address',
                      prefixIcon: Icons.account_circle_rounded,
                      prefixIconColor: Colors.grey,
                    ),
                    const Gap(10),
                    CustomTextField(
                      height: 60,
                      controller: passwordController,
                      hintText: 'Password',
                      isPassword: true,
                      prefixIcon: Icons.lock_rounded,
                      prefixIconColor: Colors.grey,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: AppTheme.appTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Builder(builder: (context) {
                      return BasicAppButton(
                        onPressed: isButtonEnabled
                            ? () {
                                context.read<ButtonStateCubit>().excute(
                                    usecase: sl<LoginUseCase>(),
                                    params: SigninReqParams(
                                        username: usernameController.text,
                                        password: passwordController.text));
                              }
                            : null,
                        title: "Log in",
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: AppTheme.appTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
