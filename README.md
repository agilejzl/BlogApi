BlogApi
=======

用Ruby构建Blog Api之Grape

1. Curl访问Article接口示例

查询所有 <tt>curl -X GET 'http://localhost:3000/v1/articles'</tt>

查询单个 <tt>curl -X GET 'http://localhost:3000/v1/articles/1'</tt>

创建单个 <tt>curl -X POST -d '{"author_name": "zs","article":{"title": "haha", "content": "88 characters"}}' 'http://localhost:3000/v1/articles' -H Content-Type:application/json</tt>

更新单个 <tt>curl -X PUT -d '{"author_name": "ww","article":{"title": "haha2", "content": "no more"}}' 'http://localhost:3000/v1/articles/1' -H Content-Type:application/json</tt>

删除单个 <tt>curl -X DELETE 'http://localhost:3000/v1/articles/1'</tt>
