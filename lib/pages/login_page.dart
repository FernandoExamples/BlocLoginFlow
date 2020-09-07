import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_flow/blocs/login/login_bloc.dart';
import 'package:login_flow/repositories/login_repository.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<LoginBloc, LoginState>(
          builder: (context, state) => LoginForm(state),
          listener: (BuildContext context, LoginState state) {
            if (state is LoginErrorState)
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
          },
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final LoginState state;
  LoginForm(this.state);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController;
  TextEditingController passController;

  @override
  void initState() {
    emailController = TextEditingController();
    passController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'User',
              icon: Icon(Icons.alternate_email),
            ),
            controller: emailController,
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: 'Password',
              icon: Icon(
                Icons.lock,
              ),
            ),
            controller: passController,
          ),
          SizedBox(height: 10),
          if (widget.state is LoadLoginState)
            CircularProgressIndicator()
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //Login con Email
                RaisedButton(
                  child: Text('Login'),
                  onPressed: () => BlocProvider.of<LoginBloc>(context).add(
                    DoLoginEvent(EmailLogin(emailController.text, passController.text)),
                  ),
                ),

                //Login con facebook
                RaisedButton(
                  child: Text('Facebook Login'),
                  onPressed: () => BlocProvider.of<LoginBloc>(context).add(
                    DoLoginEvent(FacebookLogin()),
                  ),
                ),

                //Login con Google
                RaisedButton(
                  child: Text('Google Login'),
                  onPressed: () => BlocProvider.of<LoginBloc>(context).add(
                    DoLoginEvent(GoogleLogin()),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
