<%@ include file="/WEB-INF/jsp/includes.jsp"%>
<%@ tag body-content="scriptless"%>
<%@ attribute name="name" required="true"%>
<%@ attribute name="path" required="true"%>
<%@ attribute name="mand" required="false"%>
<%@ attribute name="index" required="false"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<h3>${name}<c:if test="${!empty mand}"> <span style="color: red; font-weight: bold;">#</span></c:if></h3>

<div class="form-row last-row">
  <tag:formInlineCheckBox name="Employment:" path="${path}byemployment"/>
  <tag:formInlineCheckBox name="Personal Investments:" path="${path}byinvestments" />
  <tag:formInlineCheckBox name="Other:" path="${path}byother" onclick="document.getElementById('textOther${index}').disabled = !document.getElementById('textOther${index}').disabled;" id="checkOther${index}"/>
  <tag:formInlineField name="Specify if 'other':" path="${path}byotherinfo" maxlength="80" dimension="veryLong" id="textOther${index}"/>
  
  <br class="clear"/>
</div>
