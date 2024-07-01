import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modeles/User.dart';
import '../providers/AuthProvider.dart';


class SignupScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final user = User(
                    id: 0, // This will be set by the backend
                    username: _usernameController.text,
                    email: _emailController.text,
                    name: _nameController.text,
                    age: int.parse(_ageController.text),
                    city: _cityController.text,
                   // Add interests field if necessary
                    rating: 0.0, // Default rating
                  );
                  await Provider.of<AuthProvider>(context, listen: false).register(user);
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}