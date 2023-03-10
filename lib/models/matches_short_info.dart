class MatchShortInfo {
  final int id;
  final String? title;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;
  final String? country1ShortName;
  final String? country2ShortName;
  final int? contest_id;

  MatchShortInfo({
    required this.id,
    required this.title,
    required this.country1Name,
    required this.country2Name,
    required this.time,
    this.price = '',
    required this.country1Flag,
    required this.country2Flag,
    required this.country1ShortName,
    required this.country2ShortName,
    required this.contest_id,
  });

  factory MatchShortInfo.fromJson({required Map<String, dynamic> jsonData}) {
    return MatchShortInfo(
      id: jsonData['id'] ?? 0,
      title: jsonData['title'] ?? '',
      country1Name: jsonData['team_1_title'] ?? '',
      country2Name: jsonData['team_2_title'] ?? '',
      // country1Flag: jsonData['team_1_thumbnail']??'',
      // country2Flag: jsonData['team_2_thumbnail']??'',
      country1ShortName: jsonData['team_1_short_name'],
      country2ShortName: jsonData['team_2_short_name'],
      country1Flag: 'assets/19.png',
      country2Flag: 'assets/25.png',
      price: jsonData['price'] ?? '',
      time: jsonData['title'] ?? '',
      contest_id: jsonData['contest_category_id'] ?? 1,
    );
  }
}
