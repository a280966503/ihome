CREATE DATABASES ihome DEFAULT CHARACTER SET utf8;

CREATE TABLE ih_user_profile(
  up_user_id bigint unsigned not NULL  auto_increment comment '用户ID',
  up_name VARCHAR(32) not null comment '昵称',
  up_mobile char(11) not NULL comment '手机号',
  up_passwd VARCHAR(64) not null comment '密码',
  up_real_name varchar(32) null comment '真实姓名',
  up_id_cart varchar(20) null comment '身份证号',
  up_avatar varchar(128) null comment '用户头像',
  up_admin tinyint not null DEFAULT '0' comment '是否是管理员，0-不是,1-是',
  up_utime datetime not null DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP comment '最后更新时间',
  up_ctime datetime not null DEFAULT CURRENT_TIMESTAMP comment '创建时间',
  PRIMARY KEY (up_user_id),
  UNIQUE (up_name),
  UNIQUE (up_mobile)
)engine=InnoDB auto_increment=10000 DEFAULT charset=utf8 comment='用户信息表';

CREATE TABLE ih_area_info (
  ai_area_id bigint unsigned not NULL auto_increment comment '区域id',
  ai_name VARCHAR(32) NOT NULL comment '区域名称',
  ai_ctime datetime not null DEFAULT CURRENT_TIMESTAMP comment '创建时间',
  PRIMARY KEY (ai_area_id)
)engine=InnoDB DEFAULT charset=utf8 comment='房源区域表';

CREATE TABLE ih_house_info (
  hi_house_id bigint unsigned not null auto_increment comment '房屋id',
  hi_user_id bigint unsigned not null comment '用户ID',
  hi_title varchar(64) not null comment '房屋名称',
  hi_price int unsigned not null DEFAULT '0' comment '房屋价格，单位分',
  hi_area_id bigint unsigned not null comment '房屋区域ID',
  hi_address VARCHAR(512) not null DEFAULT '' comment '地址',
  hi_room_count tinyint unsigned not null DEFAULT '1' comment '房间数',
  hi_acreage int unsigned unsigned not null DEFAULT '0' comment '房屋面积',
  hi_house_unit varchar(32) not null DEFAULT '' comment '房屋户型',
  hi_capacity int unsigned not null DEFAULT '1' comment '容纳人数',
  hi_beds varchar(64) not null DEFAULT '' comment '床的配置',
  hi_deposit int unsigned not NULL  DEFAULT '0' comment '押金，单位分',
  hi_min_days int unsigned not null DEFAULT '1' comment '最短入住时间',
  hi_max_days int unsigned not null DEFAULT '0' comment '最长入住时间,0-不限制',
  hi_order_count int unsigned not null DEFAULT '0' comment '下单数量',
  hi_verify_status tinyint not null DEFAULT '0' comment '审核状态，0-待审核，１－审核未通过，２－审核通过',
  hi_online_status tinyint not null DEFAULT '1' comment '0-下线，１－上线',
  hi_index_image_url VARCHAR(256) null comment '房屋主图url',
   hi_utime datetime not null default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP comment '最后更新时间',
   hi_ctime datetime not null DEFAULT CURRENT_TIMESTAMP comment '创建时间',
   PRIMARY KEY (hi_house_id),
   KEY `hi_status` (hi_verify_status,hi_online_status),
   CONSTRAINT FOREIGN KEY (`hi_user_id`) REFERENCES `ih_user_profile` (`up_user_id`),
   CONSTRAINT FOREIGN KEY (`hi_area_id`) REFERENCES `ih_area_info` (`ai_area_id`)
 )engine=InnoDB DEFAULT charset=utf8 comment='房屋信息表';

CREATE table ih_house_facility (
  hf_id bigint unsigned not null auto_increment comment '自增id',
  hf_house_id bigint unsigned not null comment '房屋id',
  hf_facility_id int unsigned not null comment '房屋设施',
  hf_ctime datetime not null DEFAULT CURRENT_TIMESTAMP comment '创建时间',
  PRIMARY KEY (hf_id),
  CONSTRAINT FOREIGN KEY (`hf_house_id`) REFERENCES `ih_house_info` (`hi_house_id`)
)engine=InnoDB DEFAULT charset=utf8 comment='房屋设施表';

CREATE TABLE ih_facility_catelog (
  fc_id int unsigned not null auto_increment comment '自增id',
  fc_name varchar(32) not null comment '设施名称',
  fc_ctime datetime not null DEFAULT CURRENT_TIMESTAMP comment '创建时间',
  PRIMARY KEY (fc_id)
)engine=InnoDB DEFAULT charset=utf8 comment='设施型录表';

CREATE TABLE ih_order_info (
  oi_order_id bigint unsigned not null auto_increment comment '订单id',
  oi_user_id bigint unsigned not null comment '用户id',
  oi_house_id bigint unsigned not null comment '房屋id',
  oi_begin_date date not null comment '入住时间',
  oi_end_date date not null comment '离开时间',
  oi_days int unsigned not null comment '入住天数',
  oi_house_price int unsigned not null comment '房屋单价,单位分',
  oi_amount int unsigned not null comment '订单金额，单位分',
  oi_status tinyint not null DEFAULT '0' comment '订单状态，０－待接单，１－待支付，２－已支付，３－待评价，４－已完成，５－已取消，６－拒接单',
  oi_comment text null comment '订单评论',
  oi_utime datetime not null DEFAULT CURRENT_TIMESTAMP on UPDATE CURRENT_TIMESTAMP comment '最后更新时间',
  oi_ctime datetime not null DEFAULT CURRENT_TIMESTAMP comment '创建时间',
  PRIMARY KEY (oi_order_id),
  KEY `oi_status`(oi_status),
  CONSTRAINT FOREIGN KEY (`oi_user_id`) REFERENCES `ih_user_profile` (`up_user_id`),
  CONSTRAINT FOREIGN KEY (`oi_house_id`) REFERENCES `ih_house_info` (`hi_house_id`)
)engine=InnoDB DEFAULT charset =utf8 comment='订单表';

CREATE TABLE ih_house_image(
  hi_image_id bigint unsigned not null auto_increment comment '图片id',
  hi_house_id bigint unsigned not null comment '房屋id',
  hi_url varchar(256) not null comment '图片url',

  hi_ctime datetime not null DEFAULT CURRENT_TIMESTAMP comment '创建时间',
  PRIMARY KEY (hi_image_id),
  CONSTRAINT FOREIGN KEY (hi_house_id) REFERENCES ih_house_info (hi_house_id)
)engine=InnoDB DEFAULT charset=utf8 comment='房屋图片表';