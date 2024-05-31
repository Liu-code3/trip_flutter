class SearchModel {
  ///搜索关键字 非接口返回
  String? keyword;

  int? code;
  List<SearchItem>? data;
  String? message;

  SearchModel({code, data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SearchItem>[];
      json['data'].forEach((v) {
        data!.add(SearchItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchItem {
  String? code;
  String? word;
  String? type;
  String? districtname;
  String? url;
  bool? isBigIcon;
  String? imageUrl;
  String? subImageUrl;
  String? sourceType;
  String? price;
  String? zonename;
  String? star;

  SearchItem(
      {code,
      word,
      type,
      districtname,
      url,
      isBigIcon,
      imageUrl,
      subImageUrl,
      sourceType,
      price,
      zonename,
      star});

  SearchItem.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    word = json['word'];
    type = json['type'];
    districtname = json['districtname'];
    url = json['url'];
    isBigIcon = json['isBigIcon'];
    imageUrl = json['imageUrl'];
    subImageUrl = json['subImageUrl'];
    sourceType = json['sourceType'];
    price = json['price'];
    zonename = json['zonename'];
    star = json['star'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['word'] = word;
    data['type'] = type;
    data['districtname'] = districtname;
    data['url'] = url;
    data['isBigIcon'] = isBigIcon;
    data['imageUrl'] = imageUrl;
    data['subImageUrl'] = subImageUrl;
    data['sourceType'] = sourceType;
    data['price'] = price;
    data['zonename'] = zonename;
    data['star'] = star;
    return data;
  }
}
