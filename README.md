[ ![Codeship Status for sesharim/rails-api-example](https://codeship.com/projects/3ccca7d0-4781-0133-ebfa-7a3d06ec36a2/status?branch=master)](https://codeship.com/projects/105043)

## Goal:

- It's API (REST, JSON);
- It's secured by basic auth (token);
- It's contain User mode - with different roles (admin, user, guest);
- It's limit access to given part of API depending on User role;
- Admin has access to everything;
- User can read all, create all, but update and deleted only his records;
- Guest has only read access;
- There should be at least 2 different models except User;
- Those models should be in relation (1 to many);
- Tests for API;

## Run app:

- ```rake db:create```
- ```rake db:migrate```
- ```rake db:seed```

## Run tests:

- ```bundle exec rspec spec/```

## CRUD API Requests (BE SURE THAT TOKEN IS ACTUAL!):

* POST: ```curl -v -H "Accept: application/json" -H "Content-type: application/json" -H "Authorization: Token token=2c1c078385c93135faa2c0682006f2257e2bb0aa" -X POST -d '{"article":{"title":"hello world","content":"this is content","user_id":"1"}}' http://localhost:3000/api/v1/articles```

* GET: ```curl -i -H "Accept: application/json" -H 'Accept: application/json' -H "Authorization: Token token=2c1c078385c93135faa2c0682006f2257e2bb0aa" http://localhost:3000/api/v1/articles```

* GET: ```curl -i -H "Accept: application/json" -H 'Accept: application/json' -H "Authorization: Token token=2c1c078385c93135faa2c0682006f2257e2bb0aa" http://localhost:3000/api/v1/articles/1```

* PUT: ```curl -H 'Content-Type: application/json' -H 'Accept: application/json' -H "Authorization: Token token=f266c96657556a58341894c5752187d3d65824d3" -X PUT -d '{"article":{"title":"hello world","content":"this is content"}}' http://localhost:3000/api/v1/articles/1```

* DELETE: ```curl -i -H "Accept: application/json" -H "Content-type: application/json" -H "Authorization: Token token=2c1c078385c93135faa2c0682006f2257e2bb0aa" -X DELETE http://localhost:3000/api/v1/articles/1```
