import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) imagePickedFnc;

  const UserImagePicker({this.imagePickedFnc});
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedImage = await ImagePicker.pickImage(
        source: source,
        imageQuality: 50,
        maxWidth: 200,
      );
      final pickedImageFile = File(pickedImage.path);

      setState(() {
        _pickedImage = pickedImageFile;
      });
      widget.imagePickedFnc(pickedImageFile);
    } catch (error) {
      // TODO
      // print(error);
    }
  }

  _selectImage() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pick Image From'),
        actions: <Widget>[
          TextButton(
            child: const Text('Gallery'),
            onPressed: () {
              _pickImage(ImageSource.gallery);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Camera'),
            onPressed: () {
              _pickImage(ImageSource.camera);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

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
          onPressed: _selectImage,
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
