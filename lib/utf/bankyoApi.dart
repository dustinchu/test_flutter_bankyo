class Bankyo {
  Bankyo({
    this.homeListViewUrl,
    this.courseListViewUrl,
    this.playUrl,
  });

  final String homeListViewUrl;
  final String courseListViewUrl;
  final String playUrl;
}

final Bankyo bankyoResource = Bankyo(
    homeListViewUrl: 'http://192.168.1.173:5000/homes',
    courseListViewUrl: 'http://192.168.1.173:5000/id_items/',
    playUrl: 'https://translate.google.com/translate_tts?ie=UTF-8&tl=ja&client=tw-ob&q='


);