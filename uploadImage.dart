import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

Future<String> uploadImage(BuildContext context, String base64Image) async {
  // Remove data:image/jpeg;base64, prefix if it exists
  if (base64Image.contains(',')) {
    base64Image = base64Image.split(',').last;
  }

  // Decode the base64 string
  Uint8List decodedBytes = base64.decode(base64Image);

  // Generate a unique file name from the time
  String fileName =
      'images/' + DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';

  // Create a Firebase Storage reference
  final firebase_storage.Reference storageRef =
      firebase_storage.FirebaseStorage.instance.ref().child(fileName);

  // Upload the image
  final firebase_storage.UploadTask uploadTask =
      storageRef.putData(decodedBytes);

  // Wait for the upload to complete
  await uploadTask.whenComplete(() => null);

  // Get the image URL
  final String imageUrl = await storageRef.getDownloadURL();

  // Return the image URL
  return imageUrl;
}
