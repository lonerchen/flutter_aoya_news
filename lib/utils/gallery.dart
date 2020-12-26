
//相册工具，保存图片到相册
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_cropper/image_cropper.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class GalleryUtils{

  ///
  /// 生成图片
  /// 注：传入的key必须嵌套在RepaintBoundary组件下，详情请看插件image_gallery_saver: ^1.2.2
  ///
  Future<Uint8List> capturePng(GlobalKey repaintKey) async{
    try {
      RenderRepaintBoundary boundary = repaintKey.currentContext
          .findRenderObject();
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      return pngBytes;
    }catch(e){
      print(e);
    }
    return null;
  }


  ///
  /// 直接保存Base64图片
  ///
  ///
  /// 判断有没有相册权限
  ///
  Future<bool> requestPermission() async{
    Map<PermissionGroup,PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.camera,PermissionGroup.photos,PermissionGroup.storage]);
    if(PermissionGroup.camera.value == PermissionStatus.denied){
      showToast("未开启相机权限");
      return false;
    }
    if(permissions[PermissionGroup.photos].value == PermissionStatus.denied){
      showToast("未开启照片访问权限");
      return false;
    }
    if(permissions[PermissionGroup.storage].value == PermissionStatus.denied){
      showToast("未开启存储权限");
      return false;
    }
    return true;
  }

  ///
  /// 保存Widget生成的图片
  /// 注：传入的key必须嵌套在RepaintBoundary组件下，详情请看插件image_gallery_saver: ^1.2.2
  ///
  saveImageForWidget(GlobalKey repaintKey)async{
    //生成图片
    final pngBytes = await capturePng(repaintKey);
    if(pngBytes == null){
      showToast("保存失败，图片生成失败");
      return;
    }
    //判断有没有相册权限
    bool permission = await requestPermission();
    if(!permission){
      showToast("保存失败，未获取到权限");
      return;
    }
    //保存图片
     final result = await ImageGallerySaver.saveImage(pngBytes.buffer.asUint8List());
    print("图片保存成功:$result");
    if(result != null){
      showToast("保存成功");
    }else{
      showToast("保存失败");
    }
  }

  ///
  ///  保存base64的图片
  ///
  saveImageForBase64(Uint8List imgs)async{
    //生成图片
    if(imgs == null||imgs.length == 0){
      showToast("生成图片失败！");
      return;
    }
    //判断有没有相册权限
    bool permission = await requestPermission();
    if(!permission){

      showToast("权限请求失败！");
      return;
    }
    //保存图片
    final result = await ImageGallerySaver.saveImage(imgs);
    print("图片保存成功:$result");
    if(result != null){
      showToast("保存成功");
    }else{
      showToast("保存成功");
    }
  }

  ///
  /// 拍照弹窗
  ///
  ///
  /// 选择照片
  /// needCrop 是否需要裁剪
  /// compressQuality 压缩率
  ///
  Future<File> showPhotoSelect(BuildContext context,{bool needCrop = true,int compressQuality = 50})async{
    File file ;
    file = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => _selectPhotoDialog(context),
    );
    if(file != null){
      //需要裁剪
      if(needCrop) {
        File croppedFile = await ImageCropper.cropImage(
            sourcePath: file.path,
            compressQuality: compressQuality,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
            androidUiSettings: AndroidUiSettings(
              toolbarTitle: '裁剪',
              toolbarColor: Theme
                  .of(context)
                  .scaffoldBackgroundColor,
              toolbarWidgetColor: Colors.black87,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
              hideBottomControls: true,
            ),
            iosUiSettings: IOSUiSettings(
              title: "裁剪",
              doneButtonTitle: "完成",
              cancelButtonTitle: "取消",
              rotateClockwiseButtonHidden: true,
              rotateButtonsHidden: true,
              resetButtonHidden: true,
              aspectRatioPickerButtonHidden: true,
              aspectRatioLockDimensionSwapEnabled: true,
              rectWidth: 200,
              rectHeight: 200,
            )
        );
        return croppedFile;
      }else{
        return file;
      }
    }
    return file;
  }

  ///
  /// 照片弹窗布局
  ///
  // 底部弹出菜单actionSheet
  Widget _selectPhotoDialog(BuildContext context) {
    return new CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text(
            '打开相机拍照',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'PingFangRegular',
            ),
          ),
          onPressed: () {
            //打开相机，选取照片
            ImagePicker.pickImage(source: ImageSource.camera).then((path){
              Navigator.of(context).pop(path);
            });
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            '打开相册，选取照片',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'PingFangRegular',
            ),
          ),
          onPressed: () {
            // 打开相册，选取照片
            ImagePicker.pickImage(source: ImageSource.gallery).then((path){
              Navigator.of(context).pop(path);
            });
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: new Text(
          '取消',
          style: TextStyle(
            fontSize: 13.0,
            fontFamily: 'PingFangRegular',
            color: const Color(0xFF666666),
          ),
        ),
        onPressed: () {
          // 关闭菜单
          Navigator.of(context).pop();
        },
      ),
    );
  }


}