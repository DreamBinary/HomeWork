import 'package:db_show/net/api.dart';
import 'package:db_show/toast.dart';
import 'package:flutter/material.dart';

class EnterView extends StatefulWidget {
  final Function(String) onLogin;

  const EnterView({required this.onLogin, super.key});

  @override
  State<EnterView> createState() => _EnterViewState();
}

class _EnterViewState extends State<EnterView> {
  var isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.constrainWidth() * 0.25;
            final height = constraints.constrainHeight() * 0.45;
            return Material(
              elevation: 10,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              clipBehavior: Clip.antiAlias,
              color: Colors.purple[100],
              child: Container(
                height: height,
                width: width,
                margin: const EdgeInsets.all(50),
                child: isLogin
                    ? LoginView(
                        onLogin: widget.onLogin,
                        onTapTitle: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                      )
                    : ChangeView(
                        onTapTitle: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChangeView extends StatefulWidget {
  final GestureTapCallback onTapTitle;

  const ChangeView({required this.onTapTitle, super.key});

  @override
  State<ChangeView> createState() => _ChangeViewState();
}

class _ChangeViewState extends State<ChangeView> {
  final _usernameCtrl = TextEditingController();
  final _oldPasswordCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        GestureDetector(
          onTap: widget.onTapTitle,
          child: const Text(
            "CHANGE",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _usernameCtrl,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            labelText: "username",
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _oldPasswordCtrl,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            labelText: "password",
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _newPasswordCtrl,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            labelText: "new password (modify)",
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                var result = await Api.changePsw(
                  _usernameCtrl.text,
                  _oldPasswordCtrl.text,
                  _newPasswordCtrl.text,
                );
                if (result != null) {
                  toast(result);
                }
              },
              child: const Text("Modify"),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () async {
                var result =
                    await Api.logout(_usernameCtrl.text, _oldPasswordCtrl.text);
                if (result != null) {
                  toast(result);
                }
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ],
    );
  }
}

class LoginView extends StatefulWidget {
  final Function(String) onLogin;
  final GestureTapCallback onTapTitle;

  const LoginView({required this.onLogin, required this.onTapTitle, super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        GestureDetector(
          onTap: widget.onTapTitle,
          child: const Text(
            "LOGIN",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _usernameCtrl,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            labelText: "username",
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _passwordCtrl,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            labelText: "password",
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                var result = await Api.login(
                  _usernameCtrl.text,
                  _passwordCtrl.text,
                );
                if (result != null) {
                  toast(result);
                }
                if (result == "登录成功") {
                  widget.onLogin(_usernameCtrl.text);
                }
              },
              child: const Text("Login"),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () async {
                var result =
                    await Api.register(_usernameCtrl.text, _passwordCtrl.text);
                if (result != null) {
                  toast(result);
                }
                if (result == "注册成功") {
                  widget.onLogin(_usernameCtrl.text);
                }
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ],
    );
  }
}
