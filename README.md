BlogApi
=======

用Ruby构建Blog Api之Grape

查询所有 curl -X GET 'http://localhost:3000/v1/articles'
查询单个 curl -X GET 'http://localhost:3000/v1/articles?id=1'
创建单个 curl -d '{"title": "haha", "content": "88 characters", "author_id": "1"}' 'http://localhost:3000/v1/articles' -H Content-Type:application/json
<!-- curl -X POST 'http://localhost:3000/v1/articles?title=haha&content=suoga&author_id=1' -->
更新单个 curl -X PUT -d '{"id": 1, "title": "haha2", "content": "no more", "author_id": "1"}' 'http://lalhost:3000/v1/articles' -H Content-Type:application/json
删除单个 curl -X DELETE 'http://localhost:3000/v1/articles?id=1'
