guard 'rspec', cli: "--color --format Fuubar" do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})          { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb})          { |m| "spec/#{m[1]}_spec.rb" }

  watch('lib/php.treetop')          { "spec/php_spec.rb" }
end
