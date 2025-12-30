import 'package:stacked/stacked.dart';
import '../../../helpers/utils.dart';

class CalenderDatePickerDialogModel extends ReactiveViewModel {
  int counter = 0;
  List<DateTime> selectedDates;

  CalenderDatePickerDialogModel(this.selectedDates);

  void setDates(List<DateTime> l) {
    selectedDates = l;
    notifyListeners();
  }

  void selectDate({int day = 0}) {
    counter++;
    Utils.log(">>>> $day $counter");
    final DateTime today = DateTime.now();
    final DateTime startOfToday = DateTime(today.year, today.month, today.day);

    final DateTime newDate = startOfToday.add(Duration(days: day));

    selectedDates = [newDate];
    notifyListeners();
  }
}
