import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constant/constants.dart';
import 'Utils/utils.dart';


class CustomImagePickerScreen extends StatefulWidget {
  final bool showImagePicker;
  const CustomImagePickerScreen({Key? key,this.showImagePicker = true}) : super(key: key);

  @override
  _CameraPickerScreenState createState() => _CameraPickerScreenState();
}

class _CameraPickerScreenState extends State<CustomImagePickerScreen> with WidgetsBindingObserver {

  List<CameraDescription> _cameras = [];
  XFile? pickedImage;
  CameraController ?cameraController;
  bool isCameraInitializing = true;
  bool isTorchOn=false;
  @override
  void initState() {
    super.initState();
    try {
      availableCameras().then((value){
        _cameras = value;
        if(_cameras.isNotEmpty){
          cameraController = CameraController(
            _cameras[0],
            kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
            enableAudio: false,
            imageFormatGroup: ImageFormatGroup.jpeg,
          );
          cameraController!.initialize().then((_) {
            if (!mounted) {
              return;
            }
            cameraController!.setFlashMode(FlashMode.off);
            isCameraInitializing = false;
            setState(() {});
          });
        }else{
          setState(() {
            isCameraInitializing = false;
          });
        }
      });
    } on CameraException catch (e) {
      if (kDebugMode) {
        print(e.code + '\n' + (e.description??''));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()async{
        onBackButtonPressed();
        return false;
      },
      child: SafeArea(
          top: true,
          bottom: true,
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                  onPressed: onBackButtonPressed,
                  icon: const Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                pickedImage==null? "Image Picker":"Picked Image",
                style: const TextStyle(color: Colors.white, fontSize: AppConstant.SIZE_TITLE16, fontFamily: 'Poppins',),
              ),
              actions: [

                /// Image Cropper
                pickedImage!=null
                    ? GestureDetector(
                  onTap: ()async{
                    cropImage(imageToBeCroppedPath: pickedImage!.path).then((croppedImage){
                      if(croppedImage!=null){
                        pickedImage = croppedImage;
                        setState(() {});
                      }
                    });
                  },
                  child:Icon(
                    Icons.crop,
                    size: 30,
                    color: Colors.white,
                  ),
                )
                    : const SizedBox(),
                SizedBox(width:pickedImage==null?0:10,),
                /// Image picker done
                pickedImage==null
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: (){
                          Navigator.pop(context,{"pickedImage": File(pickedImage!.path)});
                        },
                        child: Icon(
                          Icons.send,
                          size: 30,
                          color: Colors.white,
                        ),
                ),
                SizedBox(width:pickedImage==null?0:5,),
                pickedImage==null
                ?IconButton(
                  onPressed: (){
                    isTorchOn=!isTorchOn;
                    if(isTorchOn){
                    cameraController!.setFlashMode(FlashMode.torch);
                    } else{
                    cameraController!.setFlashMode(FlashMode.off);
                    }
                    setState(() { });
                  },
                  icon: isTorchOn
                  ?const Icon(Icons.flashlight_on,color: Colors.white)
                  :const Icon(Icons.flashlight_off_outlined,color: Colors.white),
                )
                :const SizedBox(),
              ],
            ),
            body: Container(
              constraints: pickedImage==null?BoxConstraints.tight(deviceSize):null,
              alignment: Alignment.center,
              child: _cameras.isEmpty?
                  const Text(
                "Camera is not available on this device",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                   fontSize: AppConstant.SIZE_TITLE16,
                   fontFamily: 'Poppins',

                ),
              )
                  : pickedImage==null
                    ? _cameraPickerView(deviceSize)
                    : _pickedImageView(deviceSize),
            ),
          ),
      ),
    );
  }

  Widget _cameraPickerView(Size deviceSize){
    return Column(
      children: [
        (cameraController?.value.isInitialized??false)
            ? Expanded(
              child: AspectRatio(
                  // aspectRatio: isTabletLayout(context)?0.72:0.67,
                  aspectRatio: 16/9,
                  child:CameraPreview(cameraController!),
              ),
            )
            : const SizedBox(),
        (cameraController?.value.isInitialized??false)
            ? const SizedBox()
            : Expanded(
          child: Container(
            color: Colors.black,
            alignment: Alignment.center,
            child: Text(
              isCameraInitializing?"Initializing Camera":"Camera is not initialized",
              style: const TextStyle(
                color: Colors.white,
                fontSize: AppConstant.SIZE_TITLE16,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
        const SizedBox(height: 5,),
        /// Camera Controls
        SizedBox(
            width: deviceSize.width,
            child: _buildCameraControls()),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Tap for photo',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget _pickedImageView(Size deviceSize){
    return FittedBox(
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        color: Colors.black
      ),
      child: Image.file(
        File(pickedImage!.path),
        // fit: BoxFit.contain,
      ),
    ),
    );
  }

  Widget _buildCameraControls() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        widget.showImagePicker
            ? IconButton(
          icon: const Icon(Icons.photo_library),
          color: Colors.white,
          onPressed: () async{
            isTorchOn=false;
            cameraController!.setFlashMode(FlashMode.off);
            pickedImage = await pickGalleryImage(context: context);
            setState(() {});
          }
        )
            :const IconButton(
            icon: Icon(null),
            color: Colors.transparent,
            onPressed: null
        ),

        GestureDetector(
            child: const SizedBox(
              height: 70,
              width: 70,
              child: CircularProgressIndicator(
                value: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            onTap: ()async{
              pickedImage = await pickCameraImage(context: context,cameraController: cameraController);
              isTorchOn=false;
              cameraController!.setFlashMode(FlashMode.off);
              setState(() {});
            },
        ),
        const IconButton(
            icon: Icon(null),
            color: Colors.transparent,
            onPressed: null
        ),
      ],
    );
  }

  void Function()? onBackButtonPressed(){

    if(pickedImage==null){
      Navigator.pop(context);
    }else{
      pickedImage = null;
      setState(() {});
    }
    return null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (cameraController == null || !(cameraController?.value.isInitialized??false)) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (cameraController != null) {
        onNewCameraSelected(cameraController!.description);
      }
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController?.dispose();
    }

    cameraController = CameraController(
      _cameras[0],
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    cameraController = cameraController;

    // If the controller is updated then update the UI.
    cameraController?.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if ((cameraController?.value.hasError??true)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${cameraController?.value.errorDescription??"Camera not initialized"}')));
      }
    });

    try {
      await cameraController?.initialize();
    } on CameraException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.description}')));
    }

    if (mounted) {
      setState(() {});
    }
  }

}
