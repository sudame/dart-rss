import 'package:dart_rss/domain/atom_category.dart';
import 'package:dart_rss/domain/atom_link.dart';
import 'package:dart_rss/domain/atom_person.dart';
import 'package:dart_rss/domain/atom_source.dart';
import 'package:dart_rss/domain/geo/geo.dart';
import 'package:dart_rss/domain/media/media.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class AtomItem {
  final String? id;
  final String? title;
  final String? updated;

  final List<AtomPerson> authors;
  final List<AtomLink> links;
  final List<AtomCategory> categories;
  final List<AtomPerson> contributors;
  final AtomSource? source;
  final String? published;
  final String? content;
  final String? summary;
  final String? rights;
  final Media? media;
  final Geo? geo;

  const AtomItem({
    this.id,
    this.title,
    this.updated,
    this.authors = const <AtomPerson>[],
    this.links = const <AtomLink>[],
    this.categories = const <AtomCategory>[],
    this.contributors = const <AtomPerson>[],
    this.source,
    this.published,
    this.content,
    this.summary,
    this.rights,
    this.media,
    this.geo,
  });

  factory AtomItem.parse(XmlElement element) {
    return AtomItem(
      id: findElementOrNull(element, 'id')?.text,
      title: findElementOrNull(element, 'title')?.text,
      updated: findElementOrNull(element, 'updated')?.text,
      authors: element
          .findElements('author')
          .map((element) => AtomPerson.parse(element))
          .toList(),
      links: element
          .findElements('link')
          .map((element) => AtomLink.parse(element))
          .toList(),
      categories: element
          .findElements('category')
          .map((element) => AtomCategory.parse(element))
          .toList(),
      contributors: element
          .findElements('contributor')
          .map((element) => AtomPerson.parse(element))
          .toList(),
      source: AtomSource.parse(findElementOrNull(element, 'source')),
      published: findElementOrNull(element, 'published')?.text,
      content: findElementOrNull(element, 'content')?.text,
      summary: findElementOrNull(element, 'summary')?.text,
      rights: findElementOrNull(element, 'rights')?.text,
      media: Media.parse(element),
      geo: Geo.parse(element),
    );
  }
}
