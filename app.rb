###############################################################################
## Global Variables
###############################################################################
# Global variables for tracking performance and whether the array is sorted.
$sort_cnt = 0
$loop_cnt = 0
$iteration_cnt = 0
$is_array_sorted = nil


###############################################################################
## Helper Functions
###############################################################################
# Numbers sort differently than letters / symbols
def format_val input
  is_number = (Float(input) rescue false || Integer(input) rescue false)
  return is_number ? input.to_f : input
end

# Function to check if the current and next value are sorted
def is_sorted? val, next_val, ascending = true
  result = (ascending && val <= next_val) || (!ascending && val >= next_val)
  is_array_sorted? result
  result
end

# Check if the array so far is already sorted
# Used to skip iterations if we can
def is_array_sorted? is_val_sorted
  # $is_array_sorted starts off as 'nil' to differentiate between a 'false'
  # value and an array that hasn't been touched yet
  is_begin = $is_array_sorted.nil?
  return $is_array_sorted = is_val_sorted if is_begin
  $is_array_sorted = $is_array_sorted && is_val_sorted
end

# Logic to swap values within array
def swap array, idx_1, idx_2
  placeholder = array[idx_1]
  array[idx_1] = array[idx_2]
  array[idx_2] = placeholder
  $sort_cnt += 1
  return array
end

# The actual iteration logic, contained in a method
def iterate array, k, ascending
  return if k == array.length - 1
  val = array[k]
  next_val = array[k + 1]
  is_val_sorted = is_sorted? val, next_val, ascending
  swap array, k, k + 1 unless is_val_sorted
  $loop_cnt += 1
end

# A function to pull input from the user
# Can choose to print spacing, or get input, either or both
def get_user_input print_spacing = false, get_input = true

  # an indicator to mark the user's input in the console
  print "--> "

  result = gets.chomp if get_input

  if print_spacing
      print "\n"
      print "########################################################################\n\n"
      print "\n"
  end

  # Only return the result if we got user input (get_input == true)
  result if get_input
end

def return_user_input message, multi_entry = false, user_options = [':q']
  user_input = nil
  user_selection = nil
  dictionary = []

  # print the user message
  print message

  # ask for input and push it to the dictionary until user option is entered
  # 'q' is a default, it quits entry
  #  you can change 'q' to something else, but 'quit' is always the first option
  until user_options.include? user_selection do
    user_input = get_user_input
    user_selection = user_input if user_options.include? user_input
    dictionary.push format_val user_input unless user_selection
    break unless multi_entry
  end

  # just printing some spacing
  get_user_input true, false

  # create a hash for the return result
  result = { user_option: user_selection, dictionary: dictionary}

  # return results for processing
  return result[:dictionary].empty? ? result[:user_option] : result
end


###############################################################################
## Main Function
###############################################################################
def bubble_sort
  # Print a nice intro message
  print "########################################################################\n"
  print "##############################Bubble Sort###############################\n"
  print "########################################################################\n\n"

  # get inputs
  get_array_msg =  <<-STRING
  -> Enter each value you want to sort."
     Input 'q' when you have entered all of your values:"

  STRING
  array = return_user_input(get_array_msg, true)[:dictionary]

  get_sort_order_msg =  <<-STRING
  -> Do you want to sort in ascending or descending order?
     Input 'a' or 'd' (or 'q' to quit):

  STRING
  sort_order = return_user_input get_sort_order_msg, false, [':q','a','d']
  return puts "See ya!" if sort_order == ':q'
  ascending = sort_order == 'a'

  # iteration logic for the bubble sort algorithm
  i = 0
  j = array.length - i
  until $is_array_sorted || j < 0
    (0..j).each { |k| iterate array, k, ascending if k <= array.length - 1 }
    break if $is_array_sorted
    i += 1
    j = array.length - i - 1
    $iteration_cnt += 1
  end

  #print results
  print """The bubble sort processed #{$sort_cnt} swaps out of #{$loop_cnt} checks in #{$iteration_cnt} iterations.\n"""
  array
end


###############################################################################
## Call Function
###############################################################################
bubble_sort
