import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class Geo {
  final double? lat;
  final double? long;

  Geo(this.lat, this.long);

  factory Geo.parse(XmlElement element) {
    return Geo(
      double.tryParse(findElementOrNull(element, 'geo:lat')?.text ?? ''),
      double.tryParse(findElementOrNull(element, 'geo:long')?.text ?? ''),
    );
  }
}
