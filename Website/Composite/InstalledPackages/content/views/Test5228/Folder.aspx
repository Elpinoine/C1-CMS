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
			console.log(children.getFirst().getPropertyBag());

		    /*init last view state*/
			if (sessionStorage.getItem('lastview') == null) {
			    sessionStorage.setItem('lastview', 'icons');
			}
			if (sessionStorage.getItem('lastorder') == null) { // sort order - ascending or decending
			    sessionStorage.setItem('lastorder','asc');
			}
			if (sessionStorage.getItem('lastsize') == null) {
			    sessionStorage.setItem('lastsize','large');
			}

            /*create menubar */
			pageElement.appendChild(createListmenu());

		    /*sort list*/
			if (sessionStorage.getItem('lastorder') == 'dec') {
			    children = sortListItems(children, true); // true = decending sort
			}
			else {
			    children = sortListItems(children, false); // sort ascending by default
			}

			var listContainer = document.createElement("div");
			listContainer.setAttribute("id", "listContainer");

		    /*show element list*/
			switch (sessionStorage.getItem('lastview')) {
			    case 'list':
			        showAsList(listContainer, children);
			        break;
			    case 'icons':
			    default:
			        showAsThumbnails(listContainer, children);
			}
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
		    var buttonText = (sessionStorage.getItem('lastorder') === 'asc') ? 'Z-A' : 'A-Z';

		    sortButton.appendChild(
                                document.createTextNode(buttonText)  //TODO: change text based on last sort
                            );
		    sortButton.setAttribute("id", "sortButton");
		    sortButton.setAttribute("class", "menuitem menubutton");
		    sortButton.setAttribute("style", "height:20px;margin-right:2px");
		    sortButton.setAttribute("onclick", "onSort(this);return false;");
		    menu.appendChild(sortButton);

		    /* create list view options - names and thumbnails */
		    var viewDD = document.createElement("select");
		    viewDD.setAttribute("id", "viewDD");
		    viewDD.setAttribute("style", "display: inline-box");
		    viewDD.setAttribute("class", "menuitem");
		    viewDD.setAttribute('onchange', 'onChangeListView(this);return false;');
		    var option1 = document.createElement("option");
		    option1.setAttribute("value", "icons");
		    if (sessionStorage.getItem('lastview') == "icons") {
		        option1.setAttribute("selected", "selected"); //set selected based on last values when returning to page
		    } option1.appendChild(
                                document.createTextNode("View as thumbnails")
                            );
		    viewDD.appendChild(option1);
		    var option2 = document.createElement("option");
		    option2.setAttribute("value", "list");
		    if (sessionStorage.getItem('lastview') == "list") {
		        option2.setAttribute("selected", "selected"); //set selected based on last values when returning to page
		    } option2.appendChild(
                                document.createTextNode("View as list")
                            );
		    viewDD.appendChild(option2);
		    menu.appendChild(viewDD);

            /* create size dropdown */
		    var sizeDD = document.createElement("select");
		    sizeDD.setAttribute("id", "sizeDD");
		    sizeDD.setAttribute("class", "menuitem");
//		    sizeDD.setAttribute("style", "display:inline-block;margin-left: 2px");
		    switch (sessionStorage.getItem('lastview'))
		    {
		        case 'list':
		            sizeDD.setAttribute("style", "margin-left: 2px;visibility:hidden");
		            break;
		        case 'icons':
		        default:
		            sizeDD.setAttribute("style", "margin-left: 2px;visibility:visible");
		    }
