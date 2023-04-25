import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/model/temple.dart';

class FirestoreService {
  final geo = GeoFlutterFire();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Singleton setup: prevents multiple instances of this class.
  FirestoreService._();
  static final FirestoreService _service = FirestoreService._();
  factory FirestoreService() => _service;

  static FirestoreService get instance => _service;

  Stream<List<Temple>> getTemples({int? limit}) {
    final CollectionReference collection =
        _firebaseFirestore.collection('temples');

    return collection
        .limit(limit ?? 10)
        .snapshots()
        .map<List<Temple>>((event) {
      return event.docs.map<Temple>(
        (snapshot) {
          final Map<String, dynamic> data =
              snapshot.data()! as Map<String, dynamic>;
          return Temple.fromJson(data);
        },
      ).toList();
    });
  }

  Stream<Temple> getTempleById(String id) {
    final Stream<DocumentSnapshot> snapshots =
        _firebaseFirestore.doc('temples/$id').snapshots();

    return snapshots.map(
      (DocumentSnapshot snapshot) {
        final Map<String, dynamic> data =
            snapshot.data()! as Map<String, dynamic>;

        data['id'] = snapshot.id;

        return Temple.fromJson(data);
      },
    );
  }

  Stream<List<Temple>> getTemplesByProvinceSlug(String slug) {
    final CollectionReference collection =
        _firebaseFirestore.collection('temples');

    return collection
        .where('province.slug', isEqualTo: slug)
        .snapshots()
        .map<List<Temple>>((event) {
      return event.docs.map<Temple>(
        (snapshot) {
          final Map<String, dynamic> data =
              snapshot.data()! as Map<String, dynamic>;
          return Temple.fromJson(data);
        },
      ).toList();
    });
  }

  Stream<List<Temple>> getNearbyTemple(double lat, double lng,
      {double? radius, int? limit}) {
    GeoFirePoint center = geo.point(latitude: lat, longitude: lng);
    var collection =
        _firebaseFirestore.collection('temples').limit(limit ?? 10);
    double _radius = radius ?? 10.0;
    String field = 'position';

    var stream = geo.collection(collectionRef: collection).within(
          center: center,
          radius: _radius,
          field: field,
          strictMode: true,
        );

    return stream.map<List<Temple>>((event) {
      return event.map<Temple>((snapshot) {
        final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
        return Temple.fromJson(data);
      }).toList();
    });
  }
}
