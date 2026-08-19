import 'dart:io';

import '../models/member.dart';
import '../services/member_service.dart';

class MemberScreen {
  final MemberService _memberService = MemberService();

  Future<void> show() async {
    while (true) {
      print('');
      print('======================================');
      print('          MEMBER MANAGEMENT');
      print('======================================');
      print('1. View All Members');
      print('2. Find Member By ID');
      print('3. Add Member');
      print('4. Update Member');
      print('5. Delete Member');
      print('6. Back');
      print('======================================');

      stdout.write('Select an option: ');
      final choice = stdin.readLineSync()?.trim();

      switch (choice) {
        case '1':
          await _getAllMembers();
          break;

        case '2':
          await _getMemberById();
          break;

        case '3':
          await _addMember();
          break;

        case '4':
          await _updateMember();
          break;

        case '5':
          await _deleteMember();
          break;

        case '6':
          return;

        default:
          print('Invalid option.');
      }
    }
  }

  Future<void> _getAllMembers() async {
    final members = await _memberService.getMembers();

    print('');
    print('========== MEMBERS ==========');

    if (members.isEmpty) {
      print('No members found.');
      return;
    }

    for (final member in members) {
      print('---------------------------');
      print('ID: ${member.id}');
      print('Name: ${member.name}');
      print('Phone: ${member.phone}');
      print('Email: ${member.email}');
    }

    print('---------------------------');
  }

  Future<void> _getMemberById() async {
    stdout.write('Enter Member ID: ');

    final id = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (id == null) {
      print('Invalid ID. Please enter a number.');
      return;
    }

    final member = await _memberService.getMemberById(id);

    if (member == null) {
      print('Member not found.');
      return;
    }

    _displayMember(member);
  }

  Future<void> _addMember() async {
    stdout.write('Name: ');
    final name = stdin.readLineSync()?.trim() ?? '';

    stdout.write('Phone: ');
    final phone = stdin.readLineSync()?.trim() ?? '';

    stdout.write('Email: ');
    final email = stdin.readLineSync()?.trim() ?? '';

    if (name.isEmpty || phone.isEmpty || email.isEmpty) {
      print('Please enter valid information.');
      return;
    }

    final member = Member(
      name: name,
      phone: phone,
      email: email,
    );

    final result = await _memberService.addMember(member);

    if (result != null) {
      print('Member Added Successfully!');
      print('Generated ID: ${result.id}');
    } else {
      print('Failed to add member.');
    }
  }

  Future<void> _updateMember() async {
    stdout.write('Enter Member ID: ');

    final id = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (id == null) {
      print('Invalid ID. Please enter a number.');
      return;
    }

    final existingMember =
        await _memberService.getMemberById(id);

    if (existingMember == null) {
      print('Member not found.');
      return;
    }

    stdout.write('New Name: ');
    final nameInput = stdin.readLineSync()?.trim();

    stdout.write('New Phone: ');
    final phoneInput = stdin.readLineSync()?.trim();

    stdout.write('New Email: ');
    final emailInput = stdin.readLineSync()?.trim();

    final updatedMember = Member(
      id: existingMember.id,
      name: nameInput == null || nameInput.isEmpty
          ? existingMember.name
          : nameInput,
      phone: phoneInput == null || phoneInput.isEmpty
          ? existingMember.phone
          : phoneInput,
      email: emailInput == null || emailInput.isEmpty
          ? existingMember.email
          : emailInput,
    );

    final result =
        await _memberService.updateMember(updatedMember);

    if (result != null) {
      print('Member Updated Successfully!');
    } else {
      print('Update Failed.');
    }
  }

  Future<void> _deleteMember() async {
    stdout.write('Enter Member ID: ');

    final id = int.tryParse(
      stdin.readLineSync()?.trim() ?? '',
    );

    if (id == null) {
      print('Invalid ID. Please enter a number.');
      return;
    }

    final success = await _memberService.deleteMember(id);

    if (success) {
      print('Member Deleted Successfully!');
    } else {
      print('Delete Failed.');
    }
  }

  void _displayMember(Member member) {
    print('');
    print('========== MEMBER ==========');
    print('ID: ${member.id}');
    print('Name: ${member.name}');
    print('Phone: ${member.phone}');
    print('Email: ${member.email}');
    print('============================');
  }
}