# 接口文档（API DOC）

## 鉴权

### 注册请求

- POST /auth/register/request
- 参数：email
- 返回：{ 200, "ok", null }

### 注册确认
- POST /auth/register/confirm
- 参数：email code hobbys
- 返回：{ 200, "ok", token: {xxx} }

## 用户模块
### 登录

- POST /user/login
- 参数：username/email/phone, password
- 返回：{ 200, "ok", token: {xxx} }

### 获取用户信息

- GET /user/{user_id}
- 返回：{ code, message, data: { ...user } }

### 更新用户信息

- PUT /user/{user_id}
- 参数：nickname, ...
- 返回：{ code, message }
- 备注：保留email和phone更新需要认证的需求

## 兴趣与分类模块

### 获取兴趣分类列表

- GET /hobby-category
- 返回：{ code, message, data: [ ...hobby-category ] }

### 获取兴趣列表

- GET /hobby?category_id=1
- 返回：{ code, message, data: [ ...hobby ] }

## 群聊模块

### 创建群聊

- POST /group
- 参数：name, description, avatar_url, join_verify, max_member_count
- 返回：{ code, message, data: { group_id } }

### 获取群聊信息

- GET /group/{group_id}
- 返回：{ code, message, data: { ...group } }

### 申请加入群聊

- POST /group/{group_id}/join
- 参数：notes
- 返回：{ code, message }

### 审批加群请求

- POST /group-request/{request_id}/handle
- 参数：status (accepted/rejected), reject_reason
- 返回：{ code, message }

## 好友模块

### 发送好友请求

- POST /friend/request
- 参数：receiver_id, notes
- 返回：{ code, message }

### 处理好友请求

- POST /friend-request/{request_id}/handle
- 参数：status (accepted/rejected), reject_reason
- 返回：{ code, message }

### 获取好友列表

- GET /friend
- 返回：{ code, message, data: [ { user_id, nickname, remark_name } ] }

## 通知模块

### 获取通知列表

- GET /notification
- 返回：{ code, message, data: [ { notification_id, type, content, is_read, send_at } ] }

### 标记通知为已读

- POST /notification/{notification_id}/read
- 返回：{ code, message }

## 通用返回格式

- code: 状态码（200成功，非200失败）
- msg: 提示信息
- data: 业务数据
