# Put your step definitions here

Then /^the alias file should be empty\.$/ do
    File.zero? "#{ENV['HOME']}/.alias"
end

Then /^the alias "(.*?)" should be in the alias file\.$/ do |arg1|
  worked = false
  File.foreach("#{ENV['HOME']}/.alias") do |line|
    worked = true if line.start_with? "alias #{arg1}"
  end
end

Then /^the alias "(.*?)" should no longer be in the alias file\.$/ do |arg1|
    worked = true
   File.foreach("#{ENV['HOME']}/.alias") do |line|
    worked = false if line.start_with? "alias #{arg1}"
  end 
end
