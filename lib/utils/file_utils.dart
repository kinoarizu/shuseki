part of 'utils.dart';

File imageFileToUpload;
File letterFileToUpload;

Future<File> getImage() async {
  PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery);
  return File(image.path);
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);

  StorageReference reference = FirebaseStorage.instance.ref().child('images/' + fileName);
  StorageUploadTask task = reference.putFile(image);
  StorageTaskSnapshot snapshot = await task.onComplete;

  return await snapshot.ref.getDownloadURL();
}

Future<File> pickFile() async {
  FilePickerResult result = await FilePicker.platform.pickFiles(
    allowedExtensions: ['jpg', 'png', 'pdf', 'doc', 'txt'],
    type: FileType.custom,
  );

  return File(result.files.single.path);
}

Future<String> uploadFile(File letter) async {
  String fileName = basename(letter.path);

  StorageReference reference = FirebaseStorage.instance.ref().child('letters/' + fileName);
  StorageUploadTask task = reference.putFile(letter);
  StorageTaskSnapshot snapshot = await task.onComplete;

  return await snapshot.ref.getDownloadURL();
}