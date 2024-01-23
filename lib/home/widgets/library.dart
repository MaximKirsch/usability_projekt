import 'dart:convert';

Library libraryFromJson(String str) => Library.fromJson(json.decode(str));

String libraryToJson(Library data) => json.encode(data.toJson());

class Library {
  Library({
    List<Items>? items,
  }) {
    _items = items;
  }

  Library.fromJson(dynamic json) {
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
  }

  List<Items>? _items;

  Library copyWith({
    List<Items>? items,
  }) =>
      Library(
        items: items ?? _items,
      );

  List<Items>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));

String itemsToJson(Items data) => json.encode(data.toJson());

class Items {
  Items({
    int? id,
    String? titel,
    String? orginaltitel,
    String? autor,
    String? verlagsort,
    String? jahr,
    String? anmerkung,
    String? isbn,
    String? ean,
    double? preis,
    String? interessenkreis,
    String? beschreibung,
    String? link,
    List<Kopien>? kopien,
    int? umfang,
    String? cover,
    String? untertitel,
    String? type,
  }) {
    _id = id;
    _titel = titel;
    _orginaltitel = orginaltitel;
    _autor = autor;
    _verlagsort = verlagsort;
    _jahr = jahr;
    _anmerkung = anmerkung;
    _isbn = isbn;
    _ean = ean;
    _preis = preis;
    _interessenkreis = interessenkreis;
    _beschreibung = beschreibung;
    _link = link;
    _kopien = kopien;
    _umfang = umfang;
    _cover = cover;
    _untertitel = untertitel;
    _type = type;
  }

  Items.fromJson(dynamic json) {
    _id = json['id'];
    _titel = json['titel'];
    _orginaltitel = json['orginaltitel'];
    _autor = json['autor'];
    _verlagsort = json['verlagsort'];
    _jahr = json['jahr'];
    _anmerkung = json['Anmerkung'];
    _isbn = json['isbn'];
    _ean = json['ean'];
    _preis = json['preis'];
    _interessenkreis = json['interessenkreis'];
    _beschreibung = json['beschreibung'];
    _link = json['link'];
    if (json['kopien'] != null) {
      _kopien = [];
      json['kopien'].forEach((v) {
        _kopien?.add(Kopien.fromJson(v));
      });
    }
    _umfang = json['umfang'];
    _cover = json['cover'];
    _untertitel = json['untertitel'];
    _type = json['type'];
  }

  int? _id;
  String? _titel;
  String? _orginaltitel;
  String? _autor;
  String? _verlagsort;
  String? _jahr;
  String? _anmerkung;
  String? _isbn;
  String? _ean;
  double? _preis;
  String? _interessenkreis;
  String? _beschreibung;
  String? _link;
  List<Kopien>? _kopien;
  int? _umfang;
  String? _cover;
  String? _untertitel;
  String? _type;

  Items copyWith({
    int? id,
    String? titel,
    String? orginaltitel,
    String? autor,
    String? verlagsort,
    String? jahr,
    String? anmerkung,
    String? isbn,
    String? ean,
    double? preis,
    String? interessenkreis,
    String? beschreibung,
    String? link,
    List<Kopien>? kopien,
    int? umfang,
    String? cover,
    String? untertitel,
    String? type,
  }) =>
      Items(
        id: id ?? _id,
        titel: titel ?? _titel,
        orginaltitel: orginaltitel ?? _orginaltitel,
        autor: autor ?? _autor,
        verlagsort: verlagsort ?? _verlagsort,
        jahr: jahr ?? _jahr,
        anmerkung: anmerkung ?? _anmerkung,
        isbn: isbn ?? _isbn,
        ean: ean ?? _ean,
        preis: preis ?? _preis,
        interessenkreis: interessenkreis ?? _interessenkreis,
        beschreibung: beschreibung ?? _beschreibung,
        link: link ?? _link,
        kopien: kopien ?? _kopien,
        umfang: umfang ?? _umfang,
        cover: cover ?? _cover,
        untertitel: untertitel ?? _untertitel,
        type: type ?? _type,
      );

  int? get id => _id;

  String? get titel => _titel;

  String? get orginaltitel => _orginaltitel;

  String? get autor => _autor;

  String? get verlagsort => _verlagsort;

  String? get jahr => _jahr;

  String? get anmerkung => _anmerkung;

  String? get isbn => _isbn;

  String? get ean => _ean;

  double? get preis => _preis;

  String? get interessenkreis => _interessenkreis;

  String? get beschreibung => _beschreibung;

  String? get link => _link;

  List<Kopien>? get kopien => _kopien;

  int? get umfang => _umfang;

  String? get cover => _cover;

  String? get untertitel => _untertitel;

  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['titel'] = _titel;
    map['orginaltitel'] = _orginaltitel;
    map['autor'] = _autor;
    map['verlagsort'] = _verlagsort;
    map['jahr'] = _jahr;
    map['Anmerkung'] = _anmerkung;
    map['isbn'] = _isbn;
    map['ean'] = _ean;
    map['preis'] = _preis;
    map['interessenkreis'] = _interessenkreis;
    map['beschreibung'] = _beschreibung;
    map['link'] = _link;
    if (_kopien != null) {
      map['kopien'] = _kopien?.map((v) => v.toJson()).toList();
    }
    map['umfang'] = _umfang;
    map['cover'] = _cover;
    map['untertitel'] = _untertitel;
    map['type'] = _type;
    return map;
  }
}

Kopien kopienFromJson(String str) => Kopien.fromJson(json.decode(str));

String kopienToJson(Kopien data) => json.encode(data.toJson());

class Kopien {
  Kopien({
    String? bibliothek,
    String? status,
  }) {
    _bibliothek = bibliothek;
    _status = status;
  }

  Kopien.fromJson(dynamic json) {
    _bibliothek = json['bibliothek'];
    _status = json['status'];
  }

  String? _bibliothek;
  String? _status;

  Kopien copyWith({
    String? bibliothek,
    String? status,
  }) =>
      Kopien(
        bibliothek: bibliothek ?? _bibliothek,
        status: status ?? _status,
      );

  String? get bibliothek => _bibliothek;

  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bibliothek'] = _bibliothek;
    map['status'] = _status;
    return map;
  }
}
