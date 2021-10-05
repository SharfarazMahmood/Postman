import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    // ImagePicker.pickImage();
    // final ImageSource source = await _selectOption();
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  // Future<ImageSource> _selectOption() async {
  //   ImageSource selectedOption;
  //    await showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: const Text('Pick Image From'),
  //       actions: <Widget>[
  //         TextButton(
  //           child: const Text('Gallery'),
  //           onPressed: () {
  //             selectedOption = ImageSource.gallery;
  //           },
  //         ),
  //         TextButton(
  //           child: const Text('Camera'),
  //           onPressed: () {
  //             selectedOption = ImageSource.camera;
  //           },
  //         )
  //       ],
  //     ),
  //   );
  //
  //   return selectedOption;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 55,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
