void _login() {
  String email = _emailController.text;
  String password = _passwordController.text;

  // Perform login validation and logic here
  // You can integrate with authentication services or check credentials locally

  if (email.isNotEmpty && password.isNotEmpty) {
    // Navigate to the main screen or dashboard
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text('Please enter both email and password.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
