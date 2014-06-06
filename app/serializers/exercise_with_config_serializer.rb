class ExerciseWithConfigSerializer < ActiveModel::Serializer
  attributes :id, :config

  def config
    object.exercise_configs.last.config
  end
end
