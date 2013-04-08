// This Javascript enables pop-up windows
var cwin = null;
var vwin = null;
function ShowWinContact() {
	var sTmp;
	if (cwin != null) {
		if (cwin.closed == false) {
			cwin.focus();
			return;
		}
	}
	sTmp = "./html/Contact.html";
	cwin = window.open(sTmp, "Contact", "width=550,height=380,scrollbars=yes,resizable=no,status=no");
}

