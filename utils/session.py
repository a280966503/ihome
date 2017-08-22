#coding=utf-8

import uuid
import logging
import json
import config


class Session(object):
    """"""
    def __init__(self,request_handler):
        self.request_handler = request_handler
        self.session_id = request_handler.get_secure_cookie("session_id")
        if not self.session_id:
            #用户第一次访问
            #生成一个session_id,全局唯一
            self.session_id = uuid.uuid4().get_hex()
            self.data = {}
        else:
            #拿到了session_id,去redis中取数据
            json_data = None
            try:
                json_data = request_handler.redis.get("sess_%s" % self.session_id)
            except Exception as e:
                logging.error(e)
                self.data = {}
            if not json_data:
                self.data = {}
            else:
                self.data = json.loads(json_data)


    def save(self):
        json_data = json.dumps(self.data)
        try:
            self.request_handler.redis.setex("sess_%s" % self.session_id,config.session_expires,json_data)
        except Exception as e:
            logging.error(e)
            raise Exception("save session failed")
        else:
            self.request_handler.set_secure_cookie("session_id",self.session_id)

    def clear(self):
        json_data = json.dumps(self.data)
        try:
            self.request_handler.redis.setex("sess_%s" % self.session_id,config.session_expires,json_data)
        except Exception as e:
            logging.error(e)
            raise Exception("save session failed")
        else:
            self.request_handler.set_secure_cookie("session_id",self.session_id)