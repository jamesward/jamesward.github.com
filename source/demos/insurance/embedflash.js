function embedFlash(id, flashFile, width, height, flashVars) {
	document.writeln("<object id='"+id+"' classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,5,0,0' width='"+width+"' height='"+height+"'>");
	document.writeln("<param name='flashvars' value='"+flashVars+"'/>");
	document.writeln("<param name='src' value='"+flashFile+"'/>");
	document.writeln("<embed name='"+id+"' pluginspage='http://www.macromedia.com/go/getflashplayer' src='"+flashFile+"' width='"+width+"' height='"+height+"' flashvars='"+flashVars+"'/>");
	document.writeln("</object>");
}
