# Input file containing variable blocks to parameterize configurations. They allow to input custom values for the variables in the configuration files.
#
# The file has the following structure:
#
# variable "input_name" {
#    description = "A description of what the variable is."
#    type        = the type of the variable (for example string, number, bool, list, map) 
#  }
#
# An example is the following:
#
# variable "product_name" {
#    description = "The name of the product."
#    type        = string
#  }