function displayHelpText(containerType, container, fieldName) {
  newWindow = open('/FCCSC/navigate/helptext.jsp?containerType=' + containerType + '&container=' + container + '&fieldName=' + fieldName, 'helptext', 'dependent=yes,width=500,height=500,top=100,left=200,titlebar=yes,scrollbars=yes');
  newWindow.focus();
}