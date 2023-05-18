import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/

void main() {
  runApp(const MaterialApp(
    title: 'Log in / sign up',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Log in / Sign In'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
    // Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.




    class TextFieldDemo extends StatelessWidget {
    const TextFieldDemo({super.key});

    @override
    Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    automaticallyImplyLeading: false,
    title: Text(GalleryLocalizations.of(context)!.demoTextFieldTitle),
    ),
    body: const TextFormFieldDemo(),
    );
    }
    }

    class TextFormFieldDemo extends StatefulWidget {
    const TextFormFieldDemo({super.key});

    @override
    TextFormFieldDemoState createState() => TextFormFieldDemoState();
    }

    class PersonData {
    String? name = '';
    String? phoneNumber = '';
    String? email = '';
    String password = '';
    }

    class PasswordField extends StatefulWidget {
    const PasswordField({
    super.key,
    this.restorationId,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
    });

    final String? restorationId;
    final Key? fieldKey;
    final String? hintText;
    final String? labelText;
    final String? helperText;
    final FormFieldSetter<String>? onSaved;
    final FormFieldValidator<String>? validator;
    final ValueChanged<String>? onFieldSubmitted;
    final FocusNode? focusNode;
    final TextInputAction? textInputAction;

    @override
    State<PasswordField> createState() => _PasswordFieldState();
    }

    class _PasswordFieldState extends State<PasswordField> with RestorationMixin {
    final RestorableBool _obscureText = RestorableBool(true);

    @override
    String? get restorationId => widget.restorationId;

    @override
    void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_obscureText, 'obscure_text');
    }

    @override
    Widget build(BuildContext context) {
    return TextFormField(
    key: widget.fieldKey,
    restorationId: 'password_text_field',
    obscureText: _obscureText.value,
    maxLength: 8,
    onSaved: widget.onSaved,
    validator: widget.validator,
    onFieldSubmitted: widget.onFieldSubmitted,
    decoration: InputDecoration(
    filled: true,
    hintText: widget.hintText,
    labelText: widget.labelText,
    helperText: widget.helperText,
    suffixIcon: IconButton(
    onPressed: () {
    setState(() {
    _obscureText.value = !_obscureText.value;
    });
    },
    hoverColor: Colors.transparent,
    icon: Icon(
    _obscureText.value ? Icons.visibility : Icons.visibility_off,
    semanticLabel: _obscureText.value
    ? GalleryLocalizations.of(context)!
        .demoTextFieldShowPasswordLabel
        : GalleryLocalizations.of(context)!
        .demoTextFieldHidePasswordLabel,
    ),
    ),
    ),
    );
    }
    }

    class TextFormFieldDemoState extends State<TextFormFieldDemo>
    with RestorationMixin {
    PersonData person = PersonData();

    late FocusNode _phoneNumber, _email, _lifeStory, _password, _retypePassword;

    @override
    void initState() {
    super.initState();
    _phoneNumber = FocusNode();
    _email = FocusNode();
    _password = FocusNode();
    _retypePassword = FocusNode();
    }

    @override
    void dispose() {
    _phoneNumber.dispose();
    _email.dispose();
    _password.dispose();
    _retypePassword.dispose();
    super.dispose();
    }

    void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(value),
    ));
    }

    @override
    String get restorationId => 'text_field_demo';

    @override
    void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_autoValidateModeIndex, 'autovalidate_mode');
    }

    final RestorableInt _autoValidateModeIndex =
    RestorableInt(AutovalidateMode.disabled.index);

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final GlobalKey<FormFieldState<String>> _passwordFieldKey =
    GlobalKey<FormFieldState<String>>();
    final _UsNumberTextInputFormatter _phoneNumberFormatter =
    _UsNumberTextInputFormatter();

    void _handleSubmitted() {
    final form = _formKey.currentState!;
    if (!form.validate()) {
    _autoValidateModeIndex.value =
    AutovalidateMode.always.index; // Start validating on every change.
    showInSnackBar(
    GalleryLocalizations.of(context)!.demoTextFieldFormErrors,
    );
    } else {
    form.save();
    showInSnackBar(GalleryLocalizations.of(context)!
        .demoTextFieldNameHasPhoneNumber(person.name!, person.phoneNumber!));
    }
    }

    String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
    return GalleryLocalizations.of(context)!.demoTextFieldNameRequired;
    }
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
    return GalleryLocalizations.of(context)!
        .demoTextFieldOnlyAlphabeticalChars;
    }
    return null;
    }

    String? _validatePhoneNumber(String? value) {
    final phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value!)) {
    return GalleryLocalizations.of(context)!.demoTextFieldEnterUSPhoneNumber;
    }
    return null;
    }

    String? _validatePassword(String? value) {
    final passwordField = _passwordFieldKey.currentState!;
    if (passwordField.value == null || passwordField.value!.isEmpty) {
    return GalleryLocalizations.of(context)!.demoTextFieldEnterPassword;
    }
    if (passwordField.value != value) {
    return GalleryLocalizations.of(context)!.demoTextFieldPasswordsDoNotMatch;
    }
    return null;
    }

    @override
    Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);
    final localizations = GalleryLocalizations.of(context)!;

    return Form(
    key: _formKey,
    autovalidateMode: AutovalidateMode.values[_autoValidateModeIndex.value],
    child: Scrollbar(
    child: SingleChildScrollView(
    restorationId: 'text_field_demo_scroll_view',
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
    children: [
    sizedBoxSpace,
    TextFormField(
    restorationId: 'name_field',
    textInputAction: TextInputAction.next,
    textCapitalization: TextCapitalization.words,
    decoration: InputDecoration(
    filled: true,
    icon: const Icon(Icons.person),
    hintText: localizations.demoTextFieldWhatDoPeopleCallYou,
    labelText: localizations.demoTextFieldNameField,
    ),
    onSaved: (value) {
    person.name = value;
    _phoneNumber.requestFocus();
    },
    validator: _validateName,
    ),
    sizedBoxSpace,
    TextFormField(
    restorationId: 'phone_number_field',
    textInputAction: TextInputAction.next,
    focusNode: _phoneNumber,
    decoration: InputDecoration(
    filled: true,
    icon: const Icon(Icons.phone),
    hintText: localizations.demoTextFieldWhereCanWeReachYou,
    labelText: localizations.demoTextFieldPhoneNumber,
    prefixText: '+1 ',
    ),
    keyboardType: TextInputType.phone,
    onSaved: (value) {
    person.phoneNumber = value;
    _email.requestFocus();
    },
    maxLength: 14,
    maxLengthEnforcement: MaxLengthEnforcement.none,
    validator: _validatePhoneNumber,
    // TextInputFormatters are applied in sequence.
    inputFormatters: <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
    // Fit the validating format.
    _phoneNumberFormatter,
    ],
    ),
    sizedBoxSpace,
    TextFormField(
    restorationId: 'email_field',
    textInputAction: TextInputAction.next,
    focusNode: _email,
    decoration: InputDecoration(
    filled: true,
    icon: const Icon(Icons.email),
    hintText: localizations.demoTextFieldYourEmailAddress,
    labelText: localizations.demoTextFieldEmail,
    ),
    keyboardType: TextInputType.emailAddress,
    onSaved: (value) {
    person.email = value;

    },

    sizedBoxSpace,

    maxLines: 3,
    ),
    sizedBoxSpace,
    TextFormField(
    restorationId: 'salary_field',
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
    border: const OutlineInputBorder(),
    labelText: localizations.demoTextFieldSalary,
    suffixText: localizations.demoTextFieldUSD,
    ),
    maxLines: 1,
    ),
    sizedBoxSpace,
    PasswordField(
    restorationId: 'password_field',
    textInputAction: TextInputAction.next,
    focusNode: _password,
    fieldKey: _passwordFieldKey,
    helperText: localizations.demoTextFieldNoMoreThan,
    labelText: localizations.demoTextFieldPassword,
    onFieldSubmitted: (value) {
    setState(() {
    person.password = value;
    _retypePassword.requestFocus();
    });
    },
    ),
    sizedBoxSpace,
    TextFormField(
    restorationId: 'retype_password_field',
    focusNode: _retypePassword,
    decoration: InputDecoration(
    filled: true,
    labelText: localizations.demoTextFieldRetypePassword,
    ),
    maxLength: 8,
    obscureText: true,
    validator: _validatePassword,
    onFieldSubmitted: (value) {
    _handleSubmitted();
    },
    ),
    sizedBoxSpace,
    Center(
    child: ElevatedButton(
    onPressed: _handleSubmitted,
    child: Text(localizations.demoTextFieldSubmit),
    ),
    ),
    sizedBoxSpace,
    Text(
    localizations.demoTextFieldRequiredField,
    style: Theme.of(context).textTheme.bodySmall,
    ),
    sizedBoxSpace,
    ],
    ),
    ),
    ),
    );
    }
    }

    /// Format incoming numeric text to fit the format of (###) ###-#### ##
    class _UsNumberTextInputFormatter extends TextInputFormatter {
    @override
    TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
    ) {
    final newTextLength = newValue.text.length;
    final newText = StringBuffer();
    var selectionIndex = newValue.selection.end;
    var usedSubstringIndex = 0;
    if (newTextLength >= 1) {
    newText.write('(');
    if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 4) {
    newText.write('${newValue.text.substring(0, usedSubstringIndex = 3)}) ');
    if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
    newText.write('${newValue.text.substring(3, usedSubstringIndex = 6)}-');
    if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 11) {
    newText.write('${newValue.text.substring(6, usedSubstringIndex = 10)} ');
    if (newValue.selection.end >= 10) selectionIndex++;
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
    newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
    text: newText.toString(),
    selection: TextSelection.collapsed(offset: selectionIndex),
    );
    }
    }


  }
}