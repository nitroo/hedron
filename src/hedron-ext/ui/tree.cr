require "../../hedron"

module Hedron
  class NTree
  end
end

{% if Hedron.has_constant? :Tree %}
  puts "[HedronExt WARNING] Hedron::Tree defined. nitroo-ext version at Hedron::NTree"
{% else %}
  Tree = NTree
{% end %}

