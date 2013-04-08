// This Javascript enables pop-up windows

function popup(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

function popupPrint(theURL,winName,features) {  
  var win = window.open(theURL,winName,features);
  win.print();
}