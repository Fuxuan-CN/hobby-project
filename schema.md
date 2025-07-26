# 数据表定义补充说明


## user（用户核心表）
- id：用户唯一标识（主键）
- username：用户名（登录账号，唯一）
- password：密码（加密存储）
- nickname：用户昵称（显示名称，可修改）
- last_login_time：最后登录时间
- is_active：是否激活（账号是否可用，如未激活无法登录）
- create_time：注册时间（账号创建时间）
- email：电子邮箱（用于验证、找回密码）
- phone：手机号码（可选，用于登录或安全验证）
- update_time：信息更新时间（最近一次修改资料的时间）


## user-info（用户详细信息表）
- id：信息记录唯一标识（主键）
- age：年龄（可由出生日期计算，也可直接存储）
- sex：性别（枚举：男/女/保密）
- avatar_url：头像链接
- birthday：出生日期（精确到年月日，用于年龄计算和生日提醒）
- region：所在地区（如“北京市朝阳区”，用于定位或推荐）
- bio：个人简介（用户自我描述）
- user_id：关联user表的id（外键，绑定用户核心信息）


## group（群聊表）
- id：群聊唯一标识（主键）
- is_delete：是否解散（布尔值，解散后不可恢复）
- name：群聊名称（显示名称，可由管理员修改）
- description：群描述（介绍群聊用途、规则）
- avatar_url：群头像（群聊展示图片）
- creator_id：创建者ID（关联user表id，记录建群人）
- create_time：创建时间
- update_time：信息更新时间（群名称、描述等最近修改时间）
- join_verify：加入验证（布尔值，是否需要审核才能入群）
- max_member_count：最大成员数（群聊可容纳的最大用户量）


## user-group（用户-群聊关联表）
- userid：用户ID（关联user表id）
- groupid：群聊ID（关联group表id）
- type：用户在群内身份（枚举：管理员/用户/群主）
- join_time：加入时间
- is_exit：是否退出（布尔值，退出后不再接收群消息）
- exit_time：退出时间（若is_exit为true，记录退出时间）
- last_speak_time：最后发言时间（用户在群内最后一次发言的时间）
- is_muted：是否禁言（布尔值，禁言后无法发送消息）
- mute_end_time：禁言结束时间（若is_muted为true，记录解禁时间）


## hobby（兴趣爱好表）
- id：兴趣唯一标识（主键）
- title：兴趣名称（如“篮球”“摄影”）
- desc：兴趣描述（对该兴趣的简要说明）
- create_time：创建时间（兴趣标签添加时间）
- is_hot：是否热门（布尔值，标识该兴趣是否为热门标签）

## hobby_category （兴趣分类表）
- id：兴趣分类唯一标识（主键）
- title：兴趣分类名称（如“篮球”“摄影”）
- create_time：创建时间（兴趣标签添加时间）

## friendship（好友关系表）
- id：关系唯一标识（主键）
- user_id：用户ID（关联user表id，主动发起关系的一方）
- friend_id：好友ID（关联user表id，被添加为好友的一方）
- friend_time：成为好友时间
- remark_name：好友备注（user_id对friend_id的自定义名称）
- is_delete：是否删除好友（布尔值，删除后解除好友关系）


## friend_request（好友请求表）
- id：请求唯一标识（主键）
- sender_id：发送者ID（关联user表id，发起请求的用户）
- receiver_id：接收者ID（关联user表id，收到请求的用户）
- request_time：请求发送时间
- notes：请求备注（发送者添加的验证信息，如“我是XX班的同学”）
- status：请求状态（枚举：待处理/已同意/已拒绝）
- handle_time：处理时间（接收者同意或拒绝的时间）
- reject_reason：拒绝原因（接收者拒绝时填写的说明，可选）


## group_request（加群请求表）
- id：请求唯一标识（主键）
- sender_id：申请人ID（关联user表id，申请加入群聊的用户）
- group_id：群聊ID（关联group表id，申请加入的群聊）
- request_time：申请时间
- notes：申请备注（申请人添加的验证信息，如“我是XX的朋友”）
- status：请求状态（枚举：待审核/已同意/已拒绝）
- handler_id：处理人ID（关联user表id，审核请求的管理员/群主）
- handle_time：处理时间（同意或拒绝的时间）
- reject_reason：拒绝原因（处理人填写的拒绝说明，可选）


## notification（通知表）
- id：通知唯一标识（主键）
- user_id：接收通知的用户ID（关联user表id）
- type：通知类型（枚举：好友请求/加群请求/群公告/系统通知等）
- notes：通知内容（具体通知信息，如“XX请求添加你为好友”）
- is_read：是否已读（布尔值，未读通知可高亮显示）
- send_time：发送时间（通知生成的时间）
- related_id：关联ID（关联对应事件的ID，如好友请求ID、群公告ID）
- is_delete：是否删除（布尔值，用户删除后不再显示）