import 'package:dart_rss/domain/dublin_core/dublin_core.dart';
import 'package:dart_rss/domain/geo/geo.dart';
import 'package:dart_rss/domain/media/media.dart';
import 'package:dart_rss/domain/rss_category.dart';
import 'package:dart_rss/domain/rss_content.dart';
import 'package:dart_rss/domain/rss_enclosure.dart';
import 'package:dart_rss/domain/rss_item_podcast_index.dart';
import 'package:dart_rss/domain/rss_source.dart';
import 'package:dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

import 'rss_item_itunes.dart';

class RssItem {
  final String? title;
  final String? description;
  final String? link;

  final List<RssCategory> categories;
  final String? guid;
  final String? pubDate;
  final String? author;
  final String? comments;
  final RssSource? source;
  final RssContent? content;
  final Media? media;
  final RssEnclosure? enclosure;
  final DublinCore? dc;
  final RssItemItunes? itunes;
  final RssItemPodcastIndex? podcastIndex;
  final Geo? geo;

  const RssItem({
    this.title,
    this.description,
    this.link,
    this.categories = const <RssCategory>[],
    this.guid,
    this.pubDate,
    this.author,
    this.comments,
    this.source,
    this.content,
    this.media,
    this.enclosure,
    this.dc,
    this.itunes,
    this.podcastIndex,
    this.geo,
  });

  factory RssItem.parse(XmlElement element) {
    return RssItem(
      title: findElementOrNull(element, 'title')?.text,
      description: findElementOrNull(element, 'description')?.text,
      link: findElementOrNull(element, 'link')?.text,
      categories: element
          .findElements('category')
          .map((element) => RssCategory.parse(element))
          .toList(),
      guid: findElementOrNull(element, 'guid')?.text,
      pubDate: findElementOrNull(element, 'pubDate')?.text,
      author: findElementOrNull(element, 'author')?.text,
      comments: findElementOrNull(element, 'comments')?.text,
      source: RssSource.parse(findElementOrNull(element, 'source')),
      content: RssContent.parse(findElementOrNull(element, 'content:encoded')),
      media: Media.parse(element),
      enclosure: RssEnclosure.parse(findElementOrNull(element, 'enclosure')),
      dc: DublinCore.parse(element),
      itunes: RssItemItunes.parse(element),
      podcastIndex: RssItemPodcastIndex.parse(element),
      geo: Geo.parse(element),
    );
  }
}
