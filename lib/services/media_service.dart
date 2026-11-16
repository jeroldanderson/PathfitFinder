import 'package:image_picker/image_picker.dart';

class MediaService {
  MediaService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();
  final ImagePicker _picker;
  Future<XFile?> pick({bool camera = false}) => _picker.pickImage(
    source: camera ? ImageSource.camera : ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
    imageQuality: 85,
  );
}
