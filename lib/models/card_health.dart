class CardHealth {
  const CardHealth({
    required this.cardName,
    required this.shortDescription,
    required this.lonbgDescription,
    required this.image,
    required this.durationToRecover,
  });

  final String cardName;
  final String shortDescription;
  final String lonbgDescription;
  final String image;
  final Duration durationToRecover;
}
