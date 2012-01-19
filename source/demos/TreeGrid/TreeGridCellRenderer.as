import mx.core.UIComponent;
import mx.controls.Label;
import mx.controls.listclasses.SelectableRow;
import mx.effects.Tween;
import mx.styles.StyleManager;
import mx.controls.treeclasses.TreeRow;


class TreeGridCellRenderer extends UIComponent
{

  [Embed(symbol="TreeDisclosureOpen")]
  var openIcon:String;

  [Embed(symbol="TreeDisclosureClosed")]
  var closedIcon:String;

  var listOwner : MovieClip;
  var getCellIndex : Function;
  var getDataLabel : Function;

  var disclosure : MovieClip;
  var label : MovieClip;

  var rotationTween : Tween;

  function TreeGridCellRenderer()
  {
  }

  function createChildren(Void) : Void
  {
    super.createChildren();

    if (disclosure==undefined)
    {
      createObject("Disclosure", "disclosure", 3, {_visible:false} );
      disclosure.useHandCursor = true;
    }

  }

  function size(Void) : Void
  {
    super.size();
  }

  function setValue(str:String, item:Object, sel:Boolean) : Void
  {
    var indent = 0;

    if (item.indent)
    {
      indent = item.indent;
    }
    
    if (item.product.length > 0)
    {
      disclosure = createClassObject(mx.controls.Image, "disclosure", 1); //ugly
      disclosure.onPress = disclosurePress;
      disclosure.useHandCursor = true;
      disclosure.visible = true;
      disclosure._x = indent;

      if (item.open)
      {
        disclosure.source = openIcon;
      }
      else
      {
        disclosure.source = closedIcon;
      }
    }
    else
    {
      disclosure.visible = false;
    }

    label = createClassObject(mx.controls.Label, "label", 2); //ugly
    label.text = item[getDataLabel()];
    label._x = 20 + indent;

    //size();
  }

  function getPreferredHeight(Void) : Number
  {
    return 21;
  }

  function getPreferredWidth(Void) : Number
  {
    return 250;
  }

  function disclosurePress()
  {
    var item = _parent.owner.item;
    var rowIndex = _parent.owner.rowIndex;
    var dataGrid = _parent._parent._parent._parent; // ugly

    item.open = !item.open;

    if (item.open)
    {
      var ri = 1;

      for (var i = 0; i < item.product.length; i++)
      {
        var data = item.product[i];

        if (item.indent)
        {
          data.indent = item.indent + 10; //ugly
        }
        else
        {
          data.indent = 10; //ugly
        }

        dataGrid.addItemAt(rowIndex+i+ri,data);

        // we need recursion here because we should loop through and open any already open nodes
        if (data.open)
        {
          for (var j = 0; j < data.product.length; j++)
          {
            var dataj = data.product[j];

            if (data.indent)
            {
              dataj.indent = data.indent + 10; //ugly
            }
            else
            {
              dataj.indent = 10; //ugly
            }

            dataGrid.addItemAt(rowIndex+i+2,dataj);

            ri++;
          }
        }

      }
    }
    else
    {

      // calculate how many rows to remove
      // I need recursion but can't figure out how to call another method from here
      var removeRows = 0;

      for (var i = 0; i < item.product.length; i++)
      {
        if (item.product[i].open)
        {
          for (var j = 0; j < item.product[i].product.length; j++)
          {
            removeRows++;
          }
        }
        removeRows++;
      }

      // remove the rows
      for (var i = 0; i < removeRows; i++)
      {
        dataGrid.removeItemAt(rowIndex + 1);
      }

    }

  }

}
