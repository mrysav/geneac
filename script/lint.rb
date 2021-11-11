#!/usr/bin/env ruby
# frozen_string_literal: true

require 'open3'

changed_files = `git diff --name-only`.lines
untracked_files = `git ls-files --others --exclude-standard`.lines

files_to_lint = changed_files + untracked_files

RUBY = /\.ruby|\.rake|\.rb$|^Gemfile$/.freeze
MARKDOWN = /\.md/.freeze
CLOUDFORMATION = %r{script/geneac-aws\.yml}.freeze
VENDOR = %r{vendor/}.freeze

unchecked_files = []
all_pass = true

def run_linter(name, file)
  command = "#{name} #{file}"
  stdout, stderr, status = Open3.capture3(command)
  [command, status.success?, [stdout, stderr].join("\n")]
end

files_to_lint.each do |f|
  next if VENDOR.match(f)

  if RUBY.match(f)
    command, success, output = run_linter('rubocop', f)
  elsif MARKDOWN.match(f)
    command, success, output = run_linter('markdownlint', f)
  elsif CLOUDFORMATION.match(f)
    command, success, output = run_linter('cfn-lint', f)
  else
    unchecked_files << f
    next
  end

  all_pass &&= success

  if success
    puts "\n✅ #{command}"
  else
    puts "\n❌ #{command}"
    puts output
  end
end

if unchecked_files.any?
  puts "\nThe following files were not checked:"
  unchecked_files.each do |file|
    puts "- #{file}"
  end
end

if all_pass
  puts "\nAll required checks passed!"
  exit(0)
else
  puts "\nSome changed files failed required checks. See above for details."
  exit(1)
end
