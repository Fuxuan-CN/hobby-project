-- 备注：逻辑外键需要逻辑实现
-- 用户表
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`
(
    user_id       CHAR(32)     NOT NULL COMMENT '用户唯一标识 无连字符uuid',
    username      VARCHAR(64)  NOT NULL COMMENT '用户名（唯一）',
    password      VARCHAR(128) NOT NULL COMMENT '加密后的密码',
    nickname      VARCHAR(64)  NOT NULL COMMENT '用户昵称',
    email         VARCHAR(128) NOT NULL COMMENT '电子邮箱（唯一）',
    phone         VARCHAR(32)  NOT NULL DEFAULT '' COMMENT '手机号码',
    last_login_at DATETIME              DEFAULT NULL COMMENT '最后登录时间',
    is_active     TINYINT(1)   NOT NULL DEFAULT 1 COMMENT '是否激活 0-未激活 1-已激活',
    is_deleted    TINYINT(1)   NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (user_id),
    UNIQUE KEY uk_username (username),
    UNIQUE KEY uk_email (email),
    UNIQUE KEY uk_phone (phone),
    KEY idx_phone (phone)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户表';

-- 用户详细信息表
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`
(
    user_info_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '信息记录唯一标识',
    user_id      CHAR(32)        NOT NULL COMMENT '用户ID',
    gender       VARCHAR(8)      NOT NULL DEFAULT '' COMMENT '性别 male-男 female-女',
    avatar_url   VARCHAR(256)    NOT NULL DEFAULT '' COMMENT '头像链接',
    birthday     DATE                     DEFAULT NULL COMMENT '出生日期',
    region       VARCHAR(128)    NOT NULL DEFAULT '' COMMENT '所在地区',
    bio          TEXT                     DEFAULT NULL COMMENT '个人简介',
    is_deleted   TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at   DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at   DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (user_info_id),
    UNIQUE KEY uk_user_id (user_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户详细信息表';

-- 群聊表
DROP TABLE IF EXISTS `chat_group`;
CREATE TABLE `chat_group`
(
    group_id         BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '群聊唯一标识',
    name             VARCHAR(64)     NOT NULL COMMENT '群聊名称',
    description      TEXT                     DEFAULT NULL COMMENT '群描述',
    avatar_url       VARCHAR(256)    NOT NULL DEFAULT '' COMMENT '群头像',
    creator_id       CHAR(32)        NOT NULL COMMENT '创建者ID',
    join_verify      TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '加入验证 0-不需要验证 1-需要验证',
    max_member_count INT             NOT NULL DEFAULT 200 COMMENT '最大成员数',
    num_member       INT             NOT NULL DEFAULT 0 COMMENT '当前成员数',
    is_deleted       TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at       DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at       DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (group_id),
    KEY idx_creator_id (creator_id),
    KEY idx_creator_id_is_deleted (creator_id, is_deleted)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '群聊表';

-- 用户-群聊关联表
DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group`
(
    user_group_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    user_id       CHAR(32)        NOT NULL COMMENT '用户ID',
    group_id      BIGINT UNSIGNED NOT NULL COMMENT '群聊ID',
    role          VARCHAR(16)     NOT NULL COMMENT '用户身份 creator-群主 admin-管理员 user-普通用户',
    join_at       DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
    is_exited     TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否退出 0-未退出 1-已退出',
    exit_at       DATETIME                 DEFAULT NULL COMMENT '退出时间',
    last_speak_at DATETIME                 DEFAULT NULL COMMENT '最后发言时间',
    is_muted      TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否禁言 0-未禁言 1-已禁言',
    mute_end_at   DATETIME                 DEFAULT NULL COMMENT '禁言结束时间',
    is_deleted    TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (user_group_id),
    KEY idx_user_id (user_id),
    KEY idx_group_id (group_id),
    UNIQUE KEY uk_user_group (user_id, group_id),
    KEY idx_user_group_status (user_id, group_id, is_exited, is_deleted)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户-群聊关联表';

-- 兴趣分类表
DROP TABLE IF EXISTS `hobby_category`;
CREATE TABLE `hobby_category`
(
    category_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '兴趣分类唯一标识',
    title       VARCHAR(64)     NOT NULL COMMENT '兴趣分类名称',
    is_deleted  TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (category_id),
    UNIQUE KEY uk_title (title)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '兴趣分类表';

-- 初始化兴趣分类
INSERT INTO `hobby_category` (title)
VALUES ('体育运动'),
       ('音乐'),
       ('艺术'),
       ('科技'),
       ('游戏'),
       ('美食'),
       ('旅游'),
       ('阅读'),
       ('影视'),
       ('手工/DIY'),
       ('宠物'),
       ('摄影'),
       ('时尚'),
       ('健康健身'),
       ('汽车'),
       ('投资理财'),
       ('动漫'),
       ('社交'),
       ('公益');

-- 用户-兴趣关联表
DROP TABLE IF EXISTS `user_category`;
CREATE TABLE `user_category`
(
    user_category_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户-兴趣唯一标识',
    user_id          CHAR(32)        NOT NULL COMMENT '用户ID',
    category_id      BIGINT UNSIGNED NOT NULL COMMENT '兴趣分类ID',
    is_deleted       TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at       DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at       DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (user_category_id),
    KEY idx_user_id (user_id),
    KEY idx_category_id (category_id),
    UNIQUE KEY uk_user_category (user_id, category_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户-兴趣分类关联表';

-- 好友关系表
DROP TABLE IF EXISTS `friendship`;
CREATE TABLE `friendship`
(
    friendship_id    BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '关系唯一标识',
    user_id          CHAR(32)        NOT NULL COMMENT '用户ID',
    friend_id        CHAR(32)        NOT NULL COMMENT '好友ID',
    friend_at        DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '成为好友时间',
    remark_name      VARCHAR(64)     NOT NULL DEFAULT '' COMMENT '好友备注',
    friend_source    VARCHAR(16)     NOT NULL COMMENT '好友来源 system-系统推荐 friend-好友名片 search-精准搜索添加 group-群聊添加',
    friend_source_id VARCHAR(32)     NOT NULL COMMENT '好友来源ID 系统推荐为空, 好友名片为好友ID, 精准搜索为搜索ID, 群聊为群聊ID',
    is_deleted       TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at       DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at       DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (friendship_id),
    KEY idx_user_id (user_id),
    KEY idx_friend_id (friend_id),
    KEY idx_user_friend (user_id, friend_id, is_deleted),
    KEY idx_user_deleted (user_id, is_deleted)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '好友关系表';

-- 好友分组表
DROP TABLE IF EXISTS `friend_group`;
CREATE TABLE `friend_group`
(
    group_id   BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分组唯一标识',
    user_id    CHAR(32)        NOT NULL COMMENT '所属用户ID（分组的创建者）',
    group_name VARCHAR(64)     NOT NULL COMMENT '分组名称（如“家人”“同事”）',
    sort_order INT             NOT NULL DEFAULT 0 COMMENT '分组排序权重（值越大越靠前）',
    is_deleted TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (group_id),
    KEY idx_user_id (user_id),
    KEY idx_user_deleted (user_id, is_deleted),
    UNIQUE KEY uk_user_group_name (user_id, group_name)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT '好友分组信息表';

DROP TABLE IF EXISTS `friend_in_group`;
CREATE TABLE `friend_in_group`
(
    relation_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '关联关系唯一标识',
    user_id     CHAR(32)        NOT NULL COMMENT '所属用户ID（分组的创建者）',
    group_id    BIGINT UNSIGNED NOT NULL COMMENT '分组ID（关联friend_group表）',
    friend_id   CHAR(32)        NOT NULL COMMENT '好友ID（关联friendship表的friend_id）',
    is_deleted  TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (relation_id),
    KEY idx_user_group (user_id, group_id),
    KEY idx_user_friend (user_id, friend_id),
    UNIQUE KEY uk_user_group_friend (user_id, group_id, friend_id) COMMENT '同一好友在同一分组中仅能存在一次'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT '好友与分组的关联关系表';

-- 好友请求表
DROP TABLE IF EXISTS `friend_request`;
CREATE TABLE `friend_request`
(
    request_id    BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '请求唯一标识',
    sender_id     CHAR(32)        NOT NULL COMMENT '发送者ID',
    receiver_id   CHAR(32)        NOT NULL COMMENT '接收者ID',
    request_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '请求发送时间',
    notes         TEXT                     DEFAULT NULL COMMENT '请求备注',
    status        VARCHAR(16)     NOT NULL DEFAULT 'pending' COMMENT '请求状态 pending-待处理 accepted-已通过 rejected-已拒绝',
    handle_at     DATETIME                 DEFAULT NULL COMMENT '处理时间',
    reject_reason TEXT                     DEFAULT NULL COMMENT '拒绝原因',
    is_deleted    TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (request_id),
    KEY idx_sender_id (sender_id),
    KEY idx_receiver_id (receiver_id),
    UNIQUE KEY uk_sender_receiver (sender_id, receiver_id, status)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '好友请求表';

-- 加群请求表
DROP TABLE IF EXISTS `group_request`;
CREATE TABLE `group_request`
(
    request_id    BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '请求唯一标识',
    sender_id     CHAR(32)        NOT NULL COMMENT '申请人ID',
    group_id      BIGINT UNSIGNED NOT NULL COMMENT '群聊ID',
    request_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
    notes         TEXT                     DEFAULT NULL COMMENT '申请备注',
    status        VARCHAR(16)     NOT NULL DEFAULT 'pending' COMMENT '请求状态 pending-待处理 accepted-已通过 rejected-已拒绝',
    handler_id    CHAR(32)        NOT NULL COMMENT '处理人ID',
    handle_at     DATETIME                 DEFAULT NULL COMMENT '处理时间',
    reject_reason TEXT                     DEFAULT NULL COMMENT '拒绝原因',
    is_deleted    TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (request_id),
    KEY idx_sender_id (sender_id),
    KEY idx_group_id (group_id),
    UNIQUE KEY uk_sender_group_status (sender_id, group_id, status)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '加群请求表';

-- 通知表
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification`
(
    notification_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '通知唯一标识',
    user_id         CHAR(32)        NOT NULL COMMENT '接收通知的用户ID',
    type            VARCHAR(32)     NOT NULL COMMENT '通知类型 friend-好友请求 group-群聊请求',
    content         TEXT                     DEFAULT NULL COMMENT '通知内容',
    is_read         TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已读 0-未读 1-已读',
    related_id      BIGINT UNSIGNED NOT NULL COMMENT '关联ID, 如好友请求ID、群请求ID',
    send_at         DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
    is_deleted      TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (notification_id),
    KEY idx_user_id (user_id),
    KEY idx_type (type),
    KEY idx_user_read_send_at (user_id, is_read, send_at)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '通知表';

-- 会话表
DROP TABLE IF EXISTS `chat_session`;
CREATE TABLE `chat_session`
(
    `session_id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '会话唯一标识',
    `user_id`             char(32)        NOT NULL COMMENT '所属用户ID（会话的持有者）',
    `session_type`        TINYINT         NOT NULL COMMENT '会话类型：0-单聊，1-群聊',
    -- 单聊/群聊区分字段（二选一非空）
    `single_chat_user_id` char(32)                 DEFAULT NULL COMMENT '单聊对象用户ID（session_type=0时非空）',
    `group_chat_id`       BIGINT UNSIGNED          DEFAULT NULL COMMENT '群聊ID（session_type=1时非空）',
    -- 会话展示信息
    `show_name`           VARCHAR(64)     NOT NULL COMMENT '会话显示名称（单聊=对方昵称，群聊=群名称）',
    `show_avatar`         VARCHAR(256)    NOT NULL DEFAULT '' COMMENT '会话显示头像（单聊=对方头像，群聊=群头像）',
    -- 最后一条消息信息
    `last_msg_content`    TEXT COMMENT '最后一条消息内容（摘要）',
    `last_msg_type`       VARCHAR(16)     NOT NULL DEFAULT '' COMMENT '最后一条消息类型（text/image/voice等）',
    `last_msg_sender_id`  char(32)        NOT NULL COMMENT '最后一条消息发送者ID',
    `last_msg_send_at`    DATETIME        NOT NULL COMMENT '最后一条消息发送时间',
    -- 会话状态
    `unread_count`        INT             NOT NULL DEFAULT 0 COMMENT '未读消息数量',
    `is_pinned`           TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否置顶：0-否，1-是',
    -- 通用字段
    `is_deleted`          TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否删除：0-否，1-是',
    `created_at`          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '会话创建时间',
    `updated_at`          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
    PRIMARY KEY (`session_id`),
    -- 核心索引：支持chatList查询
    KEY `idx_user_valid` (`user_id`, `is_deleted`) COMMENT '查询用户的有效会话',
    KEY `idx_user_sort` (`user_id`, `is_deleted`, `is_pinned` DESC, `last_msg_send_at` DESC) COMMENT '按置顶+时间排序会话',
    -- 唯一约束：避免重复会话
    UNIQUE KEY `uk_single_chat` (`user_id`, `single_chat_user_id`) COMMENT '单聊会话唯一（用户A与B仅一个会话）',
    UNIQUE KEY `uk_group_chat` (`user_id`, `group_chat_id`) COMMENT '群聊会话唯一（用户与群仅一个会话）'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT '会话表（用于chatList查询）';
