import 'package:smart_lock_app/core/base/base_notifier.dart';

class ManageMembersNotifier extends BaseChangeNotifier {
  final List<Map<String, dynamic>> members = [
    {
      "name": "Ahamed",
      "mobile": "+971 50 555 1212",
      "relationship": "Family",
      "accessType": "Pickup Only",
      "isActive": true,
    },
    {
      "name": "Shameer",
      "mobile": "+971 50 888 4545",
      "relationship": "Friend",
      "accessType": "Temporary Access",
      "isActive": false,
    },
  ];

  void toggleMemberStatus(int index) {
    members[index]["isActive"] = !(members[index]["isActive"] as bool);
    notifyListeners();
  }

  void removeMember(int index) {
    members.removeAt(index);
    notifyListeners();
  }
}