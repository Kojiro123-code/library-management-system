enum BorrowStatus { borrowed, returned }

class Borrowing {
  final String? id;
  String bookId;
  String memberId;
  DateTime borrowDate;
  DateTime? returnDate;
  BorrowStatus status;

  Borrowing({
    this.id,
    required this.bookId,
    required this.memberId,
    required this.borrowDate,
    this.returnDate,
    required this.status,
  });

  factory Borrowing.fromJson(Map<String, dynamic> json) {
    return Borrowing(
      id: json['id']?.toString(),
      bookId: json['bookId'].toString(),
      memberId: json['memberId'].toString(),
      borrowDate: DateTime.parse(json['borrowDate'].toString()),
      returnDate: json['returnDate'] != null
          ? DateTime.parse(json['returnDate'].toString())
          : null,
      status: json['status'] == 'returned'
          ? BorrowStatus.returned
          : BorrowStatus.borrowed,
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'bookId': bookId,
      'memberId': memberId,
      'borrowDate': borrowDate.toIso8601String(),
      'returnDate': returnDate?.toIso8601String(),
      'status': status.name,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookId': bookId,
      'memberId': memberId,
      'borrowDate': borrowDate.toIso8601String(),
      'returnDate': returnDate?.toIso8601String(),
      'status': status.name,
    };
  }
}