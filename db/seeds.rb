require 'faker'

def log arr
  plural_class = arr.map(&:class).uniq.first.to_s.pluralize(arr.count)
  puts "--  Seed#{plural_class}: seeding ".ljust 79, "-"
  puts "|| %-74s||" %["seed_object(:#{plural_class.tableize.singularize})"]
  puts "|| -> %02d %-68s||" %[arr.count, "#{plural_class} seeded"]
  puts "\n\n".rjust 81, "-"
end
# Create Muscle Groups
#
muscle_groups = %w[chest triceps biceps back legs abs].map do |muscle_group|
  MuscleGroup.create name: muscle_group
end
log muscle_groups

# Create ExerciseFields
#
unit_from_name = { "weight" => "pound",
                   "reps"   => "times",
                   "time"   => "seconds" }
exercise_fields = %w[weight reps time].map do |exercise_field|
  ExerciseField.create name: exercise_field,
                       unit: unit_from_name[exercise_field]
end
log exercise_fields

# Create exercises
#
exercise_from_muscle_group = {
  "chest"   => { name: "Bench Press" },
  "triceps" => { name: "Skull Crushers" },
  "biceps"  => { name: "Bicep Curls" },
  "back"    => { name: "Chin ups" },
  "legs"    => { name: "Curls in the Squat Rack" },
  "abs"     => { name: "Sit ups" }
}.each do |k,v|
  v.merge! exercise_fields: exercise_fields.sample(2),
             muscle_groups: muscle_groups.sample(2),
      primary_muscle_group: muscle_groups.select { |_| _.name == k }.first,
               description: "Description of #{k}"
end
exercises = %w[chest triceps biceps back legs abs].map do |muscle_group|
  Exercise.create exercise_from_muscle_group[muscle_group]
end
log exercises

# Create workouts
#
workouts = (1..4).map do
  Workout.create exercises: exercises.sample(3)
end
log workouts

# Create users
#
users = (0..2).map do |i|
  User.create first_name: Faker::Name.first_name,
               last_name: Faker::Name.last_name,
                  gender: %w|male female|.sample,
               exercises: [exercises[i]],
                workouts: [workouts[i]]
end
admin = User.create first_name: "Ender",
                     last_name: "Pup",
                        gender: "Male",
                     exercises: exercises[users.length..-1],
                      workouts: workouts[users.length..-1]
users << admin
log users

# Create follows
#
follows = users.map.with_index do |user|
  workouts.sample.followers.push user
  exercises.sample(3).each { |_| _.followers.push user }
  (users - [user]).sample.followers.push user
end
