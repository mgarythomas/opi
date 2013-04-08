	function AddOptions(CONTROL,optionValue,IsDuplicateNotAllowed)
	{
		var IsAlreadyExists =  false;
		if(optionValue=="")
		{
			return;
		}
		if(IsDuplicateNotAllowed)
		{
			for(var i = 0;i < CONTROL.options.length;i++){
				if(CONTROL.options[i].value == optionValue)
				{
					IsAlreadyExists  = true;
					break;
				}
			}
		}
		if(IsAlreadyExists)
		{
			alert("Date already exists within the list");
			return;
		}else
		{
			CONTROL.options[CONTROL.options.length] = new Option(optionValue, optionValue);
		}	
	}
	
	function DeleteOptions(CONTROL)
	{
		var arrValues;
		var icount=0;
		for(icount = 0;icount < CONTROL.options.length;icount++){
			if(CONTROL.options[icount].selected)
			{	
				CONTROL.options[icount] = null;
				DeleteOptions(CONTROL);
				break;
			}
		}	
		
		
	}
	function DeselectAllList(CONTROL){
		for(var i = 0;i < CONTROL.length;i++){
			CONTROL.options[i].selected = false;
		}
	}

	function SelectAllList(CONTROL){
		for(var i = 0;i < CONTROL.options.length;i++){
			CONTROL.options[i].selected = true;
		}
	}
