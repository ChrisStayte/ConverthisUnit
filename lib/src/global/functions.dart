/// Convert the [charcCode] to [String]
String stringFromUnicode(String charCode) =>
    String.fromCharCodes((Runes(charCode)));
