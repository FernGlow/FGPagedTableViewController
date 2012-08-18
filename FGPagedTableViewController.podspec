Pod::Spec.new do |s|
  s.name         = "FGPagedTableViewController"
  s.version      = "0.1.0"
  s.summary      = "FGPagedTableViewController is a UITableViewController subclass that adds status and manual paging functionality."
  s.homepage     = "http://github.com/FernGlow/FGPagedTableViewController"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Andrew Michaelson" => "andrew@fernglow.com" }
  s.source       = { :git => "http://github.com/FernGlow/FGPagedTableViewController.git", :tag => "0.1.0" }
  s.platform     = :ios, '5.0'
  s.source_files = 'FGPagedTableViewController/*'
  s.preserve_paths = ['FGPagedTableViewController', 'README.md', 'LICENSE']
  s.requires_arc = true
end