//For Question type 24

	function AddQuestion24(objectSelect_1,objectSelect_2,RemoveFlag)
	{
	
		var value="";
		var index=0;
		var flag=true;
		for(i=0; i < objectSelect_1.options.length ; i++){
			if(objectSelect_1.options[i].selected){
				flag=true;
				index = objectSelect_1.options[i].value;
				for(j=0;j<objectSelect_2.options.length ; j++){
					if(objectSelect_2.options[j].value == index){
						flag=false;
						break;
					}
				}	
				if(flag){
					value = objectSelect_1.options[i].text;
					if(TrimSpace(value) !=""){
						objectSelect_2.options[objectSelect_2.options.length] = new Option(value,index);
					}
				}	
			}
		}
		if(RemoveFlag){
			for(i=0; i < objectSelect_2.options.length ; i++){
				index = objectSelect_2.options[i].value;
				for(j=0;j<objectSelect_1.options.length ; j++){
					if(objectSelect_1.options[j].text == objectSelect_2.options[i].text){
						objectSelect_1.options[j]=null;
						break;
					}	
				}	
			}
		}
	}

	function RemoveItems(objectSelect_1,objectSelect_2,RemoveFlag)
	{
		for(i=0; i < objectSelect_2.options.length ; i++){
			index = objectSelect_2.options[i].value;
			for(j=0;j<objectSelect_1.options.length ; j++){
				if(objectSelect_1.options[j].text == objectSelect_2.options[i].text){
					objectSelect_1.options[j]=null;
					break;
				}	
			}	
		}
		
	}	
	///For Question type 24


	function IsSumInRange(Object,lowerLimit,HigherLimit)
	{
			var flag=false;
			var i_count=0;
			var sum=0;
			if(arguments.length > 3)
			{
				for(i_count=3;i_count < arguments.length ; i_count++)
				{
					if(!isNaN(TrimSpace(document.forms[0][arguments[i_count]].value)))
					sum += parseInt(document.forms[0][arguments[i_count]].value);
				}
				if(sum == HigherLimit )
				{
					flag=true;
				}
				if(!flag)
				{
					alert("The total of all the linked values should add up to " +HigherLimit+"\n");
					//Object.value=lowerLimit;
					Object.focus();
					return false;
				}else
				return true;
			}
			
	}
	function TrimSpace(str){
		var rtn = "";
		var len = str.length;
		var i = 0;
		var startLoc = 0;
		var endLoc = 0;
		var started = false;

		for (i=0; (i < len) && (!started) ; i++){
			if (str.charAt(i) != ' '){
				started = true;
				startLoc = i;
			}
		}
		if (!started) return rtn;

		started = false;
		for (i=len-1; (i > -1) && (!started) ; i--){
			if (str.charAt(i) != ' '){
				started = true;
				endLoc = i + 1;
			}
		}
		for (i=startLoc ; i<endLoc; i++){
			rtn = rtn+str.charAt(i);
		}
		return rtn;
	}
	function IsValidRange(Object,lowerLimit,HigherLimit)
	{
			var flag=false;
			if(Object.value=="") return ;
			if(isNaN(Object.value))
			{
				flag=false;
			}else
			{
				if( (Object.value >=lowerLimit) && (Object.value<=HigherLimit))
					flag=true;
				else
					flag=false;
			}
			if(!flag)
			{
				alert("Please enter a valid number \nbetween "+lowerLimit+ "  and " +HigherLimit+"\n");
				//Object.value=lowerLimit;
				Object.focus();
			}
	}

	function replaceString(oldS,newS,fullS)
	{
		 for (var i=0; i < fullS.length; i++)
		 {
				if (fullS.substring(i,i+oldS.length) == oldS)
				{
					 fullS = fullS.substring(0,i)+newS+fullS.substring(i+oldS.length,fullS.length);
					 i--;
				}
		 }
		 return fullS
	}

	function IsInteger2(p_Number)
	{
		var v_Number = p_Number;
		
		/* IsNaN checks for a valid number, so decimal, negative, etc symbols are valid.
		   For integer testing they will be replaced with characters
		 */
		v_Number = v_Number.replace(/\D/, "a");
		
		if (isNaN(v_Number))
			return false;
		else
			return true;
	}
	
	function IsValid(thisString,validCharacters)
	{
		var validflag = true;
		var validcharacters = validCharacters;
		for (var i=0; i<thisString.length; i++) {
			if ( validcharacters.indexOf(thisString.charAt(i)) == -1) {
				validflag = false;
				break;
			}
		}
		return validflag;
	}

	function isblank(s) {
		if (s==null || s=="") return true;
		for (var i=0; i<s.length; i++) {
			var c=s.charAt(i);
			if ((c!=' ') && (c!='\n') && (c!='\t')) return false
		}
		return true;
	}

	function ltrim(thisString) {
		while (''+thisString.charAt(0)==' ') {
			thisString=thisString.substring(1,thisString.length);
		}
		return thisString;	
	}

	function rtrim(thisString) {
		while (''+thisString.charAt(thisString.length-1)==' ') {
			thisString=thisString.substring(0,thisString.length-1);
		}
		return thisString;	
	}
	
	function trim(thisString) {
		thisString = ltrim(thisString);
		thisString = rtrim(thisString);
		return thisString;	
	}
	
	function rtrim2(s,c) {
		var i;
		if(isblank(s)) return "";
		if(s.charAt(s.length-1)!=c) return s;
		for(i=s.length-2;s.charAt(i)==c;i--);
		return s.substring(0,i+1)
	}

	function howmany(s,thisCharacter) {
		var count=0;
		if (s==null || s=="") return 0;
		for (var i=0; i<s.length; i++) {
			var c=s.charAt(i);
			if (c == thisCharacter) count++;
		}
		return count;
	}

	function checkDateLessThanToday(iobjField,istrErrorMessage)
	{
		// Call from new_question page_validation after calling function checkDate()
		var strUserInput;
		var dteUserInput;
		var dteToday;
		
		if (iobjField)
		{
			strUserInput = iobjField.value;
		}
		else
		{
			return true;    //field passed in doesn't exist
		}
		
		dteUserInput = new Date(strUserInput);
		dteToday = new Date();

		if (dteUserInput > dateAdd(dteToday,'d',-1))
		{
			iobjField.focus();
			alert(istrErrorMessage);
			return false;
		}
		
		return true;
	}
	
	
	
	function checkDateLessThanOrEqualToday(iobjField,istrErrorMessage)
	{
		// Call from new_question page_validation after calling function checkDate()
		var strUserInput;
		var dteUserInput;
		var dteToday;
		
		if (iobjField)
		{
			strUserInput = iobjField.value;
		}
		else
		{
			return true;    //field passed in doesn't exist
		}

		dteUserInput = new Date(strUserInput);
		dteToday = new Date();

		if (dteUserInput > dteToday)
		{
			iobjField.focus();
			alert(istrErrorMessage);
			return false;
		}
		
		return true;
	}
	
	function checkDateGreaterThanOrEqualToday(iobjField,istrErrorMessage)
	{
		// Call from new_question page_validation after calling function checkDate()
		var strUserInput;
		var dteUserInput;
		var dteToday;
		
		if (iobjField)
		{
			strUserInput = iobjField.value;
		}
		else
		{
			return true;    //field passed in doesn't exist
		}

		dteUserInput = new Date(strUserInput);
		dteToday = new Date();
	
		if (dteUserInput < dateAdd(dteToday,'d',-1))
		{
			iobjField.focus();
			alert(istrErrorMessage);
			return false;
		}
		
		return true;
	}
	
	function checkDateGreaterThanToday(iobjField,istrErrorMessage)
	{
		// Call from new_question page_validation after calling function checkDate()
		var strUserInput;
		var dteUserInput;
		var dteToday;
		
		if (iobjField)
		{
			strUserInput = iobjField.value;
		}
		else
		{
			return true;    //field passed in doesn't exist
		}

		dteUserInput = new Date(strUserInput);
		dteToday = new Date();
	
		if (dteUserInput < dteToday)
		{
			iobjField.focus();
			alert(istrErrorMessage);
			return false;
		}
		
		return true;
	}
	
		
	function checkDate(iobjField,istrDateFormat)
	{
		var strUserInput;
		var strSeparatorArray;
		var intCounter;
		var strDateArray;
		var strDay;
		var strMonth;
		var strYear;
		var intDay;
		var intMonth;
		var intYear;
		var blnFound;
		var strMonthArray;
		var intErrorType;
		var strDateStyle;
		var strTemp;
		
		strMonthArray = new Array(12);
		strMonthArray[0] = "Jan";
		strMonthArray[1] = "Feb";
		strMonthArray[2] = "Mar";
		strMonthArray[3] = "Apr";
		strMonthArray[4] = "May";
		strMonthArray[5] = "Jun";
		strMonthArray[6] = "Jul";
		strMonthArray[7] = "Aug";
		strMonthArray[8] = "Sep";
		strMonthArray[9] = "Oct";
		strMonthArray[10] = "Nov";
		strMonthArray[11] = "Dec";
		strSeparatorArray = new Array("-"," ","/",".");			
		blnFound = false;
		intErrorType = 0;
		strDateStyle = istrDateFormat;
		intDay = 0;
		intMonth = 0;
		intYear = 0;
		
		if (iobjField)
		{
			strUserInput = iobjField.value;
		}
		else
		{
			return true;    //field passed in doesn't exist
		}
		
		if (strUserInput.length < 1) 
		{
			return true;	//no input so return true
		}
		
		for (intCounter = 0; intCounter < strSeparatorArray.length; intCounter++) 
		{
			if (strUserInput.indexOf(strSeparatorArray[intCounter]) != -1) 
			{
				strDateArray = strUserInput.split(strSeparatorArray[intCounter]);
				if (strDateArray.length != 3) 
				{
					intErrorType = 1;
					alert("The date was not entered in a recognised format");
					iobjField.focus();
					return false;
				}
				else 
				{
					strDay = strDateArray[0];
					strMonth = strDateArray[1];
					strYear = strDateArray[2];
				}
				blnFound = true;
			}
		}
		
		if (blnFound == false) 
		{
			if (strUserInput.length>5) 
			{
				strDay = strUserInput.substr(0, 2);
				strMonth = strUserInput.substr(2, 2);
				strYear = strUserInput.substr(4);
			}
			else
			{
				intErrorType = 1;
				alert("The date was not entered in a recognised format");
				iobjField.focus();
				return false;
			}
		}
		
		if (!isNaN(strMonth)) 
		{
			if (strDateStyle == "US")
			//looks like an American style date was intended
			{
				strTemp = strDay;
				strDay = strMonth;
				strMonth = strTemp;
			}
		}
	
		intDay=strDay;
		if (isNaN(intDay)) 
		{
			intErrorType = 2;
			alert("The day you entered was invalid");
			iobjField.focus();
			return false;
		}
		
		intMonth=strMonth;
		if (isNaN(intMonth)) 
		{
			for (i = 0;i<12;i++) 
			{
				if (strMonth.toUpperCase() == strMonthArray[i].toUpperCase()) 
				{
					intMonth = i+1;
					strMonth = strMonthArray[i];
					i = 12;
				}
			}
			if (isNaN(intMonth)) 
			{
				intErrorType = 3;
				alert("The month you entered was invalid");
				iobjField.focus();
				return false;
			}
		}
		
		intYear = strYear;
		if (isNaN(intYear)) 
		{
			intErrorType = 4;
			alert("The year you entered is invalid");
			iobjField.focus();
			return false;
		}
		
		if (strYear.length == 2) 
		{
			strYear = '20' + strYear;
		}
		
		if (intMonth>12 || intMonth<1) 
		{
			intErrorType = 5;
			alert("The month you entered is invalid");
			iobjField.focus();
			return false;
		}
		
		if ((intMonth == 1 || intMonth == 3 || intMonth == 5 || intMonth == 7 || intMonth == 8 || intMonth == 10 || intMonth == 12) && (intDay > 31 || intDay < 1)) 
		{
			intErrorType = 6;
			alert("There are only 31 days in this month");
			iobjField.focus();
			return false;
		}
		
		if ((intMonth == 4 || intMonth == 6 || intMonth == 9 || intMonth == 11) && (intDay > 30 || intDay < 1)) 
		{
			intErrorType = 7;
			alert("There are only 30 days in this month");
			iobjField.focus();
			return false;
		}
		
		if (intMonth == 2) 
		{
			if (intDay < 1) 
			{
				intErrorType = 8;
				alert("The day of the month you entered is invalid");
				iobjField.focus();
				return false;
			}
			if (LeapYear(intYear) == true) 
			{
				if (intDay > 29) 
				{
					intErrorType = 9;
					alert("There are only 29 days in this month");
					iobjField.focus();
					return false;
				}
			}
			else 
			{
				if (intDay > 28) 
				{
					intErrorType = 10;
					alert("There are only 28 days in this month");
					iobjField.focus();
					return false;
				}
			}
		}
		
		//if (strDateStyle == "US") 
		//{
		//	iobjField.value = strMonthArray[intMonth-1] + " " + intDay + " " + strYear;
		//}
		//else 
		//{
			iobjField.value = intDay + " " + strMonthArray[intMonth-1] + " " + strYear;
		//}
		
		return true;
		
	}

	function LeapYear(intYear) 
	{
		if (intYear % 100 == 0) 
		{
			if (intYear % 400 == 0) 
			{ 
				return true; 
			}
		}
		else 
		{
			if ((intYear % 4) == 0) 
			{ 
				return true; 
			}
		}
		return false;
	}

	
	function dateAdd(idteStartDate, istrIntervalType, iintIntervalAmount) 
	{

		// Error messages... 
		var startMsg = "Sorry the start parameter of the dateAdd function\n";
			startMsg += "must be a valid date format.\n\n";
			startMsg += "Please try again." ;
			
		var intervalMsg = "Sorry the dateAdd function only accepts\n";
			intervalMsg += "d, h, m OR s intervals.\n\n";
			intervalMsg += "Please try again." ;

		var numberMsg = "Sorry the number parameter of the dateAdd function\n";
			numberMsg += "must be numeric.\n\n";
			numberMsg += "Please try again." ;
			
		//Convert date to milliseconds...
		var lngStartDateInMillisecs = Date.parse(idteStartDate);
		
		//check that lngStartDateInMillisecs is a number... 
		if (isNaN(lngStartDateInMillisecs)) 
		{
			alert(startMsg);
			return null;
		}
		
		//check that the intervalType parameter was not numeric...
		if (istrIntervalType.charAt == 'undefined')
		{
			//the user specified an incorrect intervalType, handle the error. 
			alert(intervalMsg);
			return null;
		}

		//check that the intervalAmount parameter is numeric. 
		if (isNaN(iintIntervalAmount))
		{
			alert(numberMsg);
			return null;
		}

		switch (istrIntervalType.charAt(0))
		{
			case 'd': case 'D': 
				iintIntervalAmount = iintIntervalAmount * 24; // days to hours
				//fall through 
			case 'h': case 'H':
				iintIntervalAmount = iintIntervalAmount * 60; // hours to minutes
				//fall through
			case 'm': case 'M':
				iintIntervalAmount = iintIntervalAmount * 60; // minutes to seconds
				//fall through
			case 's': case 'S':
				iintIntervalAmount = iintIntervalAmount * 1000; // seconds to milliseconds
				break;
			default:

			// If we get to here then the interval parameter was invalid
			alert(intervalMsg);
			return null;
		}
		
		return new Date(lngStartDateInMillisecs + iintIntervalAmount);
	}


	function checkAllDatePickFields(istrDateFormat)
	{
		if (!checkDatePickFields(istrDateFormat,"NONE"))
		{
			return false;
		}
		
		if (!checkDatePickFields(istrDateFormat,"LT"))
		{
			return false;
		}		
		
		if (!checkDatePickFields(istrDateFormat,"LTOE"))
		{
			return false;
		}	
		
		if (!checkDatePickFields(istrDateFormat,"GT"))
		{
			return false;
		}		
		
		if (!checkDatePickFields(istrDateFormat,"GTOE"))
		{
			return false;
		}	
	}
	
		
	function checkDatePickFields(istrDateFormat,istrExtraDateValidation)
	{
		var aryDatePickFields;
		var intNumberOfFields;
		var intCounter;
		var objDatePickField;
		
		switch (istrExtraDateValidation)
		{
			case "NONE":
			{
				objDatePickField = document.forms[0].DatePickField;
				break;
			}
			case "LT":
			{
				objDatePickField = document.forms[0].DatePickFieldLT;
				break;
			}
			case "LTOE":
			{
				objDatePickField = document.forms[0].DatePickFieldLTOE;
				break;
			}
			case "GT":
			{
				objDatePickField = document.forms[0].DatePickFieldGT;
				break;
			}
			case "GTOE":
			{
				objDatePickField = document.forms[0].DatePickFieldGTOE;
				break;
			}
		}
		
		if (objDatePickField)
		{
			if (objDatePickField.length)
			{
				intNumberOfFields = objDatePickField.length;
				for (intCounter = 0;intCounter < intNumberOfFields;intCounter++)
				{
					if (!checkDate(objDatePickField[intCounter],istrDateFormat))
					{
						return false;
					}
					else
					{
						switch (istrExtraDateValidation)
						{
							case "LT":
							{
								if(!checkDateLessThanToday(objDatePickField[intCounter],"The date supplied must be less than today."))
								{
									return false;
								}
								break;
							}
							case "LTOE":
							{
								if(!checkDateLessThanOrEqualToday(objDatePickField[intCounter],"The date supplied must be less than or equal to today."))
								{
									return false;
								}
								break;
							}
							case "GT":
							{
								if(!checkDateGreaterThanToday(objDatePickField[intCounter],"The date supplied must be greater than today."))
								{
									return false;
								}
								break;
							}
							case "GTOE":
							{
								if(!checkDateGreaterThanOrEqualToday(objDatePickField[intCounter],"The date supplied must be greater than or equal to today."))
								{
									return false;
								}
								break;
							}
						}
					}	
				}
			}
			else
			{
				if (!checkDate(objDatePickField,istrDateFormat))
				{
					return false;
				}
				else
				{
					switch (istrExtraDateValidation)
					{
						case "LT":
						{
							if(!checkDateLessThanToday(objDatePickField,"The date supplied must be less than today."))
							{
								return false;
							}
							break;
						}
						case "LTOE":
						{
							if(!checkDateLessThanOrEqualToday(objDatePickField,"The date supplied must be less than or equal to today."))
							{
								return false;
							}
							break;
						}
						case "GT":
						{
							if(!checkDateGreaterThanToday(objDatePickField,"The date supplied must be greater than today."))
							{
								return false;
							}
							break;
						}
						case "GTOE":
						{
							if(!checkDateGreaterThanOrEqualToday(objDatePickField,"The date supplied must be greater than or equal to today."))
							{
								return false;
							}
							break;
						}
					}
				}	
			}
		}
		
		return true;
	}
	//Functions used for admin ticket template page-STARTs HERE
	function selectbox(objText,objSelect)
	{
		var i=0;
		var str="";
		var valueText = "";
		var SearchText = "";
		for(i = 0 ; i < objSelect.options.length ; i++)
		{
			
			valueText = "";
			SearchText = "";
			//if(objSelect.options[i].text == objText.value)
			
			if( (objText.value!=null) &&(objSelect.options[i]!=null)&& (objSelect.options[i].text.toUpperCase().indexOf(objText.value.toUpperCase())!=-1))
			{
				objSelect.selectedIndex = i; 
				break;
			}	
				
		}
	}
	function addoption(objText,objSelect)
	{
		objSelect.options[objSelect.options.length] = new Option(objText.value, objText.value);

	}

	//Functions used for admin ticket template page-Ends HERE	