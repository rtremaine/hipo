# A sample Guardfile
# More info at https://github.com/guard/guard#readme

#guard 'rake', :task => 'test:units' do
#  watch(%r{^app/models/.+$})
#end

guard 'rake', :task => 'test:integration' do
  watch(%r{^test/integration/.+$})
  watch(%r{^app/views/.+$})
end

guard 'rake', :task => 'test:functionals' do
  watch(%r{^test/functional/.+$})
end

guard 'rake', :task => 'test' do
  watch(%r{^test/fixtures/.+$})
end

#guard 'rake', :task => 'test:functionals' do
#  watch(%r{^app/integration/.+$})
#end
