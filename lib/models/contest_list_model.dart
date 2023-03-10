class ContestListModel {
  var id;
  final String? title;
  final String? prizePool;
  final String? noOfWinner;
  final String? entryFee;
  final String? totalSpot;
  final String? currentSpot;

  ContestListModel({
    required this.id,
    required this.title,
    required this.prizePool,
    required this.entryFee,
    required this.currentSpot,
    required this.noOfWinner,
    required this.totalSpot,
  });

  factory ContestListModel.fromJson({required Map<String, dynamic> jsonData}) {
    return ContestListModel(
      id: jsonData['id'] ?? '0',
      title: jsonData['title'] ?? '',
      prizePool: jsonData['winning_prize'] ?? '',
      entryFee: jsonData['entrance_amount'] ?? '',
      noOfWinner: 'no_of_winners',
      totalSpot: 'team_length',
      currentSpot: jsonData['title'] ?? '2',
    );
  }
}
