module Hedron
  class Form < Widget
    include ControlMethods

    def initialize
      @this = UI.new_form
    end

    def add(label : String, control : Control)
      UI.form_append(to_unsafe, label.to_unsafe, ui_control(control.to_unsafe), @stretchy ? 1 : 0)
    end

    def to_unsafe
      @this
    end
  end
end