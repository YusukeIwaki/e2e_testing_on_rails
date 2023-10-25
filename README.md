# Utility library for E2E testing on Rails.

For E2E testing your Rails app without Ruby-based engine, you might need to

- Create a test user with FactoryBot
- Mock external API calls and some methods
- Begin/rollback transactions for each test

This gem provides rack middlewared for such purposes.

## Installation

Add this line to your application's Gemfile:

```ruby
group :test do
  gem 'e2e_testing_on_rails', github: 'YusukeIwaki/e2e_testing_on_rails'
end
```

then execute `bundle install`.

## Usage

```
RAILS_ENV=test bundle exec rails s
```

Control endpoints are automatically defined.

### `/__e2e__/factory_bot/create`

```
echo '{ name: "YusukeIwaki", password: "hogehoge" }' | http POST http://localhost:3000/__e2e__/factory_bot/create?name=user
```

This internally calls `FactoryBot.create(:user, name: "YusukeIwaki", password: "hogehoge")` and return the instance as JSON.

```
{
  "id": 123,
  "name": "YusukeIwaki",
  "created_at": "2023-10-25T15:13:35.712Z",
  "updated_at": "2023-10-25T15:13:35.712Z"
}
```

### `/__e2e__/begin_transaction`, `/__e2e__/rollback_transaction`

Just issue `BEGIN` and `ROLLBACK`. Useful for transactional test.

### `/__e2e__/eval`

Allow to evaluate arbitrary Ruby code. Useful for mocking.

```
echo 'SimpleStub.for_instance_method(ApplicationController, :current_user) { User.last }.apply!' | http POST http://localhost:3000/__e2e__/eval
```

```
echo 'SimpleStub.for_instance_method(ApplicationController, :current_user) { User.last }.reset!' | http POST http://localhost:3000/__e2e__/eval
```

[simple_stub](https://github.com/YusukeIwaki/simple_stub) would be the best choice for mocking with this method.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the E2eTestingOnRails project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/e2e_testing_on_rails/blob/master/CODE_OF_CONDUCT.md).
