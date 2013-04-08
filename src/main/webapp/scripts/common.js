/*
 * Method used to update the help text in 100 points check screen
 */
/*function changeHelpText() {
	var selectedInd = document.getElementById('documentIndex').selectedIndex;
	var helpText = document.getElementById('helpText');
	helpText.innerHTML = helpTextArray[selectedInd];
}*/

/*
 * Submits the form on the current document with the supplied form id.
 */
 
function submitForm(formId) {
  var frm = document.getElementById(formId);
  if (frm !== null) {
    frm.submit();
  }
}

/*
 * Submits the form on the current document with the supplied form id,
 * setting the 'actionType' for the form to the supplied value.
 */
function doAction(formId, action) {
  var actionType = document.getElementById('submitAction');
  if (actionType !== null) {
	actionType.value = action;
    submitForm(formId);
  }
}

function checkBusinessNumberType(name) {
	var businessNumber1 = document.getElementById('businessNumber1');
	if (name == 'acn') {
		businessNumber1.value='';
		businessNumber1.disabled = true;
		
	} else if (name == 'abn') {
		businessNumber1.disabled = false;
	} else if (name == 'arbn') {
		businessNumber1.value='';
		businessNumber1.disabled = true;
	}
}

function checkPersonEnteringApp(name) {
	var relationship = document.getElementById('relationship');
	var authorisedYes = document.getElementById('authorisedYes');
	var authorisedNo = document.getElementById('authorisedNo');
	var relationshipMandatoryFlag = document.getElementById('relationshipMandatoryFlag');
	
	if (name == 'inyournameYes') {
		relationship.disabled = true;
		relationship.value="";
		relationshipMandatoryFlag.style.visibility='hidden';        		
		authorisedYes.disabled = true;
		authorisedNo.disabled = true;
	} else if (name == 'inyournameNo') {
		relationship.disabled = false;
		relationshipMandatoryFlag.style.visibility='visible';        		
		authorisedYes.disabled = false;
		authorisedNo.disabled = false;
	}
}

function checkAffiliation(name) {
	var statusDescriptionMandFlag = document.getElementById('statusDescriptionMandatoryFlag');
	var statusDescriptionMandFlag1 = document.getElementById('statusDescriptionMandatoryFlag1');
	var statusDescriptionMandFlag2 = document.getElementById('statusDescriptionMandatoryFlag2');	

	if (name == 'affiliatedYes') {
		statusDescriptionMandFlag.style.visibility='visible';
	} else if (name == 'affiliatedNo') {
		statusDescriptionMandFlag.style.visibility='hidden';
	} else if (name == 'affiliatedYes1') { 
		statusDescriptionMandFlag1.style.visibility='visible';	
	} else if (name == 'affiliatedNo1') {
		statusDescriptionMandFlag1.style.visibility='hidden';	
	} else if (name == 'affiliatedYes2') { 
		statusDescriptionMandFlag2.style.visibility='visible';	
	} else if (name == 'affiliatedNo2') {
		statusDescriptionMandFlag2.style.visibility='hidden';	
	}	
}


/*function copyRejectReasonToParent(rejectReasonForm) {
	opener.window.document.accountInformationFrm.rejectReason.value = rejectReasonForm.rejectReason.value;
	opener.window.document.accountInformationFrm.submitAction.value = "Reject";
	opener.window.document.accountInformationFrm.submit();
	window.close();
}*/

function performAction(formId, action, actionURL, target, method) {
	var frm = document.getElementById(formId);
	var actionType = document.getElementById('submitAction');
	if (frm !== null ) {
		if (actionType !== null)
			actionType.value = action;
		if (actionURL !== null)
			frm.action = actionURL;
		if (target !== null)
			frm.target = target;			
		if (method !== null)
			frm.method = method;				
		frm.submit();
	}
}

function performSubmitAndClose(formId, action, actionURL, target, method) {
	var frm = document.getElementById(formId);
	var actionType = document.getElementById('actionType');
	if (frm != null ) {
		if(actionType != null)
			actionType.value = action;
		if(actionURL != null)
			frm.action = actionURL;
		if(target != null)
			frm.target = target;			
		if(method != null)
			frm.method = method;				
		frm.submit();
	}	
	opener.window.location.reload();
	self.close();
}

function refreshParentMonitor(formName) {
    var frm = window.opener.document.getElementById(formName);
    if (frm != null) {
        frm.submitAction.value = 'Filter';
        frm.submit();
    }
}

/*
function performAddAndDeleteAction(formId, action, actionURL, target, method) {
	var frm = document.getElementById(formId);
	var actionType = document.getElementById('submitAction');

	var selectedInd = document.getElementById('documentIndex').selectedIndex;
	var helpText = document.getElementById('helpText');
	helpText.innerHTML = helpTextArray[selectedInd];

	if (frm != null ) {
		if(actionType != null)
			actionType.value = action;
		if(actionURL != null)
			frm.action = actionURL;
		if(target != null)
			frm.target = target;			
		if(method != null)
			frm.method = method;				
		frm.submit();
	}
}*/

/*function viewPdf(index) {
    pdfLinks[index] = true;
    var allSeen = true;
    for (var i = 0 ; i < pdfLinks.length ; i++) {
        if (pdfLinks[i] == false) {
            allSeen = false;
        }
    }
    if (allSeen == true) {
        var next = document.getElementById("next");
        if (next != null) {
            next.disabled = false;
        }
    }
}*/