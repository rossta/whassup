namespace :whassup do
  task :setup do
    require 'whassup'
  end
  
  desc "Run all defined uptime checks"
  task :check => :setup do
    Whassup.check_all
  end

  desc "List all uptime checks"
  task :list => :setup do
    puts Whassup.locations.join("\n")
  end
  
  desc "Run whassup process"
  task :run => :setup do
    while true do
      Rake::Task["whassup:list"].execute
      Rake::Task["whassup:check"].execute
      sleep 60
    end
  end

end