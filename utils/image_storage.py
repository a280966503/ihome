#coding=utf-8
# flake8: noqa
from qiniu import Auth, put_data, etag, urlsafe_base64_encode
import qiniu.config
#需要填写你的 Access Key 和 Secret Key
access_key = '4kMFmN8dBBq9nzOUmdSyTC7vWs8geI05dlocGhmF'
secret_key = 'n8rGE5p0g6oJU8Erj6pL0Of0VjWJPfaxcyTCjoOc'


def storage(image_data):
    # 构建鉴权对象
    if not image_data:
        return None
    q = Auth(access_key, secret_key)
    # 要上传的空间
    bucket_name = 'deng'
    # 上传到七牛后保存的文件名
    # key = 'my-python-logo.png';
    # 生成上传 Token，可以指定过期时间等
    token = q.upload_token(bucket_name, None, 3600)
    # 要上传文件的本地路径
    #localfile = './sync/bbb.jpg'
    ret, info = put_data(token, None, image_data)
    return ret['key']