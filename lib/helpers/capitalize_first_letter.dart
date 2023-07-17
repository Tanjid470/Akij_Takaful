String capitalizeFirstLetterOfEachWord(String input) {
  if (input.isEmpty) {
    return input;
  }

  final words = input.split(' ');

  final capitalizedWords = words.map((word) {
    if (word.isEmpty) {
      return word;
    }
    final firstLetter = word[0].toUpperCase();
    final restOfWord = word.substring(1).toLowerCase();
    return '$firstLetter$restOfWord';
  });

  return capitalizedWords.join(' ');
}
