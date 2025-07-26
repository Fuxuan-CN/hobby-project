-- 用户表
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`
(
    user_id       BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户唯一标识',
    username      VARCHAR(64)     NOT NULL COMMENT '用户名（唯一）',
    password      VARCHAR(128)    NOT NULL COMMENT '加密后的密码',
    nickname      VARCHAR(64)              DEFAULT NULL COMMENT '用户昵称',
    email         VARCHAR(128)    NOT NULL COMMENT '电子邮箱（唯一）',
    phone         VARCHAR(32)              DEFAULT NULL COMMENT '手机号码',
    last_login_at DATETIME                 DEFAULT NULL COMMENT '最后登录时间',
    is_active     TINYINT(1)      NOT NULL DEFAULT 1 COMMENT '是否激活 0-未激活 1-已激活',
    is_deleted    TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (user_id),
    UNIQUE KEY uk_username (username),
    UNIQUE KEY uk_email (email),
    KEY idx_phone (phone)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户表';

-- 用户详细信息表
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`
(
    user_info_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '信息记录唯一标识',
    user_id      BIGINT UNSIGNED NOT NULL COMMENT '用户ID',
    age          INT                      DEFAULT NULL COMMENT '年龄',
    gender       VARCHAR(8)               DEFAULT NULL COMMENT '性别',
    avatar_url   VARCHAR(256)             DEFAULT NULL COMMENT '头像链接',
    birthday     DATE                     DEFAULT NULL COMMENT '出生日期',
    region       VARCHAR(128)             DEFAULT NULL COMMENT '所在地区',
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
    avatar_url       VARCHAR(256)             DEFAULT NULL COMMENT '群头像',
    creator_id       BIGINT UNSIGNED NOT NULL COMMENT '创建者ID',
    join_verify      TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '加入验证 0-不需要验证 1-需要验证',
    max_member_count INT             NOT NULL DEFAULT 200 COMMENT '最大成员数',
    is_deleted       TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at       DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at       DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (group_id),
    KEY idx_creator_id (creator_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '群聊表';

-- 用户-群聊关联表
DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group`
(
    user_group_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    user_id       BIGINT UNSIGNED NOT NULL COMMENT '用户ID',
    group_id      BIGINT UNSIGNED NOT NULL COMMENT '群聊ID',
    role          VARCHAR(16)              DEFAULT NULL COMMENT '用户身份',
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
    KEY idx_group_id (group_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '用户-群聊关联表';

-- 兴趣爱好表
DROP TABLE IF EXISTS `hobby`;
CREATE TABLE `hobby`
(
    hobby_id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '兴趣唯一标识',
    hobby_category_id BIGINT UNSIGNED NOT NULL COMMENT '兴趣分类ID',
    title             VARCHAR(64)     NOT NULL COMMENT '兴趣名称',
    description       TEXT                     DEFAULT NULL COMMENT '兴趣描述',
    is_hot            TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否热门 0-否 1-是',
    is_deleted        TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at        DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at        DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (hobby_id),
    UNIQUE KEY uk_title (title)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '兴趣爱好表';

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

-- 初始化兴趣（假设兴趣分类ID从1开始，需根据实际分类ID调整）
INSERT INTO `hobby` (hobby_category_id,
                     title,
                     description)
VALUES (1, '篮球', '团队运动，锻炼身体协调性'),
       (1, '足球', '世界第一运动，团队协作'),
       (1, '羽毛球', '灵活轻快，适合各年龄段'),
       (1, '游泳', '全身锻炼，强身健体'),
       (1, '跑步', '简单易行，锻炼心肺'),
       (2, '吉他', '流行乐器，适合自弹自唱'),
       (2, '钢琴', '高雅乐器，适合独奏与伴奏'),
       (2, '唱歌', '表达情感，放松心情'),
       (2, '小提琴', '优美音色，适合独奏'),
       (3, '绘画', '艺术表达，陶冶情操'),
       (3, '书法', '中国传统艺术'),
       (3, '雕塑', '立体艺术创作'),
       (4, '编程', '开发软件，创造未来'),
       (4, '电子产品', '数码科技爱好'),
       (4, '机器人', '人工智能与自动化'),
       (5, '桌游', '线下聚会娱乐'),
       (5, '电子游戏', '虚拟世界的冒险'),
       (5, '棋牌', '益智休闲'),
       (6, '烘焙', '制作甜点与面包'),
       (6, '美食探店', '发现各地美食'),
       (6, '家常菜', '烹饪日常美味'),
       (7, '自驾游', '自由探索，享受旅途'),
       (7, '登山', '挑战自我，亲近自然'),
       (7, '露营', '户外生活体验'),
       (8, '小说', '沉浸故事世界'),
       (8, '历史', '了解过去，启迪未来'),
       (8, '科普', '增长知识，开阔视野'),
       (9, '电影', '视觉盛宴，情感共鸣'),
       (9, '电视剧', '追剧乐趣，放松心情'),
       (9, '纪录片', '真实世界的探索'),
       (10, '手工编织', '亲手制作，享受过程'),
       (10, '模型制作', '动手能力与耐心'),
       (11, '养猫', '可爱宠物，陪伴生活'),
       (11, '养狗', '忠诚伙伴，乐趣多多'),
       (12, '风景摄影', '记录美好瞬间'),
       (12, '人像摄影', '捕捉人物情感'),
       (13, '穿搭', '展现自我风格'),
       (13, '化妆', '美丽自信'),
       (14, '健身', '塑造健康体魄'),
       (14, '瑜伽', '身心放松，提升柔韧性'),
       (15, '汽车改装', '个性化爱车'),
       (15, '自驾游', '驾驶乐趣与探索'),
       (16, '股票', '投资理财，财富增值'),
       (16, '基金', '分散风险，稳健理财'),
       (17, '动漫', '二次元世界'),
       (17, '漫画', '图文并茂的故事'),
       (18, '交友', '结识新朋友'),
       (18, '聚会', '线下活动，增进感情'),
       (19, '志愿服务', '帮助他人，回馈社会'),
       (19, '环保公益', '保护环境，人人有责');

-- 好友关系表
DROP TABLE IF EXISTS `friendship`;
CREATE TABLE `friendship`
(
    friendship_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '关系唯一标识',
    user_id       BIGINT UNSIGNED NOT NULL COMMENT '用户ID',
    friend_id     BIGINT UNSIGNED NOT NULL COMMENT '好友ID',
    friend_at     DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '成为好友时间',
    remark_name   VARCHAR(64)              DEFAULT NULL COMMENT '好友备注',
    is_deleted    TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (friendship_id),
    KEY idx_user_id (user_id),
    KEY idx_friend_id (friend_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '好友关系表';

-- 好友请求表
DROP TABLE IF EXISTS `friend_request`;
CREATE TABLE `friend_request`
(
    request_id    BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '请求唯一标识',
    sender_id     BIGINT UNSIGNED NOT NULL COMMENT '发送者ID',
    receiver_id   BIGINT UNSIGNED NOT NULL COMMENT '接收者ID',
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
    KEY idx_receiver_id (receiver_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '好友请求表';

-- 加群请求表
DROP TABLE IF EXISTS `group_request`;
CREATE TABLE `group_request`
(
    request_id    BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '请求唯一标识',
    sender_id     BIGINT UNSIGNED NOT NULL COMMENT '申请人ID',
    group_id      BIGINT UNSIGNED NOT NULL COMMENT '群聊ID',
    request_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
    notes         TEXT                     DEFAULT NULL COMMENT '申请备注',
    status        VARCHAR(16)     NOT NULL DEFAULT 'pending' COMMENT '请求状态 pending-待处理 accepted-已通过 rejected-已拒绝',
    handler_id    BIGINT UNSIGNED          DEFAULT NULL COMMENT '处理人ID',
    handle_at     DATETIME                 DEFAULT NULL COMMENT '处理时间',
    reject_reason TEXT                     DEFAULT NULL COMMENT '拒绝原因',
    is_deleted    TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at    DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (request_id),
    KEY idx_sender_id (sender_id),
    KEY idx_group_id (group_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '加群请求表';

-- 通知表
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification`
(
    notification_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '通知唯一标识',
    user_id         BIGINT UNSIGNED NOT NULL COMMENT '接收通知的用户ID',
    type            VARCHAR(32)     NOT NULL COMMENT '通知类型',
    content         TEXT                     DEFAULT NULL COMMENT '通知内容',
    is_read         TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已读 0-未读 1-已读',
    related_id      BIGINT UNSIGNED          DEFAULT NULL COMMENT '关联ID, 如好友请求ID、群公告ID',
    send_at         DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
    is_deleted      TINYINT(1)      NOT NULL DEFAULT 0 COMMENT '是否已删除 0-未删除 1-已删除',
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (notification_id),
    KEY idx_user_id (user_id),
    KEY idx_type (type)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT = '通知表';
