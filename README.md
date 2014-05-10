BlogApi
=======

用Ruby构建Blog Api之Grape

## How to Install

```bash
git clone git@github.com:agilejzl/BlogApi.git
cd BlogApi
ruby setup.rb
# 请确保mysql已经启动
rails s
```

## 接口访问示例

查询所有: 
```bash
curl -X GET 'http://blog-api.herokuapp.com/v2/articles'
```

查询单个: 
```bash
curl -X GET 'http://blog-api.herokuapp.com/v2/articles/1'
```

创建单个: 
```bash
curl -X POST -d '{"author_name": "zs","article":{"title": "haha", "content": "88 characters"}}' 'http://blog-api.herokuapp.com/v2/articles' -H Content-Type:application/json
```

更新单个: 
```bash
curl -X PUT -d '{"author_name": "ww","article":{"title": "haha2", "content": "no more"}}' 'http://blog-api.herokuapp.com/v2/articles/1' -H Content-Type:application/json
```

删除单个: 
```bash
curl -X DELETE 'http://blog-api.herokuapp.com/v2/articles/1'
```

## How to Test

Models and Api tests: 
```bash
rspec spec/models && rspec spec/app
```
