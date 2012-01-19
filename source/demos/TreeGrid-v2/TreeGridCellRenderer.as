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

  var owner;
  var listOwner : MovieClip;
  var getCellIndex : Function;
  var getDataLabel : Function;

  var disclosure : MovieClip;
  var label : TextField;

  var indent : Number = 10;

  function TreeGridCellRenderer()
  {
  }

  function createChildren(Void) : Void
  {
    disclosure = createClassObject(mx.controls.Image, "disclosure", 1);
    disclosure.useHandCursor = true;

    label = createLabel("label", 2);
    label.multiline = false;
    label.wordWrap = false;
    label.selectable = false;
    label.backGround = false;
    label.border = false;

    size();
  }

  function size(Void) : Void
  {
    var i = 20;
    if (owner.item.indent)
    {
      i += owner.item.indent;
    }

    disclosure.setSize(i,layoutHeight);

    var w = (layoutWidth - 20);
    if (w < 0)
    {
      w = 0;
    }
    label.setSize(w,layoutHeight);
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
      disclosure.onPress = mx.utils.Delegate.create(this,disclosurePress);
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

    label.text = item[getDataLabel()];
    label._x = 20 + indent;

    size();
  }

  function getPreferredHeight(Void) : Number
  {
    return 20;
  }

  function getPreferredWidth(Void) : Number
  {
    return 20;
  }

  function disclosurePress()
  {
    owner.item.open = !owner.item.open;

    if (owner.item.open)
    {
      openItem(getCellIndex().itemIndex, owner.item);
    }
    else
    {
      closeItem(owner.item);
    }

  }

  function openItem(rowNum,item)
  {

    // add the rows for the products at this level
    for (var i = 0; i < item.product.length; i++)
    {

      if (item.indent)
      {
        item.product[i].indent = item.indent + indent;
      }
      else
      {
        item.product[i].indent = indent;
      }

      listOwner.addItemAt(rowNum + i + 1,item.product[i]);
    }

    // recursively open and already open nodes at this level
    for (var i = 0; i < item.product.length; i++)
    {
      if (item.product[i].open)
      {
        openItem(rowNum + i + 1, item.product[i]);
      }
    }

  }

  function closeItem(item)
  {
    for (var i = 0; i < item.product.length; i++)
    {
      if (item.product[i].open)
      {
        closeItem(item.product[i]);
      }
      listOwner.removeItemAt(getCellIndex().itemIndex + 1);
    }
  }

}
