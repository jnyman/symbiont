require 'simplecov'

SimpleCov.start do
  add_filter '/spec'
  coverage_dir "#{SimpleCov.root}/spec/reports/coverage"
  minimum_coverage 90
  maximum_coverage_drop 5
end

require 'symbiont'

RSpec.configure do |config|
  original_stderr = $stderr
  original_stdout = $stdout
  config.before(:all) do
    $stderr = File.new(File.join(File.dirname(__FILE__), 'reports/symbiont-output.txt'), 'w')
    $stdout = File.new(File.join(File.dirname(__FILE__), 'reports/symbiont-output.txt'), 'w')
  end
  config.after(:all) do
    $stderr = original_stderr
    $stdout = original_stdout
  end

  config.alias_it_should_behave_like_to :provides_an, 'when providing an'

  shared_context :page do
    let(:watir_browser)        { mock_browser_for_watir }
    let(:selenium_browser)     { mock_browser_for_selenium }

    let(:watir_definition)     { ValidPage.new(watir_browser) }
    let(:selenium_definition)  { ValidPage.new(selenium_browser) }

    let(:empty_definition)     { PageWithMissingAssertions.new(watir_browser) }
    let(:no_driver_definition) { ValidPage.new(:unknown) }
  end

  shared_context :element do
    let(:watir_element) { double('element') }
  end
end

Dir['spec/fixtures/**/*.rb'].each do |file|
  require file.sub(/spec\//, '')
end
