class NaturalSort {
  static List<String> sortFilenames(List<String> filenames) {
    List<String> sorted = List.from(filenames);
    sorted.sort((a, b) => _compareNatural(a, b));
    return sorted;
  }

  static int _compareNatural(String a, String b) {
    final regex = RegExp(r'(\d+|\D+)');
    final aMatches = regex.allMatches(a.toLowerCase()).map((m) => m.group(0)!).toList();
    final bMatches = regex.allMatches(b.toLowerCase()).map((m) => m.group(0)!).toList();

    int minLength = aMatches.length < bMatches.length ? aMatches.length : bMatches.length;

    for (int i = 0; i < minLength; i++) {
      String aChunk = aMatches[i];
      String bChunk = bMatches[i];

      int? aNum = int.tryParse(aChunk);
      int? bNum = int.tryParse(bChunk);

      if (aNum != null && bNum != null) {
        int numCompare = aNum.compareTo(bNum);
        if (numCompare != 0) return numCompare;
      } else {
        int strCompare = aChunk.compareTo(bChunk);
        if (strCompare != 0) return strCompare;
      }
    }

    return aMatches.length.compareTo(bMatches.length);
  }
}
