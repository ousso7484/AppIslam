class HadisBookModel {
  HadisBookModel({
    this.status,
    this.message,
    this.books,
  });

  HadisBookModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['books'] != null) {
      books = [];
      json['books'].forEach((v) {
        books?.add(Books.fromJson(v));
      });
    }
  }
  num? status;
  String? message;
  List<Books>? books;
  HadisBookModel copyWith({
    num? status,
    String? message,
    List<Books>? books,
  }) =>
      HadisBookModel(
        status: status ?? this.status,
        message: message ?? this.message,
        books: books ?? this.books,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (books != null) {
      map['books'] = books?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Books {
  Books({
    this.id,
    this.bookName,
    this.writerName,
    this.aboutWriter,
    this.writerDeath,
    this.bookSlug,
    this.hadithsCount,
    this.chaptersCount,
  });

  Books.fromJson(dynamic json) {
    id = json['id'];
    bookName = json['bookName'];
    writerName = json['writerName'];
    aboutWriter = json['aboutWriter'];
    writerDeath = json['writerDeath'];
    bookSlug = json['bookSlug'];
    hadithsCount = json['hadiths_count'];
    chaptersCount = json['chapters_count'];
  }
  num? id;
  String? bookName;
  String? writerName;
  dynamic aboutWriter;
  String? writerDeath;
  String? bookSlug;
  String? hadithsCount;
  String? chaptersCount;
  Books copyWith({
    num? id,
    String? bookName,
    String? writerName,
    dynamic aboutWriter,
    String? writerDeath,
    String? bookSlug,
    String? hadithsCount,
    String? chaptersCount,
  }) =>
      Books(
        id: id ?? this.id,
        bookName: bookName ?? this.bookName,
        writerName: writerName ?? this.writerName,
        aboutWriter: aboutWriter ?? this.aboutWriter,
        writerDeath: writerDeath ?? this.writerDeath,
        bookSlug: bookSlug ?? this.bookSlug,
        hadithsCount: hadithsCount ?? this.hadithsCount,
        chaptersCount: chaptersCount ?? this.chaptersCount,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['bookName'] = bookName;
    map['writerName'] = writerName;
    map['aboutWriter'] = aboutWriter;
    map['writerDeath'] = writerDeath;
    map['bookSlug'] = bookSlug;
    map['hadiths_count'] = hadithsCount;
    map['chapters_count'] = chaptersCount;
    return map;
  }
}
