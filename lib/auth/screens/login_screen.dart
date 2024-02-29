import 'package:bfest/auth/controllers/login_controller.dart';
import 'package:bfest/widgets/animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Obx(() {
        return Get.find<LoginController>().isLoading.value
            ? const AnimatedLoader()
            : Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  // physics: const BouncingScrollPhysics(),
                  child: Container(
                    height: Get.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.pink.withOpacity(0.7),
                          Colors.purple.withOpacity(0.7),
                          Colors.blue.withOpacity(0.7),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Image.asset(
                          "assets/images/bfest.png",
                          height: Get.height * 0.3,
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          height: Get.height * 0.33,
                          decoration: const BoxDecoration(
                            // color: Colors.white.withOpacity(0.8),
                            // gradient: LinearGradient(
                            //   colors: [
                            //     Colors.pink.withOpacity(0.7),
                            //     Colors.purple.withOpacity(0.7),
                            //     Colors.blue.withOpacity(0.7),
                            //   ],
                            //   begin: Alignment.bottomLeft,
                            //   end: Alignment.topRight,
                            // ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: _userNameController,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "User Name",
                                    suffixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.purple,
                                    ),
                                    hintStyle: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                    border: const OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your user name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: _isObscure,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    suffixIconColor: Colors.purple,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                      icon: Icon(
                                        _isObscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[500],
                                    ),
                                    border: const OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                ElevatedButton(
                                  onPressed: _handleLogin,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.purple.withOpacity(0.8),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    minimumSize: Size(Get.width, 50),
                                  ),
                                  child: const Text(
                                    "Log In",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      wordSpacing: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.06,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Divider(
                                  color: Colors.white70,
                                  thickness: 1,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Text(
                                " Powered By ",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: Get.height * 0.015,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 4,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              const Expanded(
                                child: Divider(
                                  color: Colors.white70,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: Get.height * 0.1,
                              width: Get.width * 0.3,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Image.asset(
                                "assets/images/ims.png",
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              height: Get.height * 0.1,
                              width: Get.width * 0.3,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Image.asset(
                                "assets/images/dgs.png",
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final userName = _userNameController.text;
      final password = _passwordController.text;

      final LoginController loginController = Get.put(LoginController());
      loginController.isLoading(true);
      try {
        await loginController.login(userName, password);

        // Check if stalls list is not empty, indicating successful login
        if (loginController.allStalls.isNotEmpty) {
          // Get.snackbar(
          //   'Login Sucessfull',
          //   '',
          //   snackPosition: SnackPosition.TOP,
          //   duration: const Duration(seconds: 3),
          //   backgroundColor: Colors.green,
          //   colorText: Colors.white,
          // );
          Get.offNamed('/dashboard', arguments: {
            'user': loginController.currentUser.value,
          });
        } else {
          // If login fails, show error message and clear input fields
          Get.snackbar(
            'Login Failed',
            'Invalid username or password.',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );

          // Clear input fields
          _userNameController.clear();
          _passwordController.clear();
        }
      } catch (error) {
        // If login fails, show error message and clear input fields
        String errorMessage = 'An error occurred during login.';
        if (error is String) {
          errorMessage = error;
        }

        Get.snackbar(
          'Login Failed',
          errorMessage,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        // Clear input fields
        _userNameController.clear();
        _passwordController.clear();
      } finally {
        loginController.isLoading(false);
      }
    }
  }

  void saveLogin(String userName, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userName", userName);
    prefs.setString("password", password);
    prefs.setBool("loggedIn", true);
  }
}