//		    sizeDD.setAttribute("style", "dispay: inline-block; margin-left: 2px");
		    sizeDD.setAttribute("onchange", "onChangeIconSize(this);return false;");
		    var sOption1 = document.createElement("option");
		    sOption1.setAttribute("value", "small");
		    if (sessionStorage.getItem('lastsize') == "small") {
		        sOption1.setAttribute("selected", "selected"); //set selected based on last values when returning to page
		    }
		    sOption1.appendChild(
                                document.createTextNode("Small icons")
                            );
		    sizeDD.appendChild(sOption1);
		    var sOption2 = document.createElement("option");
		    sOption2.setAttribute("value", "medium");
		    if (sessionStorage.getItem('lastsize') == "medium")
		    {
		        sOption2.setAttribute("selected", "selected"); //set selected based on last values when returning to page
		    }
		    sOption2.appendChild(
                                document.createTextNode("Medium icons")
                            );
		    sizeDD.appendChild(sOption2);
		    var sOption3 = document.createElement("option");
		    sOption3.setAttribute("value", "large");
		    if (sessionStorage.getItem('lastsize') == "large") {
		        sOption3.setAttribute("selected", "selected"); //set selected based on last values when returning to page
		    }
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

		    children.each(function (child) {
		        var item = document.createElement("figure");
		        item.setAttribute("class", "thumbnail");
		        item.setAttribute("style", "float:left;margin:10px;text-align:center");

		        //create thumbnail element
		        var thumb = document.createElement("img");
		        thumb.setAttribute("alt", child.getLabel());
		        var propBag = child.getPropertyBag();

		        switch (sessionStorage.getItem('lastsize'))
		        {
		            case 'small':
		                thumb.setAttribute("src", setImageSize(propBag.ListViewImage, 25, 25));
		                break;
		            case 'medium':
		                thumb.setAttribute("src", setImageSize(propBag.ListViewImage, 50, 50));
		                break;
		            case 'large':
		            default:
		                thumb.setAttribute("src", setImageSize(propBag.ListViewImage, 100, 100));
		        }
                    
		        item.appendChild(thumb);

		        var caption = document.createElement("figcaption");
		        caption.setAttribute("class", "caption");
		        caption.appendChild(
					document.createTextNode(child.getLabel())
				);
		        item.appendChild(caption);

		        container.appendChild(item);
		    });

		    return container;
		}

	    /*
        * Create list view
        */
		function showAsList(container,children)
		{
		    children.each(function (child) {
		        var item = document.createElement("p");
                item.appendChild(
					document.createTextNode(child.getLabel())
				);

		        container.appendChild(item);
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
		function onChangeIconSize(select)
		{
		    var size = select.options[select.selectedIndex].value;
		    sessionStorage.setItem('lastsize', size);

		    var pageElement = document.getElementById("page");
		    // Current Tree Node
		    var node = ExplorerBinding.getFocusedTreeNodeBindings().getFirst().node;
		    // Get childrens
		    var children = node.getChildren();
		    // sort children
		    if (sessionStorage.getItem('lastorder') == 'dec') {
		        children = sortListItems(children, true); // true = decending sort
		    }
		    else {
		        children = sortListItems(children, false); // sort ascending by default
		    }
		    // clear listContainer element
		    var listContainer = document.getElementById('listContainer');
		    clearElement(listContainer);		    /*change size according to input small/medium/large using css style*/

		    showAsThumbnails(listContainer, children)
		}

	    /*
        * Change sorting order
        */
		function onSort(button)
		    {

		    var pageElement = document.getElementById("page");

		    // Current Tree Node
		    var node = ExplorerBinding.getFocusedTreeNodeBindings().getFirst().node;
		    // Get childrens
		    var children = node.getChildren();

		    // clear listContainer element
		    var listContainer = document.getElementById('listContainer');
		    clearElement(listContainer);

		    /* if sorted alphabetically sort reverse, and vice versa */
		    if (button.innerHTML == 'Z-A') { // reverse sort button clicked
		        button.innerHTML = 'A-Z';
		        sortListItems(children, true);
		        sessionStorage.setItem('lastorder','dec');
            }
		    else { // normal sort button clicked
		        button.innerHTML = 'Z-A';
		        sortListItems(children, false);
		        sessionStorage.setItem('lastorder','asc');
            }

            // create view
		    switch(sessionStorage.getItem('lastview')){
		        case 'icons':
		            showAsThumbnails(listContainer, children);
		            break;
		        case 'list':
		        default:
		            showAsList(listContainer, children);
		    }
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
		function onChangeListView(select) {

		    var pageElement = document.getElementById("page");

		    // Current Tree Node
		    var node = ExplorerBinding.getFocusedTreeNodeBindings().getFirst().node;
		    // Get childrens
		    var children = node.getChildren();
		    // sort children
		    if (sessionStorage.getItem('lastorder') == 'dec') {
		        children = sortListItems(children, true); // true = decending sort
		    }
		    else {
		        children = sortListItems(children, false); // sort ascending by default
		    }

		    // clear listContainer element
		    var listContainer = document.getElementById('listContainer');
		    clearElement(listContainer);


		    var view = select.options[select.selectedIndex].value;
		    sessionStorage.setItem('lastview', view);

		    var sizeSelect = document.getElementById('sizeDD');

		    switch (view) {
		        case 'icons':
		            sizeSelect.setAttribute("style", "margin-left: 2px;visibility:visible");
		            showAsThumbnails(listContainer, children);
		            break;
		        default: // view = 'list'
		            sizeSelect.setAttribute("style", "margin-left: 2px;visibility:hidden");
		            showAsList(listContainer, children);
		    }
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
