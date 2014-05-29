# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, :cmd => "bundle exec rspec" do

  # Spec
  watch('spec/spec_helper.rb')         { "spec" }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})            { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/(.+)\.rb$})            { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$})   { "spec" }

  # Controllers
  watch(%r{^app/controllers/api/(.+)/v1_application_controller.rb$})  { |m| "spec/controllers/#{m[1]}" }
  watch(%r{^app/controllers/api/(.+)/(.+)_(controller)\.rb$})         { |m| "spec/#{m[3]}s/#{m[1]}/#{m[2]}_#{m[3]}_spec.rb" }
end

guard 'migrate' do
  watch(%r{^db/migrate/(\d+).+\.rb})
  watch('db/seeds.rb')
end


guard :bundler do
  watch('Gemfile')
end
