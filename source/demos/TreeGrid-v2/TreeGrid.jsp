<%@ taglib uri="FlexTagLib" prefix="mm" %>
<html>
  <style type="text/css">
    body
    {
      overflow:hidden;
      margin: 0px;
    }
  </style>
  <body scroll='no'>
    <mm:mxml>
      <mx:Application
        xmlns:mx="http://www.macromedia.com/2003/mxml"
        xmlns="*"
        width="100%"
        height="100%"
        initialize="initApp()"
        >

        <mx:Script>

          var dp : Array;

          function initApp()
          {
            dp = new Array();

            var p1 = new Object();
            p1.title = "Level 1";
            p1.desc = " I am p1";
            p1.product = new Array();

            var p2 = new Object();
            p2.title = "Level 1";
            p2.desc = " I am p2";
            p2.product = new Array();

            var p3 = new Object();
            p3.title = "Level 1";
            p3.desc = " I am p3";
            p3.product = new Array();

            var p1_1 = new Object();
            p1_1.title = "Level 2";
            p1_1.desc = " I am p1_1";
            p1_1.product = new Array();

            var p1_2 = new Object();
            p1_2.title = "Level 2";
            p1_2.desc = " I am p1_2";

            var p1_3 = new Object();
            p1_3.title = "Level 2";
            p1_3.desc = " I am p1_3";

            var p1_1_1 = new Object();
            p1_1_1.title = "Level 3";
            p1_1_1.desc = " I am p1_1_1";

            var p2_1 = new Object();
            p2_1.title = "Level 2";
            p2_1.desc = " I am p2_1";

            var p2_2 = new Object();
            p2_2.title = "Level 2";
            p2_2.desc = " I am p2_2";
            p2_2.product = new Array();

            var p2_3 = new Object();
            p2_3.title = "Level 2";
            p2_3.desc = " I am p2_3";

            var p2_2_1 = new Object();
            p2_2_1.title = "Level 3";
            p2_2_1.desc = " I am p2_2_1";
            p2_2_1.product = new Array();

            var p2_2_2 = new Object();
            p2_2_2.title = "Level 3";
            p2_2_2.desc = " I am p2_2_2";

            var p2_2_1_1 = new Object();
            p2_2_1_1.title = "Level 4";
            p2_2_1_1.desc = " I am p2_2_1_1";

            p1_1.product.push(p1_1_1);

            p1.product.push(p1_1);
            p1.product.push(p1_2);
            p1.product.push(p1_3);

            p2_2_1.product.push(p2_2_1_1);

            p2_2.product.push(p2_2_1);

            p2.product.push(p2_1);
            p2.product.push(p2_2);
            p2.product.push(p2_3);

            dp.push(p1);
            dp.push(p2);
            dp.push(p3);

          }
        </mx:Script>
        
        <mx:DataGrid id="mxmlTree" dataProvider="{dp}" sortableColumns="false">
          <mx:columns>
            <mx:Array>
              <mx:DataGridColumn columnName="title" headerText="Title" width="100" cellRenderer="TreeGridCellRenderer"/>
              <mx:DataGridColumn columnName="desc" headerText="Description" width="140"/>
            </mx:Array>
          </mx:columns>
        </mx:DataGrid>

      </mx:Application>

    </mm:mxml>
  </body>
</html>
