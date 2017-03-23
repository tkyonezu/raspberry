#!/usr/bin/env ruby
#-*- encoding:utf-8 -*-

if ARGV.length != 1 then
  STDERR.puts "Invalid arguments"
  exit(1)
end
WIKI_DIR = ARGV[0]
GOLLUM_PATH="/usr/local/bin/gollum"

def init_wiki_dir?(dir)
  File.exists?(dir + File::Separator + ".git")
end

def init_wiki_dir(dir)
  Dir.chdir(dir)
  `git init .`
end

def run_server(dir)
  Dir.chdir(dir)
  `#{GOLLUM_PATH} --port 4567 --mathjax`
end

if init_wiki_dir?(WIKI_DIR)
  run_server(WIKI_DIR)
else
  init_wiki_dir(WIKI_DIR)
  run_server(WIKI_DIR)
end
