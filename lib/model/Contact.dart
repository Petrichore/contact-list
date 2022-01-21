class Contact {
  final String fullName;
  final String imageUrl;
  final bool isOnline;
  final String lastSeen;

  const Contact(this.fullName, this.imageUrl, this.isOnline,
      {this.lastSeen = ''});
}
