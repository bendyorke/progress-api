require 'faker'

def seeded arr, desc = nil
  plural_class = arr.map(&:class).uniq.first.to_s.pluralize(arr.count)
  puts "--  Seed#{plural_class}: seeding ".ljust 79, "-"
  puts "|| %-74s||" %["seed_object(:#{plural_class.tableize.singularize})"]
  puts "|| -> %02d %-68s||" %[arr.count, "#{desc || plural_class} seeded"]
  puts "\n\n".rjust 81, "-"
end
# Create Muscle Groups
#
muscle_groups = %w[chest triceps biceps back legs abs].map do |muscle_group|
  MuscleGroup.create name: muscle_group
end
seeded muscle_groups

# Create exercises
#
exercise_fields = { "weight" => "pound",
                    "reps"   => "times",
                    "time"   => "seconds" }
exercise_from_muscle_group = {
  "chest"   => { name: "Bench Press" },
  "triceps" => { name: "Skull Crushers" },
  "biceps"  => { name: "Bicep Curls" },
  "back"    => { name: "Chin ups" },
  "legs"    => { name: "Curls in the Squat Rack" },
  "abs"     => { name: "Sit ups" }
}.each do |k,v|
  v.merge! muscle_groups: muscle_groups.sample(2),
    primary_muscle_group: muscle_groups.select { |_| _.name == k }.first,
                  fields: exercise_fields.to_a.sample(2).to_h,
             description: "Description of #{k}"
end
exercises = %w[chest triceps biceps back legs abs].map do |muscle_group|
  Exercise.create exercise_from_muscle_group[muscle_group]
end
seeded exercises

# Create workouts
#
workouts = (1..4).map do
  Workout.create exercises: exercises.sample(3),
                      name: Faker::Commerce.product_name,
               description: Faker::Lorem.sentence
end
seeded workouts

# Create users
#
users = [(
  User.create first_name: "Ender",
               last_name: "Pup",
                  gender: "Male",
               exercises: [] << exercises.first,
                workouts: [] << workouts.first
)]
users += (1..3).map do |i|
  User.create first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
                  gender: %w|male female|.sample,
               exercises: [exercises[i]],
                workouts: [workouts[i]]
end
users += (4..9).map do
  User.create first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
                  gender: %w|male female|.sample
end
seeded users

# Create follows
#
follows = users.map.with_index do |user|
  workouts.sample.followers.push user
  exercises.sample(3).each { |_| _.followers.push user }
  (users - [user]).sample.followers.push user
  user.followings.to_a
end.flatten
seeded follows

# Fork a workout
#
fork = workouts.sample.fork(user_id: users.first.id)
seeded [fork], "Forked Workout"

# Configure an exercise
#

