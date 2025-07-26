-- 用户核心表
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
    id BIGINT PRIMARY KEY COMMENT '用户唯一标识',
    username VARCHAR(64) NOT NULL COMMENT '用户名（唯一）',
    password VARCHAR(128) NOT NULL COMMENT '加密密码',
    nickname VARCHAR(64) COMMENT '用户昵称',
    last_login_time TIMESTAMP NULL DEFAULT NULL COMMENT '最后登录时间',
    is_active BOOLEAN DEFAULT TRUE COMMENT '是否激活',
    email VARCHAR(128) NOT NULL COMMENT '电子邮箱',
    phone VARCHAR(32) COMMENT '手机号码',
    is_delete BOOLEAN DEFAULT FALSE COMMENT '是否删除',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    UNIQUE KEY idx_user_username (username),
    UNIQUE KEY idx_user_email (email),
    KEY idx_user_phone (phone)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户核心表';

-- 用户详细信息表
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
    id BIGINT PRIMARY KEY COMMENT '信息记录唯一标识',
    age INT COMMENT '年龄',
    sex VARCHAR(8) COMMENT '性别',
    avatar_url VARCHAR(256) COMMENT '头像链接',
    birthday DATE COMMENT '出生日期',
    region VARCHAR(128) COMMENT '所在地区',
    bio TEXT COMMENT '个人简介',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    is_delete BOOLEAN DEFAULT FALSE COMMENT '是否删除',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    UNIQUE KEY idx_user_info_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户详细信息表';

-- 群聊表
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
    id BIGINT PRIMARY KEY COMMENT '群聊唯一标识',
    is_delete BOOLEAN DEFAULT FALSE COMMENT '是否解散',
    name VARCHAR(64) NOT NULL COMMENT '群聊名称',
    description TEXT COMMENT '群描述',
    avatar_url VARCHAR(256) COMMENT '群头像',
    creator_id BIGINT NOT NULL COMMENT '创建者ID',
    join_verify BOOLEAN DEFAULT FALSE COMMENT '加入验证',
    max_member_count INT DEFAULT 200 COMMENT '最大成员数',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    KEY idx_group_creator_id (creator_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='群聊表';

-- 用户-群聊关联表
DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group` (
    id BIGINT PRIMARY KEY COMMENT '主键',
    userid BIGINT NOT NULL COMMENT '用户ID',
    groupid BIGINT NOT NULL COMMENT '群聊ID',
    type VARCHAR(16) COMMENT '用户身份',
    join_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
    is_exit BOOLEAN DEFAULT FALSE COMMENT '是否退出',
    exit_time TIMESTAMP NULL DEFAULT NULL COMMENT '退出时间',
    last_speak_time TIMESTAMP NULL DEFAULT NULL COMMENT '最后发言时间',
    is_muted BOOLEAN DEFAULT FALSE COMMENT '是否禁言',
    mute_end_time TIMESTAMP NULL DEFAULT NULL COMMENT '禁言结束时间',
    is_delete BOOLEAN DEFAULT FALSE COMMENT '是否删除',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    KEY idx_user_group_userid (userid),
    KEY idx_user_group_groupid (groupid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户-群聊关联表';

-- 兴趣爱好表
DROP TABLE IF EXISTS `hobby`;
CREATE TABLE `hobby` (
    id BIGINT PRIMARY KEY COMMENT '兴趣唯一标识',
    title VARCHAR(64) NOT NULL COMMENT '兴趣名称',
    `desc` TEXT COMMENT '兴趣描述',
    is_hot BOOLEAN DEFAULT FALSE COMMENT '是否热门',
    is_delete BOOLEAN DEFAULT FALSE COMMENT '是否删除',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    UNIQUE KEY idx_hobby_title (title)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='兴趣爱好表';

-- 兴趣分类表
DROP TABLE IF EXISTS `hobby_category`;
CREATE TABLE `hobby_category` (
    id BIGINT PRIMARY KEY COMMENT '兴趣分类唯一标识',
    title VARCHAR(64) NOT NULL COMMENT '兴趣分类名称',
    is_delete BOOLEAN DEFAULT FALSE COMMENT '是否删除',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    UNIQUE KEY idx_hobby_category_title (title)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='兴趣分类表';

-- 好友关系表
DROP TABLE IF EXISTS `friendship`;
CREATE TABLE `friendship` (
    id BIGINT PRIMARY KEY COMMENT '关系唯一标识',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    friend_id BIGINT NOT NULL COMMENT '好友ID',
    friend_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '成为好友时间',
    remark_name VARCHAR(64) COMMENT '好友备注',
    is_delete BOOLEAN DEFAULT FALSE COMMENT '是否删除',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    KEY idx_friendship_user_id (user_id),
    KEY idx_friendship_friend_id (friend_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='好友关系表';

-- 好友请求表
DROP TABLE IF EXISTS `friend_request`;
CREATE TABLE `friend_request` (
    id BIGINT PRIMARY KEY COMMENT '请求唯一标识',
    sender_id BIGINT NOT NULL COMMENT '发送者ID',
    receiver_id BIGINT NOT NULL COMMENT '接收者ID',
    request_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '请求发送时间',
    notes TEXT COMMENT '请求备注',
    status VARCHAR(16) DEFAULT '待处理' COMMENT '请求状态',
    handle_time TIMESTAMP NULL DEFAULT NULL COMMENT '处理时间',
    reject_reason TEXT COMMENT '拒绝原因',
    is_delete BOOLEAN DEFAULT FALSE COMMENT '是否删除',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    KEY idx_friend_request_sender_id (sender_id),
    KEY idx_friend_request_receiver_id (receiver_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='好友请求表';

-- 加群请求表
DROP TABLE IF EXISTS `group_request`;
CREATE TABLE `group_request` (
    id BIGINT PRIMARY KEY COMMENT '请求唯一标识',
    sender_id BIGINT NOT NULL COMMENT '申请人ID',
    group_id BIGINT NOT NULL COMMENT '群聊ID',
    request_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
    notes TEXT COMMENT '申请备注',
    status VARCHAR(16) DEFAULT '待审核' COMMENT '请求状态',
    handler_id BIGINT COMMENT '处理人ID',
    handle_time TIMESTAMP NULL DEFAULT NULL COMMENT '处理时间',
    reject_reason TEXT COMMENT '拒绝原因',
    is_delete BOOLEAN DEFAULT FALSE COMMENT '是否删除',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    KEY idx_group_request_sender_id (sender_id),
    KEY idx_group_request_group_id (group_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='加群请求表';

-- 通知表
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
    id BIGINT PRIMARY KEY COMMENT '通知唯一标识',
    user_id BIGINT NOT NULL COMMENT '接收通知的用户ID',
    type VARCHAR(32) NOT NULL COMMENT '通知类型',
    notes TEXT COMMENT '通知内容',
    is_read BOOLEAN DEFAULT FALSE COMMENT '是否已读',
    send_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
    related_id BIGINT COMMENT '关联ID',
    is_delete BOOLEAN DEFAULT FALSE COMMENT '是否删除',
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    KEY idx_notification_user_id (user_id),
    KEY idx_notification_type (type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='通知表'; 