class Api {
  //登录
  static const String login = '/public/api/user/login';

  //注册
  static const String register = '/public/api/user/register';

  //刷新token
  static const String refreshToken = '/public/api/user/refresh_token';

  //搜索好友
  static const String searchUser = '/private/api/user/search';

  //添加好友
  // static const String applyAddFriend = '/private/api/user/add_friend';
  static const String applyAddFriend = '/private/api/friend/add';

  //好友列表
  // static const String friendsList = '/private/api/user/friends';
  static const String friendsList = '/private/api/friend/get';

  //获取用户信息
  static const String getUserInfo = "/private/api/user/get";

  //新好友列表
  // static const String newFriendsList = "/private/api/user/new_friends";
  static const String newFriendsList = "/private/api/friend/new";

  //是否通过好友
  // static const String directFriend = "/private/api/user/review_friends";
  static const String directFriend = "/private/api/friend/review";

  //上传头像,实际上可以当上传图片用,此接口只有上传功能,上传完毕还需要根据返回消息再次修改
  static const String avatar = "/private/api/user/avatar";

  //修改用户信息
  static const String update = "/private/api/user/update";

  //删除好友
  static const String delFriend = "/private/api/friend/del";

  //添加黑名单
  static const String addBlack = "/private/api/blacklist/add";

  //移除黑名单
  static const String delBlack = "/private/api/blacklist/del";

  //黑名单列表
  static const String getBlack = "/private/api/blacklist/get";

  //备注
  static const String remark = "/private/api/friend/remark";

  //发现页列表
  static const String getDiscover = "/private/api/discover/get";

  //创建群租
  static const String createGroup = "/private/api/group/create";

  //获取会话
  static const String getConversation = "/private/api/conversation/get";

  //获取群组信息
  static const String getGroupInfo = "/private/api/group/get";

  //上传表情
  static const String uploadEmoji = "/private/api/emoticon/upload";

  //我的表情
  static const String getMyEmojis = "/private/api/emoticon/favorites";

  //移动到最前
  static const String moveEmojiToFirst = "/private/api/emoticon/first";

  //删除表情
  static const String deleteEmoji = "/private/api/emoticon/del";

  //已有表情添加为自己的
  static const String addMyToEmoji = "/private/api/emoticon/add";

  //更新群信息
  static const String groupUpdate = "/private/api/group/update";

  //退出群组
  static const String groupQuit = "/private/api/group/quit";

  //踢出群组
  static const String kickOut = "/private/api/group/kick_out";

  //邀请入群
  static const String groupInvite = "/private/api/group/invite";

  //解散群
  static const String groupDismiss = "/private/api/group/dismiss";

  //加入群组
  static const String groupJoin = "/private/api/group/join";

  //修改群头像
  static const String groupAvatar = "/private/api/group/avatar";

  //添加禁言
  static const String silenceAdd = "/private/api/group/silence_add";

  //取消禁言
  static const String silenceDel = "/private/api/group/silence_del";

  //添加管理员
  static const String adminAdd = "/private/api/group/admin_add";

  //取消管理员
  static const String adminDel = "/private/api/group/admin_del";

  //审核是否允许进群
  static const String groupReview = "/private/api/group/review";

  //转让群
  static const String groupTransfer = "/private/api/group/transfer";

  //申请进群
  static const String groupApply = "/private/api/group/apply";

  //好友数量提醒
  static const String friendNum = "/private/api/friend/new_num";
}
