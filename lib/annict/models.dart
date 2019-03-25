class AccessToken {
  final String accessToken;
  final String tokenType;
  final String scope;
  final int createdAt;

  AccessToken(this.accessToken, {this.tokenType, this.scope, this.createdAt});

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return new AccessToken(
      json['access_token'],
      tokenType: json['token_type'],
      scope: json['scope'],
      createdAt: json['created_at'],
    );
  }
}

class Work {
  final int id;
  final String title;
  final String titleKana;
  final String media;
  final String mediaText;
  final String seasonName;
  final String seasonNameText;
  final String releasedOn;
  final String releasedOnAbout;
  final String officialSiteUrl;
  final String wikipediaUrl;
  final String twitterUsername;
  final String twitterHashtag;
  final String syobocalTid;
  final String malAnimeId;
  final Images images;
  final int episodesCount;
  final int watchersCount;
  final int reviewsCount;
  final bool noEpisodes;
  final Status status;

  Work({
    this.id,
    this.title,
    this.titleKana,
    this.media,
    this.mediaText,
    this.seasonName,
    this.seasonNameText,
    this.releasedOn,
    this.releasedOnAbout,
    this.officialSiteUrl,
    this.wikipediaUrl,
    this.twitterUsername,
    this.twitterHashtag,
    this.syobocalTid,
    this.malAnimeId,
    this.images,
    this.episodesCount,
    this.watchersCount,
    this.reviewsCount,
    this.noEpisodes,
    this.status,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return new Work(
      id: json['id'],
      title: json['title'],
      titleKana: json['title_kana'],
      media: json['media'],
      mediaText: json['media_text'],
      seasonName: json['season_name'],
      seasonNameText: json['season_name_text'],
      releasedOn: json['released_on'],
      releasedOnAbout: json['released_on_about'],
      officialSiteUrl: json['official_site_url'],
      wikipediaUrl: json['wikipedia_url'],
      twitterUsername: json['twitter_username'],
      twitterHashtag: json['twitter_hashtag'],
      syobocalTid: json['syobocal_tid'],
      malAnimeId: json['mal_anime_id'],
      images: Images.fromJson(json['images']),
      watchersCount: json['watchers_count'],
      reviewsCount: json['reviews_count'],
      noEpisodes: json['no_episodes'],
      status: Status.fromJson(json['status']),
    );
  }
}

class Images {
  final Facebook facebook;
  final Twitter twitter;
  final recommendedUrl;

  Images({this.facebook, this.twitter, this.recommendedUrl});

  factory Images.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return new Images(
      facebook: Facebook.fromJson(json['facebook']),
      twitter: Twitter.fromJson(json['twitter']),
      recommendedUrl: json['recommended_url'],
    );
  }
}

class Facebook {
  final String obImageUrl;

  Facebook({this.obImageUrl});

  factory Facebook.fromJson(Map<String,dynamic> json) {
    if (json == null) {
      return null;
    }
    return new Facebook(
      obImageUrl: json['ob_image_url']
    );
  }
}

class Twitter {
  final String miniAvatarUrl;
  final String normalAvatarUrl;
  final String biggerAvatarUrl;
  final String originalAvatarUrl;

  Twitter({this.miniAvatarUrl, this.normalAvatarUrl,
      this.biggerAvatarUrl, this.originalAvatarUrl});

  factory Twitter.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return new Twitter(
      miniAvatarUrl: json['mini_avatar_url'],
      normalAvatarUrl: json['normal_avatar_url'],
      biggerAvatarUrl: json['bigger_avatar_url'],
      originalAvatarUrl: json['original_avatar_url'],
    );
  }
}

class Status {
  final String kind;

  Status({this.kind});

  factory Status.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return new Status(
      kind: json['kind'],
    );
  }
}

class Works {
  final List<Work> works;
  final int totalCount;
  final int nextPage;
  final int prevPage;

  Works({this.works, this.totalCount, this.nextPage, this.prevPage});

  factory Works.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    final works = (json['works'] as List)
        .map((work) => Work.fromJson(work)).toList();
    return new Works(
      works: works,
      totalCount: json['total_count'],
      nextPage: json['next_page'],
      prevPage: json['prev_page'],
    );
  }
}