function isEmpty(s){
	if(s==null || s=='' || s=='undefined'){
		return true;
	}
	return false;
}

function isNumeric(s){
	return /^([\d]+|([\d]+[.]?|[\d]+[.]?[\d]+))$/.test(s);
}

function isNumber(s){
	return /^[0-9]*$/.test(s);
}