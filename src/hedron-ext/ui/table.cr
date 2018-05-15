require "../../hedron"

module Hedron
  class NTable
  end
end

{% if Hedron.has_constant? :Table %}
  puts "[HedronExt WARNING] Hedron::Table defined. nitroo-ext version at Hedron::NTable"
{% else %}
  Table = NTable
{% end %}

