#coding=utf-8

import logging
from config import image_url_prefix
from .BaseHandler import BaseHandler
from utils.common import require_logined
from utils.image_storage import storage


import logging

class ProfileHandler(BaseHandler):
    """个人信息"""
    @require_logined
    def get(self):
        user_id = self.session.data['user_id']
        try:
            ret = self.db.get("select up_name,up_mobile,up_avatar from ih_user_profile where up_user_id=%s",user_id)
        except Exception as e:
            logging.error(e)
            return self.write(dict(errno=1,errmsg="没有数据"))
        if ret["up_avatar"]:
            img_url = image_url_prefix + ret["up_avatar"]
        else:
            img_url = None
        self.write(dict(errno=0,errmsg="OK",data=dict(user_id=user_id,name=ret["up_name"],mobile=ret["up_mobile"],avatar=img_url)))


class AvatarHandler(BaseHandler):
    """上传头像"""
    def post(self):
        session_data = self.get_current_user()
        user_id = session_data['user_id']
        try:
            image_data = self.request.files["avatar"][0]["body"]
        except Exception as e:
            #参数出错
            logging.error(e)
            return self.write("")
        try:
            key = img_url = image_url_prefix + storage(image_data)
        except Exception as e:
            logging.error(e)
            return self.write("")

        try:
            self.db.execute("update ih_user_profile set up_avatar = %(avatar)s where up_user_id = %(user_id)s",avatar=key,user_id=user_id)
        except Exception as e:
            logging.error(e)
        return self.write(dict(errno=0,errmsg="图片上传成功",data=key))

