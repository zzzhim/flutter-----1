import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// 拍照APP开发
class PhotoApp extends StatefulWidget {
  const PhotoApp({Key? key}) : super(key: key);

  @override
  _PhotoAppState createState() => _PhotoAppState();
}

class _PhotoAppState extends State<PhotoApp> {
  List<XFile>? _images = [];

  Future getImage(bool isTakePhoto) async {
    Navigator.pop(context);
    final ImagePicker _picker = ImagePicker();

    var image = await _picker.pickImage(
        source: isTakePhoto ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      // _image = image;
      _images?.add(image!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('拍照APP'),
      ),
      body: Center(
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: _genImages(),
        ),
        // child: _image == null ? Text('No Image') : Image.file(_image as File),
        // child: _image?.path == null
        //     ? Text('No Image')
        //     : Image.file(File(_image!.path)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: '选择图片',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  void _pickImage() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 140,
              child: Column(
                children: <Widget>[
                  _item('拍照', true),
                  _item('从相册选择', false),
                ],
              ),
            ));
  }

  _item(String title, bool isTakePhoto) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(isTakePhoto ? Icons.camera_alt : Icons.photo_library),
        title: Text(title),
        onTap: () => getImage(isTakePhoto),
      ),
    );
  }

  _genImages() {
    return _images?.map((file) {
      print(file);
      return Stack(children: <Widget>[
        ClipRRect(
          // 圆角效果
          borderRadius: BorderRadius.circular(5),
          child: Image.file(
            File(file.path),
            width: 120,
            height: 90,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    _images?.remove(file);
                  });
                },
                child: ClipOval(
                  child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(color: Colors.black54),
                      child: Icon(Icons.close, size: 18, color: Colors.white)),
                )))
      ]);
    }).toList();
  }
}
