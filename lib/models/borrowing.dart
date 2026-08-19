enum BorrowStatus { borrowed, returned }

class Borrowing {
  final int? id;

  int bookId;
  int memberId;
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
      id: int.parse(json['id'].toString()),
      bookId: int.parse(json['bookId'].toString()),
      memberId: int.parse(json['memberId'].toString()),
      borrowDate: DateTime.parse(
        json['borrowDate'].toString(),
      ),
      returnDate: json['returnDate'] != null
          ? DateTime.parse(
              json['returnDate'].toString(),
            )
          : null,
      status: json['status'] == 'returned'
          ? BorrowStatus.returned
          : BorrowStatus.borrowed,
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'id': id,
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