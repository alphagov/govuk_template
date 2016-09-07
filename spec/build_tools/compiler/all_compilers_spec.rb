require 'spec_helper'

# require all the compilers so that they are present in ObjectSpace
Dir["#{PROJECT_ROOT}/build_tools/compiler/*.rb"].each {|file| require file }
def compiler_classes
  return_value = ObjectSpace.each_object(Class).select do |klass|
    klass < Compiler::TemplateProcessor
  end
  return_value.reject { |klass| klass == Compiler::PlainProcessor }
end

describe "compiler_classes test helper method" do
  it "should return more than 1 class" do
    expect(compiler_classes.size).to be > 1
  end
end

describe "Behaviours all compilers must support every value that gets yielded in the templates" do
  compiler_classes.each do |compiler_class|
    describe compiler_class do
      subject { compiler_class.new("dummy filename") }

      uses_of_yield_in_templates.each do |section|
        it "should support #{section} key" do
          expect(subject.handle_yield(section)).not_to be_nil
        end
      end
    end
  end
end

describe 'Integrity attribute values' do
  it 'should be generated correctly' do
    compiler = Compiler::AssetCompiler.new
    content = 'Testing integrity attributes'
    sha = 'sha256-43c990e55eb6eeb7b219b85c158c587617117c9d80c43bd9f362c38c32933c74'
    expect(compiler.send(:generate_integrity_attribute, content)).to eq(sha)
  end

  it 'should be added to the layout template' do
    compiler = Compiler::AssetCompiler.new
    compiler.compile
    output = File.open(repo_root.join('app', 'views', 'layouts', 'govuk_template.html.erb')).read
    expect(output).to match(/integrity="sha256-\h*?"/)
  end
end
