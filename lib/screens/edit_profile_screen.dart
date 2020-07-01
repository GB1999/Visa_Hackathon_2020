// import 'package:flutter/material.dart';

// class EditProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Card(
//       elevation: 4.0,
//       child: Container(
//         // size container depending on Authmode (signup or signin)
//         height:  600 ,
//         constraints:
//             BoxConstraints(minHeight: 320),
//         width: double.infinity,
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 (_authMode == AuthMode.Signup)
//                     ? ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Container(
//                           width: 160,
//                           height: 160,
//                           color: Colors.black38,
//                           child: (_image == null)
//                               ? IconButton(
//                                   icon: Icon(Icons.camera_alt),
//                                   // open file brower to select profile image from device
//                                   onPressed: () => _getProfileImage(),
//                                 )
//                               : Image.file(
//                                   _image,
//                                   fit: BoxFit.cover,
//                                 ),
//                         ),
//                       )
//                     : Text(
//                         'Welcome Back',
//                         style: Theme.of(context).textTheme.headline2,
//                       ),
//                 if (_authMode == AuthMode.Signup)
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'First Name'),
//                     //keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'Please enter a valid name';
//                       }
//                     },
//                     onSaved: (value) {
//                       _authData['first_name'] = value;
//                     },
//                   ),
//                 if (_authMode == AuthMode.Signup)
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Last Name'),
//                     //keyboardType: TextInputType.text,
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'Please enter a valid name';
//                       }
//                     },
//                     onSaved: (value) {
//                       _authData['last_name'] = value;
//                     },
//                   ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'E-Mail'),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value.isEmpty || !value.contains('@')) {
//                       return 'Invalid email!';
//                     }
//                   },
//                   onSaved: (value) {
//                     _authData['email'] = value;
//                   },
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Password'),
//                   obscureText: true,
//                   controller: _passwordController,
//                   validator: (value) {
//                     if (value.isEmpty || value.length < 5) {
//                       return 'Password is too short!';
//                     }
//                   },
//                   onSaved: (value) {
//                     _authData['password'] = value;
//                   },
//                 ),
//                 if (_authMode == AuthMode.Signup)
//                   TextFormField(
//                     enabled: _authMode == AuthMode.Signup,
//                     decoration: InputDecoration(labelText: 'Confirm Password'),
//                     obscureText: true,
//                     validator: _authMode == AuthMode.Signup
//                         ? (value) {
//                             if (value != _passwordController.text) {
//                               return 'Passwords do not match!';
//                             }
//                           }
//                         : null,
//                   ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 if (_isLoading)
//                   CircularProgressIndicator()
//                 else
//                   FlatButton(
//                     child:
//                         Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP', ),
//                     onPressed: _submit,
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
//                     color: Theme.of(context).primaryColorDark,
//                     textColor: Theme.of(context).primaryTextTheme.button.color,
//                   ),
//                 FlatButton(
//                   child: Text(
//                     '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                    
//                   ),
//                   onPressed: _switchAuthMode,
//                   padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
//                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   textColor: Theme.of(context).primaryColor,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );,)
//   }
// }