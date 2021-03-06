require "../bindings.cr"
require "./menu_item.cr"

module Hedron
  class Menu
    @this : UI::Menu*

    def initialize(name : String)
      @this = UI.new_menu(name)
    end

    def add(item : SuperMenuItem)
      item.add_menu(to_unsafe)
    end

    def add_all(*items : SuperMenuItem)
      items.each { |item| add(item) }
    end

    def add_separator
      UI.menu_append_separator(to_unsafe)
    end

    def add_quit
      UI.menu_append_quit_item(to_unsafe)
      return
    end

    def add_preferences
      UI.menu_append_preferences_item(to_unsafe)
      return
    end

    def add_about
      UI.menu_append_about_item(to_unsafe)
      return
    end

    def to_unsafe
      @this
    end
  end
end
