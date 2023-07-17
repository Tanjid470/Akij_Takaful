class BasicTile {
  final String title;
  final String subtitle;
  final List<BasicTile> tiles;

  const BasicTile({
    required this.title,
    required this.subtitle,
    this.tiles = const [],
  });
}
