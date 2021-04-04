import 'dart:typed_data';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

class ImgUI extends StatelessWidget {
  String imgUrl;
  var id;
  ImgUI(this.imgUrl, this.id) : super();

  _save() async {
    if (await Permission.storage.request().isGranted) {
      var response = await Dio()
          .get(imgUrl, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: id.toString());
      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
          tag: id,
          child: GestureDetector(
              onLongPress: () {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Save Image'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('Would you like to downlowad image'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Exite'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                            child: Text('Download'),
                            onPressed: () async {
                              Toast.show("image started downloading ", context,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.BOTTOM);

                              await _save();
                              Navigator.of(context).pop();
                              Toast.show("image successful downloaded", context,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            }),
                      ],
                    );
                  },
                );
              },
              child: Image.network(imgUrl))),
    );
  }
}
