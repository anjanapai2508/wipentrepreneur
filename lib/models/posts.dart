class Posts {
  final String title;
  final String subtitle;
  final List<String> comments;
  final bool isFeatured;
  final int likes;
  final String id;
  final String body;
  final String publishedDate;
  final bool isTech;
  final String techName;
  Posts(this.id, this.title, this.subtitle, this.comments, this.isFeatured,
      this.likes, this.body, this.publishedDate, this.isTech, this.techName);
}
