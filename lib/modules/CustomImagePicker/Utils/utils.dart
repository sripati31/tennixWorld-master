import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../utils/toast.dart';

Future<XFile?> pickGalleryImage({required BuildContext context})async{
  bool isPermissionsGranted = await Permission.photos.isGranted;
  XFile ?pickedImage;
  if(isPermissionsGranted){
    await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70,preferredCameraDevice: CameraDevice.rear).then((value) {
      if(value!=null){
        pickedImage = value;
      }
    });
  }else{
    isPermissionsGranted = await requestPermission(requiredPermissions: [Permission.photos], context: context);
    pickedImage = await pickGalleryImage(context: context);
  }
  return pickedImage;
}
Future<XFile?> pickCameraImage({required CameraController ?cameraController, required BuildContext context})async{
  bool isPermissionsGranted = await Permission.camera.isGranted;
  XFile ?capturedImage;
  if(isPermissionsGranted){
    if(cameraController?.value.isInitialized??false){
      if (!(cameraController!.value.isTakingPicture)) {
        try {

          await cameraController.takePicture().then((XFile file) {
            capturedImage = file;
          });
        } on CameraException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.description}')));
        }
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error: Camera is not initialized')));
    }
  }else{
    isPermissionsGranted = await requestPermission(requiredPermissions: [Permission.camera], context: context);
    capturedImage = await pickCameraImage(cameraController: cameraController,context: context);
  }
  return capturedImage;
}

Future<bool> requestPermission({required List<Permission> requiredPermissions,required BuildContext context}) async {
  Map<Permission, PermissionStatus> statuses =
  await requiredPermissions.request();
  if (statuses.values.every((status) => status == PermissionStatus.granted)) {
    return true;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Permission not granted'),
        action: SnackBarAction(label: "Open Settings",onPressed: ()async{
          await openAppSettings();
        },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
    return false;
  }
}
Future<XFile?> cropImage({required String imageToBeCroppedPath}) async {
  XFile? croppedImageFile;
  try {
      File? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageToBeCroppedPath,
      );
      if(croppedFile!=null){
        croppedImageFile = XFile(croppedFile.path);
      }
    } on PlatformException catch (e) {
      debugPrint('Cropper Exception: $e');
      CustomToast.showToast(message: "Cropper Exception: $e");
    }
  return croppedImageFile;
}