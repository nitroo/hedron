# This file depends on a fork of libui that I maintain myself.
# It uses code from the upcoming 'table' branch of libui, and
# also a tree implementation (unix-only) that I'm maintaining myself.
# Since libui currently has no tree, I'm using my own for now.

# This 'nitroo-ext' branch is a selfish endeavor
# contributions that depend on the canonical implementation of libui
# are on branch 'nitroo'

# This is going to be deleted when libui properly supports table/tree.

@[Link(ldflags: "-lui")]
lib UI
  fun new_table = uiNewTable(model : TableModel*): Table*

  fun new_tree = uiNewNTree : Tree*
  fun new_tree_model = uiNewNTreeModel : TreeModel*

  alias Table = Void*
  alias TableModel = Void*
  alias Tree = Void*
  alias TreeModel = Void*

  enum TableModelColumnType
    STRING,
    IMAGE,
    INT,
    COLOR
  end

  struct TableModelHandler
    num_columns : (TableModelHandler*, TableModel* -> LibC::Int)
    column_type : (TableModelHandler*, TableModel*, LibC::Int -> TableModelColumnType)
    num_rows : (TableModelHandler*, TableModel*, LibC::Int -> LibC::Int)
    cell_value : (TableModelHandler*, TableModel*, LibC::Int, LibC::Int -> Void*)
    set_cell_value : (TableModelHandler*, TableModel*, LibC::Int, LibC::Int, Void* -> Void)
  end
end
