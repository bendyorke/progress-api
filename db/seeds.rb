def log arr
  puts "%02d %-15s seeded" %[arr.count, arr.map(&:class).uniq.first.to_s.pluralize(arr.count)]
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
  "chest" => {
    name: "Bench Press",
    description: "Description of Bench Press",
  }
}.each do |k,v|
  v.merge! exercise_fields: exercise_fields.sample(2),
             muscle_groups: muscle_groups.sample(2),
      primary_muscle_group: muscle_groups.select { |_| _.name == k }.first
end
exercises = %w[chest triceps biceps back legs abs].map do |muscle_group|
  Exercise.create exercise_from_muscle_group[muscle_group]
end
log exercises

# Workout.create
#
workouts = (1...3).map do
  Workout.create exercises: exercises.sample(3)
end
log workouts
