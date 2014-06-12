require 'faker'

FactoryGirl.define do

  factory :user do
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.last_name  }
    email         { Faker::Internet.email  }
    gender        { %w[male female].sample }

    factory :user_with_password do
       ignore     { password 'secure password' }

      after(:create) do |user, e|
        create :password_registration, user: user, password: e.password
      end
    end

    factory :user_with_workouts do
      ignore      { workout_count 3 }

      after(:create) do |user, e|
        create_list(:workout, e.workout_count, user: user)
      end
    end

    factory :user_with_workouts_with_exercises do
      ignore      { workout_count 3  }
      ignore      { exercise_count 3 }

      after(:create) do |user, e|
        create_list(:workout_with_exercises, e.workout_count, user: user)
      end
    end


    factory :user_with_exercises do
      ignore      { exercise_count 3 }

      after(:create) do |user, e|
        create_list(:exercise, e.exercise_count, user: user)
      end
    end
  end

  factory :workout do
    name          { Faker::Commerce.product_name }
    description   { Faker::Lorem.paragraph       }
    association :user, factory: :user

    factory :workout_with_exercises do
      ignore      { exercise_count 3    }

      after(:create) do |w, e|
        create_list(:exercise, e.exercise_count, workouts: [w])
      end
    end
  end

  factory :exercise do
    name          { Faker::Commerce.product_name }
    description   { Faker::Lorem.paragraph       }
    association :user, factory: :user
  end

  factory :exercise_config do
    config        { {} }
  end

  factory :muscle_group do
    sequence(:name) { |i| %w[chest biceps triceps back legs abs shoulders][i] }
  end

  factory :registration do
    factory :password_registration do
      strategy      'password'
      password_hash 'secure password'
    end
  end

  factory :token do
    association :user, factory: :user
  end

  factory :entry do
    association :user, factory: :user
    association :workout, factory: :workout
    association :exercise, factory: :exercise
  end
end
