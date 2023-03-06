import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path; //for comnbinig and constructing path
import 'package:path_provider/path_provider.dart' as syspath; //accessing paths
import 'package:sqflite/sqflite.dart' as sql;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  const ImageInput({super.key, required this.onSelectImage});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  void _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera);
    //incase didn't take picture
    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile!.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName =
        path.basename(imageFile!.path); //directory of file as well as file name
    final savedImage =
        await File(imageFile!.path).copy('${appDir.path}/${fileName}');

    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
          ),
        )
      ],
    );
  }
}
