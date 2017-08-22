#coding=utf-8

import os

#Application配置参数
settings={
    "static_path": os.path.join(os.path.dirname(__file__),"static"),
    "template_path":os.path.join(os.path.dirname(__file__),"template"),
    "cookie_secret":"dengyuangyang344543tlfkdsjosdfweidfsd3367",
    "xsrf_cookies":True,
    "debug":True,
}

#mysql配置参数
mysql_options =dict(
    host = "127.0.0.1",
    database = "ihome",
    user = "root",
    password = "mysql"
)

#redis
redis_options=dict(
    host="127.0.0.1",
    port=6379
)

#log path
log_file = os.path.join(os.path.dirname(__file__),"logs/log")
log_level = "debug"

session_expires = 86400 #session有效期
passwd_hash_key = "tertergvdrfs"

#image_url_prefix = "http://o91qujnqh.bkt.clouddn.com/" # 七牛存储空间的域名
image_url_prefix = "http://ov15hi1qv.bkt.clouddn.com/"