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
def test_array
  [5,4,3,2,1]
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


###############################################################################
## Main Function
###############################################################################
def bubble_sort array, ascending = true
  i = 0
  j = array.length - i
  until $is_array_sorted || j < 0
    (0..j).each { |k| iterate array, k, ascending if k <= array.length - 1 }
    break if $is_array_sorted
    i += 1
    j = array.length - i - 1
    $iteration_cnt += 1
  end
  print """The bubble sort processed #{$sort_cnt} swaps out of #{$loop_cnt} checks in #{$iteration_cnt} iterations.\n"""
  array
end


###############################################################################
## Call Function
###############################################################################
bubble_sort test_array,true