// D Smart - 2/ 3/2007
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

function ShowWinPleaseContact() {
	var sTmp;
	if (cwin != null) {
		if (cwin.closed == false) {
			cwin.focus();
			return;
		}
	}
	sTmp = "./html/PleaseContact.html";
	cwin = window.open(sTmp, "Contact", "width=300,height=170,scrollbars=yes,resizable=no,status=no");
}

//document.applicationForm.applicationamount01

