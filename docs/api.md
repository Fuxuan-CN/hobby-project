# 接口文档（API DOC）

## 用户模块

### 注册

- POST /api/users/register
- 参数：username, password, email, phone
- 返回：{ code, message, data: { user_id } }

### 登录

- POST /api/users/login
- 参数：username/email/phone, password
- 返回：{ code, message, data: { token, user_info } }

### 获取用户信息

- GET /api/users/{user_id}
- 返回：{ code, message, data: { ...user } }

### 更新用户信息

- PUT /api/users/{user_id}
- 参数：nickname, email, phone, ...
- 返回：{ code, message }

## 兴趣与分类模块

### 获取兴趣分类列表

- GET /api/hobby-categories
- 返回：{ code, message, data: [ { category_id, title } ] }

### 获取兴趣列表

- GET /api/hobbies?category_id=1
- 返回：{ code, message, data: [ { hobby_id, title, description, is_hot } ] }

## 群聊模块

### 创建群聊

- POST /api/groups
- 参数：name, description, avatar_url, join_verify, max_member_count
- 返回：{ code, message, data: { group_id } }

### 获取群聊信息

- GET /api/groups/{group_id}
- 返回：{ code, message, data: { ...group } }

### 申请加入群聊

- POST /api/groups/{group_id}/join
- 参数：notes
- 返回：{ code, message }

### 审批加群请求

- POST /api/group-requests/{request_id}/handle
- 参数：status (accepted/rejected), reject_reason
- 返回：{ code, message }

## 好友模块

### 发送好友请求

- POST /api/friends/request
- 参数：receiver_id, notes
- 返回：{ code, message }

### 处理好友请求

- POST /api/friend-requests/{request_id}/handle
- 参数：status (accepted/rejected), reject_reason
- 返回：{ code, message }

### 获取好友列表

- GET /api/friends
- 返回：{ code, message, data: [ { user_id, nickname, remark_name } ] }

## 通知模块

### 获取通知列表

- GET /api/notifications
- 返回：{ code, message, data: [ { notification_id, type, content, is_read, send_at } ] }

### 标记通知为已读

- POST /api/notifications/{notification_id}/read
- 返回：{ code, message }

## 通用返回格式

- code: 状态码（0成功，非0失败）
- message: 提示信息
- data: 业务数据
