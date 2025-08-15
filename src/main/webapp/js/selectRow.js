/**
 * 通过表头对表列进行排序
 *
 * @param sTableID 要处理的表ID<table id=''>
 * @param iCol 字段列id eg: 0 1 2 3 ...
 * @param sDataType 该字段数据类型 int,float,date 缺省情况下当字符串处理
 */
function orderByName(sTableID, iCol, sDataType) {
	var oTable = document.getElementById(sTableID);
	var oTBody = oTable.tBodies[0];
	var colDataRows = oTBody.rows;
	var aTRs = new Array;
	for (var i = 0; i < colDataRows.length; i++) {
		aTRs[i] = colDataRows[i];
	}
	if (oTable.sortCol == iCol) {
		aTRs.reverse();
	} else {
		aTRs.sort(generateCompareTRs(iCol, sDataType));
	}
	var oFragment = document.createDocumentFragment();
	for (var j = 0; j < aTRs.length; j++) {
		oFragment.appendChild(aTRs[j]);
	}
	oTBody.appendChild(oFragment);
	oTable.sortCol = iCol;
}

/**
 * 通过表头对表列进行排序
 *
 * @param sTableID 要处理的表ID<table id=''>
 * @param iCol 字段列id eg: 0 1 2 3 ...
 * @param sDataType 该字段数据类型 int,float,date 缺省情况下当字符串处理
 */
function orderByName2(sTableID, iCol, sDataType) {
	var oTable = document.getElementById(sTableID);
	var oTBody = oTable.tBodies[0];
	var r = oTBody.rows[oTBody.rows.length-1];
	var colDataRows = oTBody.rows;
	var aTRs = new Array;
	for (var i = 0; i < colDataRows.length-1; i++) {
		aTRs[i] = colDataRows[i];
	}
	if (oTable.sortCol == iCol) {
		aTRs.reverse();
	} else {
		aTRs.sort(generateCompareTRs(iCol, sDataType));
	}
	aTRs.push(r);
	var oFragment = document.createDocumentFragment();
	for (var j = 0; j < aTRs.length; j++) {
		oFragment.appendChild(aTRs[j]);
	}
	oTBody.appendChild(oFragment);
	oTable.sortCol = iCol;
}
/**
 * 处理排序的字段类型
 *
 * @param sValue 字段值 默认为字符类型即比较ASCII码
 * @param sDataType 字段类型 对于date只支持格式为mm/dd/yyyy或mmmm dd,yyyy(January 12,2004)
 * @return
 */
function convert(sValue, sDataType) {

	switch (sDataType) {
	case "int":
		return parseInt(sValue);
	case "float":
        sValue=sValue?sValue.replace(/[￥¥%]/g, ""):sValue;//shit更改，为了使得金额排序正确，此处做替换操作
        sValue= sValue?sValue:0;
        return parseFloat(sValue);
	case "date":
		return new Date(Date.parse(sValue));
	default:
		return  sValue;
	}
}

/**
 * 比较函数生成器
 *
 * @param iCol 数据行数
 * @param sDataType 该行的数据类型
 * @return
 */
function generateCompareTRs(iCol, sDataType) {
	return function compareTRs(oTR1, oTR2) {
		if (!oTR1.cells[iCol].firstChild) { return 1; }//TODO shit更改-1改成1，这里更改了默认排序方式为倒序
		if (!oTR2.cells[iCol].firstChild) { return -1; }
		if (oTR1.cells[iCol].firstChild instanceof Element) {

            var b = oTR1.cells[iCol].firstChild;
			vValue1 = convert(oTR1.cells[iCol].firstChild.innerText, sDataType);//TODO shit更改 把innerHTML改成 innerText
			vValue2 = convert(oTR2.cells[iCol].firstChild.innerText, sDataType);
		} else {
			vValue1 = convert(oTR1.cells[iCol].firstChild.nodeValue, sDataType);
			vValue2 = convert(oTR2.cells[iCol].firstChild.nodeValue, sDataType);
		}
		//字符类型
		if(sDataType=='string'){
			return vValue2.localeCompare(vValue1,"zh");//TODO 这里更改了默认排序方式为倒序

		//比率类型
		} else if (sDataType=='rate'){
			var fl11 = 0;
			var fl12 = 0;
			var fl21 = 0;
			var fl22 = 0;
			if (vValue1.indexOf("/") != -1) {
				fl11 = parseFloat(vValue1.split("/")[0]);
				fl12 = parseFloat(vValue1.split("/")[1]);

				fl21 = parseFloat(vValue2.split("/")[0]);
				fl22 = parseFloat(vValue2.split("/")[1]);

			} else if (vValue1.indexOf(":") != -1) {
				fl11 = parseFloat(vValue1.split(":")[0]);
				fl12 = parseFloat(vValue1.split(":")[1]);

				fl21 = parseFloat(vValue2.split(":")[0]);
				fl22 = parseFloat(vValue2.split(":")[1]);

			} else {
				//不支持格式
				return 0;
			}

			if ( (fl11/fl12) < (fl21/fl22) ) {
				return -1;

			} else if ( (fl11/fl12) > (fl21/fl22) ) {
				return 1;

			//比率相等，判断分母
			} else {
				if (fl12 < fl22) {
					return -1;
				} else if (fl12 > fl22) {
					return 1;
				} else {
					return 0;
				}
			}
		} else if(sDataType== 'float' || sDataType== 'int' || sDataType== 'double') {//数字型排序：默认为降序
			if (parseFloat(vValue1) > parseFloat(vValue2)) {
				return -1;
			} else if (parseFloat(vValue1 )< parseFloat(vValue2)) {
				return 1;
			} else {
				return 0;
			}
		}else {//其他
			if (vValue1 > vValue2) {
				return -1;
			} else if (vValue1 < vValue2) {
				return 1;
			} else {
				return 0;
			}
		}
	};
}