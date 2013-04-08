function showPdf(id)
{
	width = 400;
	height = 600;
	left = 390;
	if (screen)
	{
		width = screen.width/2;
		left = screen.width/2-10;
		height = screen.height*0.95;
	}
	
	mywindow = window.open ("/opi/pixml.pdf?applicationId="+id, id, "toolbar=no,location=no,resizable=yes,menubar=no,status=no,scrollbars=yes,width=800,height=800,left=0,top=0");
}
