#  jianmu-runner-acme-ssl

### 介绍

自动颁发和更新免费证书

### 阿里云

#### 输入参数

```
domain: 域名
email: 邮箱
dns_check: 是否通过公共dns进行检查
wget_use: 颁发证书时是否使用wget
ali_key: 阿里云key
ali_secret: 阿里云密钥
```

####  构建docker镜像

```
# 创建docker镜像
docker build -t jianmudev/jianmu-runner-acme-ssl-aliyun:${version} -f dockerfile/Dockerfile_aliyun .

# 上传docker镜像
docker push jianmudev/jianmu-runner-acme-ssl-aliyun:${version}
```

####  用法

```
docker run --rm \
  -e JIANMU_DOMAIN=xxx \
  -e JIANMU_EMAIL=xxx \
  -e JIANMU_DNS_CHECK=xxx \
  -e JIANMU_WGET_USE=xxx \
  -e JIANMU_ALI_KEY=xxx \
  -e JIANMU_ALI_SECRET=xxx \
  jianmudev/jianmu-runner-acme-ssl-aliyun:${version}
```

### 华为云

> 待完善

### 腾讯云

> 待完善
