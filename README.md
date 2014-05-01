BlogApi
=======

用Ruby构建Blog Api之Grape

## Install

```bash
git clone git@github.com:agilejzl/BlogApi.git
cd BlogApi
ruby setup.rb
# 请确保mysql已经启动
rails s
```

## Article接口访问示例

查询所有: 
```bash
curl -X GET 'http://localhost:3000/v1/articles'
```

查询单个: 
```bash
curl -X GET 'http://localhost:3000/v1/articles/1'
```

创建单个: 
```bash
curl -X POST -d '{"author_name": "zs","article":{"title": "haha", "content": "88 characters"}}' 'http://localhost:3000/v1/articles' -H Content-Type:application/json
```

更新单个: 
```bash
curl -X PUT -d '{"author_name": "ww","article":{"title": "haha2", "content": "no more"}}' 'http://localhost:3000/v1/articles/1' -H Content-Type:application/json
```

删除单个: 
```bash
curl -X DELETE 'http://localhost:3000/v1/articles/1'
```
