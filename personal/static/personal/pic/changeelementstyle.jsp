// This javascript will change the font style of the row/cell to bold that the
// mouse is currently hovering over. The row will return to normal when
// another row is entered.
//
// The following elements must exist on the "tr" row tag.
//   - id="xxx" where xxx is a unique id. If multiple rows are to be highlight
//     at the same time then those rows must all have the same "id".
//   - onmouseover="changeElementStyle();"

var printStyleSet = false;

function printStyle() {
  var linkElement = document.getElementById("fccsc-stylesheet");
  var printText = document.getElementById("printText");

  if (printStyleSet) {
    printStyleSet = false;
    linkElement.href="/fccsc-style.css";
    printText.innerHTML = "<span class='u'>P</span>rinter View";
  } else {
    printStyleSet = true;
    linkElement.href="/fccsc-print-style.css";
    printText.innerHTML = "<span class='u'>N</span>ormal View";
  }
}

var holdElement;
var holdElementNodeName;

function changeElementStyle(event, elementNodeName, styleString) {
  if (typeof(event) != 'object' || printStyleSet) {
    return;
  }
  if (typeof(holdElement) != 'undefined') {
    findElements(holdElement, holdElementNodeName, styleString, false);
  }
  holdElement = event.srcElement || event.currentTarget || event.target;
  holdElementNodeName = elementNodeName;
  findElements(holdElement, holdElementNodeName, styleString, true);
}

function findElements(elementIn, elementNodeName, styleString, applyStyle) {
  var id = ""
  var loop=0;
  var rowIndex=0;
  var cellIndex=0;
  var tableClassName;
  while (true) {
    if (typeof(elementIn) != 'object') {
      return;
    }
    if (elementIn.nodeName == 'TABLE' && id != "") {
      tableClassName = elementIn.className;
      break;
    }
    if (elementIn.nodeName == elementNodeName) {
      id = elementIn.id;
      if (elementIn.nodeName == 'TR') {
        rowIndex = elementIn.rowIndex;
      }
      if (elementIn.nodeName == 'TD') {
        cellIndex = elementIn.cellIndex;
      }
    }
    if (elementIn.parentNode) {
      elementIn = elementIn.parentNode;
    } else {
      elementIn = elementIn.parentElement;
    }
    loop++;
    if (loop > 10) {
      return;
    }
  }
  if (id == "") {
    return;
  }
  var found = false;
  if (elementNodeName == 'TR') {
    var startRowIndex = rowIndex;
    for (;rowIndex>=0;rowIndex--) {
      if (elementIn.rows[rowIndex].id != id) {
        break;
      }
      processRow(elementIn, rowIndex, styleString, tableClassName, applyStyle);
    }
    rowIndex = startRowIndex + 1;
    for (;rowIndex<elementIn.rows.length;rowIndex++) {
      if (elementIn.rows[rowIndex].id != id) {
        break;
      }
      processRow(elementIn, rowIndex, styleString, tableClassName, applyStyle); 
    }
  } else if (elementNodeName == 'TD') {
    for (;rowIndex<elementIn.rows.length;rowIndex++) {
      for (cellIndex=0;cellIndex<elementIn.rows[rowIndex].cells.length;cellIndex++) {
        if (elementIn.rows[rowIndex].cells[cellIndex].id == id) {
          changeElement(elementIn.rows[rowIndex].cells[cellIndex], styleString, tableClassName, applyStyle);
        }
      }
    }
  }
}

function processRow(elementIn, rowIndex, styleString, tableClassName, applyStyle) {
  if (elementIn.rows[rowIndex].className == "") {
    for (cellIndex=0;cellIndex<elementIn.rows[rowIndex].cells.length;cellIndex++) {
      changeElement(elementIn.rows[rowIndex].cells[cellIndex], styleString, tableClassName, applyStyle);
    }
  } else {
    changeElement(elementIn.rows[rowIndex], styleString, tableClassName);
    for (cellIndex=0;cellIndex<elementIn.rows[rowIndex].cells.length;cellIndex++) {
      if (elementIn.rows[rowIndex].cells[cellIndex].className != "") {
        changeElement(elementIn.rows[rowIndex].cells[cellIndex], styleString, tableClassName, applyStyle);
      }
    }
  }
}

function changeElement(elementIn, styleString, tableClassName, applyStyle) {
  var className = elementIn.className;
  if (className == "") {
    className = tableClassName;
  }
  if (className == "") {
    return;
  }
  if (className.indexOf(styleString) >= 0) {
    if (!applyStyle) {
      className = className.substring(0, className.indexOf(styleString));
    }
  } else {
    if (applyStyle) {
      className = className + styleString;
    }
  }
  elementIn.className = className;
  checkChildElements(elementIn, styleString, tableClassName, applyStyle);
}

function checkChildElements(elementIn, styleString, tableClassName, applyStyle) {
  if (! elementIn.hasChildNodes()) {
    return;
  }
  var childNodes = elementIn.childNodes;
  for (var i=0;i<childNodes.length;i++) {
    if (!(childNodes[i].className == "" || typeof(childNodes[i].className) == 'undefined')) {
      changeElement(childNodes[i], styleString, tableClassName, applyStyle);
    }
  }
}