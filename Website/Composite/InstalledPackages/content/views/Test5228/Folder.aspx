<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Folder.aspx.cs" Inherits="Composite_InstalledPackages_content_views_Test5228_Folder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:ui="http://www.w3.org/1999/xhtml" xmlns:control="http://www.composite.net/ns/uicontrol">
<control:httpheaders runat="server" />
<head runat="server">
	<title></title>
	<control:styleloader runat="server" />
	<control:scriptloader type="sub" runat="server" />
	<script>
		Test5228PageBinding.prototype = new PageBinding;
		Test5228PageBinding.prototype.constructor = Test5228PageBinding;
		Test5228PageBinding.superclass = PageBinding.prototype;

		/**
		 * @class
		 */
		function Test5228PageBinding() {

			/**
			 * @type {SystemLogger}
			 */
			this.logger = SystemLogger.getLogger("Test5228PageBinding");
			/*
			 * Returnable.
			 */
			return this;
		}

		/**
		 * Identifies the binding.
		 */
		Test5228PageBinding.prototype.toString = function () {

			return "[Test5228PageBinding]";
		}

		/**
		 * @overloads {PageBinding#onBeforePageInitialize}
		 */
		Test5228PageBinding.prototype.onAfterPageInitialize = function () {

			Test5228PageBinding.superclass.onAfterPageInitialize.call(this);

			// Variables:

			// Equivalent:
			// var pageElement = document.getElementById("page");
			var pageElement = this.bindingElement;

			// Current Tree Node
			var node = ExplorerBinding.getFocusedTreeNodeBindings().getFirst().node;
			// Get childrens
			var children = node.getChildren();


			// Start your code here

			console.log(children);
			//console.log(children.getFirst());
			console.log(children.getFirst().getPropertyBag());

		    /*last view state*/
//			var viewSettings = {view:"icons",order:"normal"};
//			var viewSettings = { view: sessionStorage.getItem('lastview'), order: sessionStorage.getItem('lastorder')}; 

            /*create menubar */
			pageElement.appendChild(createListmenu());

            /*sort list*/
			children = sortListItems(children,false); // true = reverse sort - TODO: sort by last sort order

			var listContainer = document.createElement("div");
			listContainer.setAttribute("id", "listContainer");

            /*show element list - TODO: base on last view*/
			showAsThumbnails(listContainer, children);
			console.log(listContainer);
//			showAsList(listContainer, children);
			pageElement.appendChild(listContainer);

			//...
			//...

		}

	    /*
        * Create list menubar
        */
		function createListmenu()
		{
		    /* create menubar */
		    var menu = document.createElement("div");
		    menu.setAttribute("class", "foldermenu");
		    menu.setAttribute("style", "width:100%;text-align:right;background-color:#efefef;border-bottom:1px solid #cacaca;padding:2px; margin-bottom:5px");

		    /* create menu items */
		    /* create sort buttons */
		    var sortButton = document.createElement("button");
		    sortButton.appendChild(
                                document.createTextNode("Z-A")  //TODO: change text based on last sort
                            );
		    sortButton.setAttribute("id", "sortButton");
		    sortButton.setAttribute("class", "menuitem menubutton");
		    sortButton.setAttribute("style", "height:20px;margin-right:2px");
		    sortButton.setAttribute("onclick", "onSort(this);return false;");
		    menu.appendChild(sortButton);

/*		    var sortRevButton = document.createElement("button");
		    sortRevButton.appendChild(
                                document.createTextNode("Z-A")
                            );
		    sortRevButton.setAttribute("id", "sortRevButton");
		    sortRevButton.setAttribute("class", "menuitem menubutton");
		    sortRevButton.setAttribute("style", "height:20px;margin-right:2px");
		    sortRevButton.setAttribute("onclick", "onSort.call(this,true);return false;");
		    menu.appendChild(sortRevButton);
*/
		    /* create list view options - details and thumbnails */
		    var viewDD = document.createElement("select");
		    viewDD.setAttribute("id", "viewDD");
		    viewDD.setAttribute("style", "dispay: inline-box");
		    viewDD.setAttribute("class", "menuitem");
		    var option1 = document.createElement("option");
		    option1.setAttribute("value", "thumbs");
		    option1.appendChild(
                                document.createTextNode("View as thumbnails")
                            );
		    viewDD.appendChild(option1);
		    var option2 = document.createElement("option");
		    option2.setAttribute("value", "list");
		    option2.appendChild(
                                document.createTextNode("View as list")
                            );
		    viewDD.appendChild(option2);
		    menu.appendChild(viewDD);
		    var sizeDD = document.createElement("select");
		    sizeDD.setAttribute("id", "sizeDD");
		    sizeDD.setAttribute("class", "menuitem");
		    sizeDD.setAttribute("style", "dispay: inline-block; margin-left: 2px");
		    var sOption1 = document.createElement("option");
		    sOption1.setAttribute("value", "small");
		    sOption1.appendChild(
                                document.createTextNode("Small icons")
                            );
		    sizeDD.appendChild(sOption1);
		    var sOption2 = document.createElement("option");
		    sOption2.setAttribute("value", "menium");
		    sOption2.appendChild(
                                document.createTextNode("Medium icons")
                            );
		    sizeDD.appendChild(sOption2);
		    var sOption3 = document.createElement("option");
		    sOption3.setAttribute("value", "large");
		    sOption3.setAttribute("selected", "true"); // TODO: set selected based on last values when returning to page
		    sOption3.appendChild(
                                document.createTextNode("Large icons")
                            );
		    sizeDD.appendChild(sOption3);
		    menu.appendChild(sizeDD);
		    return menu;
		}

		/*
        * Sort list by name of items in the direction given (reverse = true/false)
        */
		function sortListItems(children, reverse) {
		    console.log("sortListItems()");
		    if (reverse) {
		        //reverse sort
		        children._array.sort(function (a, b) {
		            return b.getLabel().localeCompare(a.getLabel());
		        });
		    }
		    else {
		        children._array.sort(function (a, b) {
		            return a.getLabel().localeCompare(b.getLabel());
		        });
		    }
		    return children;
		}

		/*
        * Create thumbnail view
        */
		function showAsThumbnails(container,children)
		{
		    console.log("showAsThumbnails");

		    children.each(function (child) {
		        var item = document.createElement("figure");
		        item.setAttribute("class", "thumbnail");
		        item.setAttribute("style", "float:left;margin:10px;text-align:center");

		        //create thumbnail element
		        var thumb = document.createElement("img");
		        thumb.setAttribute("alt", child.getLabel());
		        var propBag = child.getPropertyBag();
		        thumb.setAttribute("src", setImageSize(propBag.ListViewImage, 100, 100));
		        item.appendChild(thumb);

		        var caption = document.createElement("figcaption");
		        caption.setAttribute("class", "caption");
		        caption.appendChild(
					document.createTextNode(child.getLabel())
				);
		        item.appendChild(caption);

		        container.appendChild(item);
		    });
		    console.log(container);
		    return container;
		}

	    /*
        * Create list view
        */
		function showAsList(pageElement,children)
		{
		    children.each(function (child) {
		        var item = document.createElement("p");
                item.appendChild(
					document.createTextNode(child.getLabel())
				);

		        pageElement.appendChild(item);
		    });
		}

	    /*
        * Replace '{width}' and '{height}' of image paths with input measure
        */
		function setImageSize (imgPath,width,height) {
		    return imgPath.toString().replace('{width}', width).replace('{height}', height);
            
		}

	    /*
        * change icons size of items in list
        */
		function changeIconSize(size)
		{
		    /*get all thumbnail pics using the class="thumb" */
		    /*change size according to input small/medium/large using css style*/

		    /* thumbnail sizes */
		    /* icon size small 25*25 */
		    /* icon size medium 50*50 */
		    /* icons size large 100*100 - default */
		}

	    /*
        * Change sorting order
        */
		function onSort(button)
		    {
		    console.log("onSort()");

		    var pageElement = document.getElementById("page");
		    //var pageElement = this.bindingElement;

		    // Current Tree Node
		    var node = ExplorerBinding.getFocusedTreeNodeBindings().getFirst().node;
		    // Get childrens
		    var children = node.getChildren();

		    // clear listContainer element
		    var listContainer = document.getElementById("listContainer");
		    clearElement(listContainer);

		    /* if sorted alphabetically sort reverse, and vice versa */
		    if (button.innerHTML == "Z-A") { // reverse sort button clicked
		        button.innerHTML = "A-Z";
		        sortListItems(children, true);
            }
		    else { // normal sort button clicked
		        button.innerHTML = "Z-A";
		        sortListItems(children, false);
		    }

		    console.log("add elements again");
		    showAsThumbnails(listContainer, children);
           
		}

	    /*
        * clear listcontainer
        */
		function clearElement(element) {
		    var fc = element.firstChild;
		    while (fc) {
		        element.removeChild(fc);
		        fc = element.firstChild;
		    }
		}

	    /*
        * onChangeListView
        */
		function onChangeListView() {

		}


	</script>
</head>
<body>
	<form id="form1" runat="server">
		<ui:page id="page" binding="Test5228PageBinding">

	</ui:page>
	</form>
</body>
</html>
