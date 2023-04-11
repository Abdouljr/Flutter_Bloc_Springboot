class Message {
  int id;
  String contenu;
  int contactId;
  Enum type;
  DateTime date;
  bool selected;
  Message(
      {required this.id,
      required this.contenu,
      required this.contactId,
      required this.type,
      required this.date , required this.selected});
}
