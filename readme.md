# Tinder API
Really simple API developed with Ruby and Sinatra. CORS enabled.

API can be tested at
- http://tinder-api.herokuapp.com/people
- http://tinder-api.herokuapp.com/person/1

## API Endpoints

GET /people

```json
[
  {
    "id": 1,
    "created_at": "2015-02-10T20:31:08+01:00",
    "name": "Zilla",
    "gender": "female",
    "age": 24,
    "description": "Not sure if serious…",
    "avatar": "http://xoart.link/200/200/woman/22"
  },
  {
    "id": 2,
    "created_at": "2015-02-10T20:31:08+01:00",
    "name": "Nach",
    "gender": "male",
    "age": 32,
    "description": "I like pizza",
    "avatar": "http://xoart.link/200/200/man/22"
  }
]
```

GET /person/1

```json
{
  "id": 1,
  "created_at": "2015-02-10T20:31:08+01:00",
  "name": "Zilla",
  "gender": "female",
  "age": 24,
  "description": "Not sure if serious…",
  "avatar": "http://xoart.link/200/200/woman/22"
}
```

## To run the app

    $ bundle install --without production
    $ bundle exec rackup

## Acknowledgments

Using code by [sklise/sinatra-api-example](https://github.com/sklise/sinatra-api-example) and [sklise/Sinatra-Heroku-Template](https://github.com/sklise/Sinatra-Heroku-Template).

## License

MIT