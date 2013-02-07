# Put your step definitions here

Then /^the alias file should be empty\.$/ do
    File.zero? "#{ENV['HOME']}/.alias"
end

Then /^the alias 'second="(.*?)"' should be in the alias file\.$/ do |arg1|
  worked = false
  File.foreach("#{ENV['HOME']}/.alias") do |line|
    worked = true if line=="alias second=\"#{arg1}\""
  end
  return worked
end
