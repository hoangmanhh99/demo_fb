class UserNotification {
  final String imageUrl;
  final String content;
  final String time;

  UserNotification({
    this.imageUrl,
    this.content,
    this.time
  });
}

List<UserNotification> notifications = [
  new UserNotification(imageUrl: 'assets/avatar.jpg', content: 'Mạnh đã thêm bài viết mới', time: '3 giờ trước'),
  new UserNotification(imageUrl: 'assets/avatar.jpg', content: 'Mạnh đã thêm bài viết mới', time: '8 giờ trước'),
  new UserNotification(imageUrl: 'assets/avatar.jpg', content: 'Mạnh đã thêm bài viết mới', time: '9 giờ trước'),
  new UserNotification(imageUrl: 'assets/avatar.jpg', content: 'Mạnh đã thêm bài viết mới', time: '22 giờ trước'),
  new UserNotification(imageUrl: 'assets/avatar.jpg', content: 'Mạnh đã thêm bài viết mới', time: '1 ngày trước'),
  new UserNotification(imageUrl: 'assets/avatar.jpg', content: 'Mạnh đã thêm bài viết mới', time: '4 ngày trước'),
  new UserNotification(imageUrl: 'assets/avatar.jpg', content: 'Mạnh đã thêm bài viết mới', time: '6 ngày trước'),
  new UserNotification(imageUrl: 'assets/avatar.jpg', content: 'Mạnh đã thêm bài viết mới', time: '1 tuần trước'),
  new UserNotification(imageUrl: 'assets/avatar.jpg', content: 'Mạnh đã thêm bài viết mới', time: '3 tuần trước'),
  new UserNotification(imageUrl: 'assets/avatar.jpg', content: 'Mạnh đã thêm bài viết mới', time: '1 tháng trước')
];