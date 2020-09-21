part of 'provider.dart';

class HistoryProvider extends ChangeNotifier {
  History _lastHistory;
  List<History> _histories;

  History get lastHistory => _lastHistory;
  List<History> get histories => _histories;

  void loadHistory(String userID) async {
    _histories = await HistoryServices.getHistory(userID);

    notifyListeners();
  }

  void storeHistory(History history) async {
    _lastHistory = history;
    _histories = _histories + [history];

    await HistoryServices.storeHistory(history);
    
    notifyListeners();
  }

  void updateHistory(History history) async {
    _lastHistory = lastHistory.copyWith(absentCheckOut: history.absentCheckOut);

    await HistoryServices.updateHistory(history);

    notifyListeners();
  }
}