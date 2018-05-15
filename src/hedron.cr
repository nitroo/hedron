require "./hedron/exception/*"
require "./hedron/menu/*"
require "./hedron/parser/parser.cr"
require "./hedron/struct/*"
require "./hedron/ui/*"
require "./hedron/ui/widget/*"

# This code uses a custom libui, so the fileshere only apply to this specific
# fork.
# I thought adding these files into 'src/hedron' would be confusing.
require "./hedron-ext/ui/tree"
require "./hedron-ext/ui/table"