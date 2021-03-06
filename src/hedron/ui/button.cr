require "../bindings.cr"
require "./control/*"
require "./widget/*"

module Hedron
  class Button < Widget
    include ControlMethods

    @@box : Void*?

    @this : UI::Button*

    def initialize(text : String)
      @this = UI.new_button(text)
    end

    def self.init_markup(args : MLArgs)
      return self.new(args["text"].as(String))
    end

    def on_click(&block : Button ->)
      self.on_click = block
    end

    def on_click=(proc : Proc(Button, Nil))
      boxed_data = ::Box.box(proc)
      @@box = boxed_data
      @@button = self

      new_proc = ->(button : UI::Button*, data : Void*) {
        callback = ::Box(Proc(Button, Nil)).unbox(data)
        callback.call(@@button.not_nil!)
      }

      UI.button_on_clicked(to_unsafe, new_proc, boxed_data)
    end

    def text : String
      return UI.button_text(to_unsafe)
    end

    def text=(button_text : String)
      UI.button_set_text(to_unsafe, button_text)
    end

    def set_attribute(key : String, value : Any)
      gen_attributes({"stretchy" => Bool, "text" => String})
    end

    def to_unsafe
      return @this
    end
  end
end