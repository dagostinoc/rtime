# -*- encoding: utf-8 -*-
# stub: rtime 0.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rtime"
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Florian Frank"]
  s.date = "2014-07-14"
  s.description = "Application to time processes in Ruby and Redis"
  s.email = "flori@ping.de"
  s.extra_rdoc_files = ["README.md", "lib/rtime.rb", "lib/rtime/client.rb", "lib/rtime/executor.rb", "lib/rtime/result.rb", "lib/rtime/results_collector.rb", "lib/rtime/timer.rb", "lib/rtime/version.rb"]
  s.files = [".gitignore", ".rspec", ".travis.yml", "Gemfile", "README.md", "Rakefile", "VERSION", "bin/rtime", "lib/rtime.rb", "lib/rtime/client.rb", "lib/rtime/executor.rb", "lib/rtime/result.rb", "lib/rtime/results_collector.rb", "lib/rtime/timer.rb", "lib/rtime/version.rb", "rtime.gemspec", "spec/client_spec.rb", "spec/executor_spec.rb", "spec/result_spec.rb", "spec/results_collector_spec.rb", "spec/spec_helper.rb", "spec/timer_spec.rb"]
  s.homepage = "http://flori.github.com/rtime"
  s.licenses = ["Apache-2.0"]
  s.rdoc_options = ["--title", "Rtime -- Time processes in Ruby and Redis", "--main", "README.md"]
  s.rubygems_version = "2.2.2"
  s.summary = "Application to time processes"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>, ["~> 1.0.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<byebug>, [">= 0"])
      s.add_runtime_dependency(%q<tins>, ["~> 1.0"])
      s.add_runtime_dependency(%q<redis>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<gem_hadar>, ["~> 1.0.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<byebug>, [">= 0"])
      s.add_dependency(%q<tins>, ["~> 1.0"])
      s.add_dependency(%q<redis>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<gem_hadar>, ["~> 1.0.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<byebug>, [">= 0"])
    s.add_dependency(%q<tins>, ["~> 1.0"])
    s.add_dependency(%q<redis>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
  end
end
