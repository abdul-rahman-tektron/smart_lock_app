import 'package:intl/intl.dart';
import 'package:smart_lock_app/core/base/base_notifier.dart';
import 'package:smart_lock_app/core/model/error_response.dart';
import 'package:smart_lock_app/core/model/package/package_count_response.dart';
import 'package:smart_lock_app/core/model/package/package_list_response.dart';
import 'package:smart_lock_app/core/remote/services/common_repository.dart';

class HomeNotifier extends BaseChangeNotifier {
  int tabs = 2;

  String userName = "Abdul Rahman";
  String unitName = "Unit A-1204 • Aldar Residence";

  bool isLoading = false;
  String errorMessage = "";

  List<PackageListDataItem> activeDeliveries = [];
  List<PackageListDataItem> usedInactiveDeliveries = [];

  int activeCount = 0;
  int overdueCount = 0;
  int usedCount = 0;
  int totalCount = 0;

  HomeNotifier() {
    getSavedUser();
    userName = user?.fullName ?? "";
    unitName = "No.${user?.flatNo}, ${user?.floorNo} Floor, ${user?.buildingName}";
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    isLoading = true;
    errorMessage = "";
    notifyListeners();

    final receiverId = user?.tenantId?.toString();

    await Future.wait([
      loadPackageCount(receiverId),
      loadPackageLists(receiverId),
    ]);

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadPackageCount(String? receiverId) async {
    final result = await CommonRepository.instance.apiPackageCount(
      receiverId: receiverId,
    );

    if (result is PackageCountResponse && result.success == true) {
      activeCount = result.data?.activeCount ?? 0;
      overdueCount = result.data?.overdueCount ?? 0;
      usedCount = result.data?.completedCount ?? 0;
      totalCount = result.data?.totalCount ?? 0;
    } else if (result is ErrorResponse) {
      errorMessage = result.message ?? "Failed to load package counts";
    } else if (result is PackageCountResponse) {
      errorMessage = result.message ?? "Failed to load package counts";
    }
  }

  Future<void> loadPackageLists(String? receiverId) async {
    final activeResult = await CommonRepository.instance.apiPackageList(
      receiverId: receiverId,
      statusId: "1,2",
      pageNumber: 1,
      pageSize: 100,
    );

    final usedResult = await CommonRepository.instance.apiPackageList(
      receiverId: receiverId,
      statusId: "3",
      pageNumber: 1,
      pageSize: 100,
    );

    if (activeResult is PackageListResponse && activeResult.success == true) {
      activeDeliveries = activeResult.data?.items ?? [];
    } else if (activeResult is ErrorResponse) {
      errorMessage = activeResult.message ?? "Failed to load active packages";
    } else if (activeResult is PackageListResponse) {
      errorMessage = activeResult.message ?? "Failed to load active packages";
    }

    if (usedResult is PackageListResponse && usedResult.success == true) {
      usedInactiveDeliveries = usedResult.data?.items ?? [];
    } else if (usedResult is ErrorResponse) {
      errorMessage = usedResult.message ?? "Failed to load used packages";
    } else if (usedResult is PackageListResponse) {
      errorMessage = usedResult.message ?? "Failed to load used packages";
    }
  }

  int get expiredCount => 0;

  String get activeTabLabel => "Active";
  String get usedTabLabel => "Used / Completed";

  String get welcomeNote {
    final attentionCount = activeCount + overdueCount;
    if (attentionCount == 0) {
      return "No active deliveries right now";
    }
    return "$attentionCount deliveries need attention";
  }

  String formatDate(DateTime? date) {
    if (date == null) return "--";
    try {
      return DateFormat('dd-MM-yyyy, hh:mm a').format(date);
    } catch (_) {
      return "--";
    }
  }

  String getStatusLabel(PackageListDataItem item) {
    switch (item.statusId) {
      case 1:
        return "Active";
      case 2:
        return "Overdue";
      case 3:
        return "Used";
      default:
        return item.statusName ?? "--";
    }
  }

  String getTitle(PackageListDataItem item) {
    final status = getStatusLabel(item).toLowerCase();
    return status == "used" ? "Package Collected" : "Package Received";
  }
}