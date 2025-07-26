# 数据库设计文档

## 1. 总体设计说明

本数据库用于兴趣社交平台，采用MySQL，所有表均使用InnoDB引擎，字符集utf8mb4。主键自增，采用逻辑外键（无物理外键约束），软删除字段is_deleted，时间字段统一为 *_at。

## 2. 表结构说明

### 2.1 用户表 user

| 字段名         | 类型             | 约束           | 说明                 |
| -------------- | ---------------- | -------------- | -------------------- |
| user_id        | BIGINT UNSIGNED  | PK, AUTO_INC   | 用户唯一标识         |
| username       | VARCHAR(64)      | UNIQUE, NOT NULL | 用户名（唯一）     |
| password       | VARCHAR(128)     | NOT NULL       | 加密后的密码         |
| nickname       | VARCHAR(64)      |                | 用户昵称             |
| email          | VARCHAR(128)     | UNIQUE, NOT NULL | 电子邮箱（唯一）   |
| phone          | VARCHAR(32)      |                | 手机号码             |
| last_login_at  | DATETIME         |                | 最后登录时间         |
| is_active      | TINYINT(1)       | NOT NULL, DEFAULT 1 | 是否激活         |
| is_deleted     | TINYINT(1)       | NOT NULL, DEFAULT 0 | 是否已删除       |
| created_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 更新时间 |

### 2.2 用户详细信息表 user_info

| 字段名         | 类型             | 约束           | 说明                 |
| -------------- | ---------------- | -------------- | -------------------- |
| user_info_id   | BIGINT UNSIGNED  | PK, AUTO_INC   | 信息记录唯一标识     |
| user_id        | BIGINT UNSIGNED  | UNIQUE, NOT NULL | 用户ID（逻辑外键） |
| age            | INT              |                | 年龄                 |
| gender         | VARCHAR(8)       |                | 性别                 |
| avatar_url     | VARCHAR(256)     |                | 头像链接             |
| birthday       | DATE             |                | 出生日期             |
| region         | VARCHAR(128)     |                | 所在地区             |
| bio            | TEXT             |                | 个人简介             |
| is_deleted     | TINYINT(1)       | NOT NULL, DEFAULT 0 | 是否已删除       |
| created_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 更新时间 |

### 2.3 群聊表 chat_group

| 字段名         | 类型             | 约束           | 说明                 |
| -------------- | ---------------- | -------------- | -------------------- |
| group_id       | BIGINT UNSIGNED  | PK, AUTO_INC   | 群聊唯一标识         |
| name           | VARCHAR(64)      | NOT NULL       | 群聊名称             |
| description    | TEXT             |                | 群描述               |
| avatar_url     | VARCHAR(256)     |                | 群头像               |
| creator_id     | BIGINT UNSIGNED  | NOT NULL       | 创建者ID（逻辑外键） |
| join_verify    | TINYINT(1)       | NOT NULL, DEFAULT 0 | 加入验证         |
| max_member_count | INT            | NOT NULL, DEFAULT 200 | 最大成员数      |
| is_deleted     | TINYINT(1)       | NOT NULL, DEFAULT 0 | 是否已删除       |
| created_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 更新时间 |

### 2.4 用户-群聊关联表 user_group

| 字段名         | 类型             | 约束           | 说明                 |
| -------------- | ---------------- | -------------- | -------------------- |
| user_group_id  | BIGINT UNSIGNED  | PK, AUTO_INC   | 主键                 |
| user_id        | BIGINT UNSIGNED  | NOT NULL       | 用户ID（逻辑外键）   |
| group_id       | BIGINT UNSIGNED  | NOT NULL       | 群聊ID（逻辑外键）   |
| role           | VARCHAR(16)      |                | 用户身份             |
| join_at        | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 加入时间 |
| is_exited      | TINYINT(1)       | NOT NULL, DEFAULT 0 | 是否退出         |
| exit_at        | DATETIME         |                | 退出时间             |
| last_speak_at  | DATETIME         |                | 最后发言时间         |
| is_muted       | TINYINT(1)       | NOT NULL, DEFAULT 0 | 是否禁言         |
| mute_end_at    | DATETIME         |                | 禁言结束时间         |
| is_deleted     | TINYINT(1)       | NOT NULL, DEFAULT 0 | 是否已删除       |
| created_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 更新时间 |

### 2.5 兴趣分类表 hobby_category

| 字段名         | 类型             | 约束           | 说明                 |
| -------------- | ---------------- | -------------- | -------------------- |
| category_id    | BIGINT UNSIGNED  | PK, AUTO_INC   | 兴趣分类唯一标识     |
| title          | VARCHAR(64)      | UNIQUE, NOT NULL | 兴趣分类名称       |
| is_deleted     | TINYINT(1)       | NOT NULL, DEFAULT 0 | 是否已删除       |
| created_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 更新时间 |

### 2.6 兴趣表 hobby

