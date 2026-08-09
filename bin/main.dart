import 'package:library_management_system/services/member_service.dart';

void main() async {
  final service = MemberService();

  final success = await service.deleteMember(
    "W42kUkX4hbg",
  );

  if (success) {
    print("✅ Member Deleted Successfully!");
  } else {
    print("❌ Delete Failed");
  }
}