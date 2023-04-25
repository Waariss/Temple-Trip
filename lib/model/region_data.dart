import 'package:project/model/province.dart';
import 'package:project/model/region.dart';

List<Region> regions = [
  Region(slug: 'central', name: 'Central', provinces: [
    Province(slug: 'krung-thep-maha-nakhon-bangkok',name: 'Krung Thep Maha Nakhon (Bangkok)'),
    Province(slug: 'nakhon-pathom', name: 'Nakhon Pathom'),
    Province(slug: 'nonthaburi', name: 'Nonthaburi'),
    Province(slug: 'pathum-thani', name: 'Pathum Thani'),
    Province(
        slug: 'phra-nakhon-si-ayutthaya', name: 'Phra Nakhon Si Ayutthaya'),
    Province(slug: 'samut-prakan', name: 'Samut Prakan'),
    Province(slug: 'samut-sakhon', name: 'Samut Sakhon'),
    Province(slug: 'saraburi', name: 'Saraburi'),
    Province(slug: 'suphan-buri', name: 'Suphan Buri'),
  ]),
  Region(slug: 'north-eastern', name: 'North Eastern', provinces: [
    Province(slug: 'kalasin', name: 'Kalasin'),
    Province(slug: 'khon-kaen', name: 'Khon Kaen'),
    Province(slug: 'buri-ram', name: 'Buri Ram'),
    Province(slug: 'roi-et', name: 'Roi Et'),
    Province(slug: 'sakon-nakhon', name: 'Sakon Nakhon'),
    Province(slug: 'nong-khai', name: 'Nong Khai'),
    Province(slug: 'udon-thani', name: 'Udon Thani'),
    Province(slug: 'ubon-ratchathani', name: 'Ubon Ratchathani'),
    Province(slug: 'loei', name: 'Loei'),
  ]),
  Region(slug: 'northern', name: 'Northern', provinces: [
    Province(slug: 'nakhon-sawan', name: 'Nakhon Sawan'),
    Province(slug: 'phayao', name: 'Phayao'),
    Province(slug: 'phichit', name: 'Phichit'),
    Province(slug: 'phitsanulok', name: 'Phitsanulok'),
    Province(slug: 'lamphun', name: 'Lamphun'),
    Province(slug: 'uttaradit', name: 'Uttaradit'),
    Province(slug: 'chiang-rai', name: 'Chiang Rai'),
    Province(slug: 'chiang-mai', name: 'Chiang Mai'),
    Province(slug: 'phetchabun', name: 'Phetchabun'),
    Province(slug: 'phrae', name: 'Phrae'),
  ]),
  Region(slug: 'southern', name: 'Southern', provinces: [
    Province(slug: 'chumphon', name: 'Chumphon'),
    Province(slug: 'trang', name: 'Trang'),
    Province(slug: 'nakhon-si-thammarat', name: 'Nakhon Si Thammarat'),
    Province(slug: 'pattani', name: 'Pattani'),
    Province(slug: 'phuket', name: 'Phuket'),
    Province(slug: 'yala', name: 'Yala'),
    Province(slug: 'songkhla', name: 'Songkhla'),
  ]),
];
