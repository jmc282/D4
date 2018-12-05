require_relative 'graph.rb'
require_relative 'finder.rb'

# Prints the usage message to STDOUT and then exit the program
# exits with code 1 to indicate there was an error

def show_usage_and_exit
  puts "Usage:\nruby word_finder.rb *graphfile*"
  # puts "Could not access file"
  exit 1
end

# Prints the nonexistent file message to STDOUT and then exit the program
# exits with code 1 to indicate there was an error

def show_file_error_and_exit
  puts 'Could not access file'
  exit 1
end

# Returns true if and only if:
# 1. There is exactly one argument
# Returns false otherwise

def valid_num_args?(args)
  args.count == 1
rescue StandardError
  false
end

# EXECUTION STARTS HERE

# If arguments are valid, create a new game using *seed* and *num_players* arguments, and play the game
# Otherwise, show proper usage message and exit program

show_usage_and_exit unless valid_num_args?(ARGV)
show_usage_and_exit unless File.file?(ARGV[0])
find_words(ARGV[0])
