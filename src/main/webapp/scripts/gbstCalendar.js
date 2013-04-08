/*
Floats and Issues Calendar popup methods.

Author: burta

Functions to show the calendar popup for the floats & issues system.
Requires AnchorPosition.js, CalendarPopup.js, PopupWindow.js and date.js
For more info:
http://www.mattkruse.com/javascript/calendarpopup/index.html
*/

// **********************************************************************************
//  Common Javascript functions for the Front Office: Floats and Issues Application
// **********************************************************************************
var popupWindow = new Array();
var calWindows = new Array();

/*
Pass in a reference to the text field displaying the date and anchor name of the link
which instantiates the calendar.  The format of the date returned will be
yyyy-MM-dd.  Usage:

<A HREF="#" 
  onClick="showDate(document.forms[0].myDateField,'anchorName');" 
  TITLE="Select The Date" 
  NAME="anchorName" 
  ID="anchorName">select</A>

*/
function showDate(dateField,anchor) {
    return showDateWithFormat(dateField,anchor,'dd/MM/yyyy'); 
}

/*
Unfortunately javascript doesn't allow overloading, so the method name
must be different.  Specify the date text field, anchor name of link and
the format of the returned date.  Usage:

<A HREF="#" 
  onClick="showDateWithFormat(document.forms[0].myDateField,'anchorName','dd/MM/yyyy');" 
  TITLE="Select The Date" 
  NAME="anchorName" 
  ID="anchorName">select</A>

*/
function showDateWithFormat(dateField,anchor,dateFormat) {
    var cal = new CalendarPopup();
    calWindows[calWindows.length] = cal;    
    cal.showYearNavigation();
    cal.select(dateField,anchor,dateFormat); 
    return false;
}
