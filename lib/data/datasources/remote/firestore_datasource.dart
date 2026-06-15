import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/reciter_model.dart';

abstract interface class FirestoreDataSource {
  Future<ReciterModel> fetchReciter(String reciterId);
}

class FirestoreDataSourceImpl implements FirestoreDataSource {
  final FirebaseFirestore _firestore;

  FirestoreDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<ReciterModel> fetchReciter(String reciterId) async {
    final doc = await _firestore
        .collection('reciters')
        .doc(reciterId)
        .get();

    if (!doc.exists || doc.data() == null) {
      throw Exception('Reciter not found: $reciterId');
    }

    return ReciterModel.fromFirestore(doc.data()!);
  }
}
