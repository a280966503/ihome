#coding=utf-8

import functools
from utils.response_code import RET

def require_logined(fun):
    @functools.wraps(fun)
    def wrapper(request_handler_obj,*args,**kwargs):
        #根据get_current_user方法进行判断，如果返回的不是一个空字典，证明用户已经登录过，保存了用户的session数据

        if request_handler_obj.get_current_user():
            fun(request_handler_obj,*args,**kwargs)
        else:
            print request_handler_obj.get_current_user()
            request_handler_obj.write(dict(errno=RET.SESSIONERR,errmsg="用户未登录"))
    return wrapper