require "../src/hedron.cr"

class ControlGallery
  def on_closing(this)
    this.destroy
    @@app.not_nil!.stop
    return false
  end

  def should_quit
    @@mainwin.not_nil!.destroy
    return true
  end

  def open_clicked(this)
    mainwin = @@mainwin.not_nil!
    filename = @@app.not_nil!.open_file(mainwin)

    if filename.nil?
      mainwin.error(title: "No file selected", description: "Don't be alarmed!")
    else
      mainwin.message(title: "File selected", description: filename)
    end
  end

  def save_clicked(this)
    mainwin = @@mainwin.not_nil!
    filename = @@app.not_nil!.save_file(mainwin)

    if filename.nil?
      mainwin.error(title: "No file selected", description: "Don't be alarmed!")
    else
      mainwin.message(title: "File selected (don't worry, it's still there)", description: filename)
    end
  end

  def on_spinbox_changed(this)
    value = this.value
    @@slider.not_nil!.value = value
    @@progressbar.not_nil!.value = value
  end

  def on_slider_changed(this)
    value = this.value
    @@spinbox.not_nil!.value = value
    @@progressbar.not_nil!.value = value
  end

  def initialize
    @@app = Hedron::Application.new
    app = @@app.not_nil!

    file_menu = Hedron::Menu.new("File")
    open = Hedron::MenuItem.new("Open", on_click: ->open_clicked(Hedron::MenuItem))
    save = Hedron::MenuItem.new("Save", on_click: ->save_clicked(Hedron::MenuItem))

    file_menu.add_all(open, save)
    file_menu.add_quit
    app.on_stop = ->should_quit

    edit_menu = Hedron::Menu.new("Edit")
    checkable = Hedron::MenuCheckItem.new("Checkable item")

    edit_menu.add(checkable)
    edit_menu.add_separator

    disabled = Hedron::MenuItem.new("Disabled Item")
    disabled.disable

    edit_menu.add(disabled)
    edit_menu.add_preferences

    help_menu = Hedron::Menu.new("Help")
    help = Hedron::MenuItem.new("Help")

    help_menu.add(help)
    help_menu.add_about

    @@mainwin = Hedron::Window.new("Hedron Control Gallery", {640, 480}, menubar: true)
    mainwin = @@mainwin.not_nil!
    mainwin.margined = true
    mainwin.on_close = ->on_closing(Hedron::Window)

    box = Hedron::VerticalBox.new
    box.padded = true
    mainwin.child = box

    hbox = Hedron::HorizontalBox.new
    hbox.padded = true
    hbox.stretchy = true
    box.add(hbox)

    group = Hedron::Group.new("Basic Controls")
    group.margined = true
    hbox.add(group)

    inner = Hedron::VerticalBox.new
    inner.padded = true
    group.child = inner

    inner.add_all(
      Hedron::Button.new("Button"),
      Hedron::Checkbox.new("Checkbox")
    )

    entry = Hedron::Entry.new
    entry.text = "Entry"
    
    inner.add_all(
      entry,
      Hedron::Label.new("Label"),
      Hedron::HorizontalSeparator.new,
      Hedron::DatePicker.new,
      Hedron::TimePicker.new,
      Hedron::DateTimePicker.new,
      Hedron::FontButton.new,
      Hedron::ColorButton.new
    )

    inner2 = Hedron::VerticalBox.new
    inner2.padded = true
    inner2.stretchy = true
    hbox.add(inner2)

    group = Hedron::Group.new("Numbers")
    group.margined = true
    inner2.add(group)

    inner = Hedron::VerticalBox.new
    inner.padded = true
    group.child = inner

    @@spinbox = Hedron::Spinbox.new({0, 100})
    spinbox = @@spinbox.not_nil!
    spinbox.on_change = ->on_spinbox_changed(Hedron::Spinbox)
    inner.add(spinbox)

    @@slider = Hedron::Slider.new({0, 100})
    slider = @@slider.not_nil!
    slider.on_change = ->on_slider_changed(Hedron::Slider)
    inner.add(slider)

    @@progressbar = Hedron::ProgressBar.new
    progressbar = @@progressbar.not_nil!
    inner.add(progressbar)

    group = Hedron::Group.new("Lists")
    group.margined = true
    inner2.add(group)

    inner = Hedron::VerticalBox.new
    inner.padded = true
    group.child = inner

    cbox = Hedron::Combobox.new
    cbox.choices = ["Combobox Item 1", "Combobox Item 2", "Combobox Item 3"]
    inner.add(cbox)

    ecbox = Hedron::EditableCombobox.new
    ecbox.choices = ["Editable Item 1", "Editable Item 2", "Editable Item 3"]
    inner.add(ecbox)

    rb = Hedron::RadioButtons.new
    rb.choices = ["Radio Button 1", "Radio Button 2", "Radio Button 3"]
    rb.stretchy = true
    inner.add(rb)

    tab = Hedron::Tab.new
    tab["Page 1"] = Hedron::HorizontalBox.new
    tab["Page 2"] = Hedron::HorizontalBox.new
    tab["Page 3"] = Hedron::HorizontalBox.new
    tab.stretchy = true
    inner2.add(tab)

    mainwin.show

    app.start
    app.close
  end
end

ControlGallery.new