| 字段名         | 类型             | 约束           | 说明                 |
| -------------- | ---------------- | -------------- | -------------------- |
| hobby_id       | BIGINT UNSIGNED  | PK, AUTO_INC   | 兴趣唯一标识         |
| hobby_category_id | BIGINT UNSIGNED | NOT NULL      | 兴趣分类ID（逻辑外键）|
| title          | VARCHAR(64)      | UNIQUE, NOT NULL | 兴趣名称           |
| description    | TEXT             |                | 兴趣描述             |
| is_hot         | TINYINT(1)       | NOT NULL, DEFAULT 0 | 是否热门         |
| is_deleted     | TINYINT(1)       | NOT NULL, DEFAULT 0 | 是否已删除       |
| created_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 更新时间 |

### 2.7 好友关系表 friendship

| 字段名         | 类型             | 约束           | 说明                 |
| -------------- | ---------------- | -------------- | -------------------- |
| friendship_id  | BIGINT UNSIGNED  | PK, AUTO_INC   | 关系唯一标识         |
| user_id        | BIGINT UNSIGNED  | NOT NULL       | 用户ID（逻辑外键）   |
| friend_id      | BIGINT UNSIGNED  | NOT NULL       | 好友ID（逻辑外键）   |
| friend_at      | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 成为好友时间 |
| remark_name    | VARCHAR(64)      |                | 好友备注             |
| is_deleted     | TINYINT(1)       | NOT NULL, DEFAULT 0 | 是否已删除       |
| created_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 更新时间 |

### 2.8 好友请求表 friend_request

| 字段名         | 类型             | 约束           | 说明                 |
| -------------- | ---------------- | -------------- | -------------------- |
| request_id     | BIGINT UNSIGNED  | PK, AUTO_INC   | 请求唯一标识         |
| sender_id      | BIGINT UNSIGNED  | NOT NULL       | 发送者ID（逻辑外键） |
| receiver_id    | BIGINT UNSIGNED  | NOT NULL       | 接收者ID（逻辑外键） |
| request_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 请求发送时间 |
| notes          | TEXT             |                | 请求备注             |
| status         | VARCHAR(16)      | NOT NULL, DEFAULT 'pending' | 请求状态 |
| handle_at      | DATETIME         |                | 处理时间             |
| reject_reason  | TEXT             |                | 拒绝原因             |
| is_deleted     | TINYINT(1)       | NOT NULL, DEFAULT 0 | 是否已删除       |
| created_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 更新时间 |

### 2.9 加群请求表 group_request

| 字段名         | 类型             | 约束           | 说明                 |
| -------------- | ---------------- | -------------- | -------------------- |
| request_id     | BIGINT UNSIGNED  | PK, AUTO_INC   | 请求唯一标识         |
| sender_id      | BIGINT UNSIGNED  | NOT NULL       | 申请人ID（逻辑外键） |
| group_id       | BIGINT UNSIGNED  | NOT NULL       | 群聊ID（逻辑外键）   |
| request_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 申请时间 |
| notes          | TEXT             |                | 申请备注             |
| status         | VARCHAR(16)      | NOT NULL, DEFAULT 'pending' | 请求状态 |
| handler_id     | BIGINT UNSIGNED  |                | 处理人ID（逻辑外键） |
| handle_at      | DATETIME         |                | 处理时间             |
| reject_reason  | TEXT             |                | 拒绝原因             |
| is_deleted     | TINYINT(1)       | NOT NULL, DEFAULT 0 | 是否已删除       |
| created_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 更新时间 |

### 2.10 通知表 notification

| 字段名         | 类型             | 约束           | 说明                 |
| -------------- | ---------------- | -------------- | -------------------- |
| notification_id| BIGINT UNSIGNED  | PK, AUTO_INC   | 通知唯一标识         |
| user_id        | BIGINT UNSIGNED  | NOT NULL       | 接收通知的用户ID（逻辑外键）|
| type           | VARCHAR(32)      | NOT NULL       | 通知类型             |
| content        | TEXT             |                | 通知内容             |
| is_read        | TINYINT(1)       | NOT NULL, DEFAULT 0 | 是否已读         |
| related_id     | BIGINT UNSIGNED  |                | 关联ID               |
| send_at        | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 发送时间 |
| is_deleted     | TINYINT(1)       | NOT NULL, DEFAULT 0 | 是否已删除       |
| created_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at     | DATETIME         | NOT NULL, DEFAULT CURRENT_TIMESTAMP | 更新时间 |

## 3. 逻辑外键关系说明

- user_info.user_id 逻辑外键关联 user.user_id
- chat_group.creator_id 逻辑外键关联 user.user_id
- user_group.user_id 逻辑外键关联 user.user_id
- user_group.group_id 逻辑外键关联 chat_group.group_id
- hobby.hobby_category_id 逻辑外键关联 hobby_category.category_id
- friendship.user_id, friendship.friend_id 逻辑外键关联 user.user_id
- friend_request.sender_id, friend_request.receiver_id 逻辑外键关联 user.user_id
- group_request.sender_id, group_request.group_id, group_request.handler_id 逻辑外键关联 user.user_id/chat_group.group_id
- notification.user_id 逻辑外键关联 user.user_id

## 4. 初始化数据说明

- 兴趣分类和兴趣表已在建表SQL中提供初始化数据插入示例。
- 其他表可根据实际业务需要初始化管理员、系统公告等数据。
