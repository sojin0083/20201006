
function downloadFiles(no,dtlsNo,name){
	var url = encodeURI(ABSOLUTE_URL+"/cmmn/attchFileDownload.do?attchFileSn="+no+"&attchFileDtlsSn="+dtlsNo);
	window.requestFileSystem(LocalFileSystem.TEMPORARY,5*1024*1024, function(fs){
		console.log('fill system open: ' + fs.name);
		// Make sure you add the domain name to the Content-Security-Policy <meta> element.
	    // Parameters passed to getFile create a new file or return the file if it already exists.
	    fs.root.getFile(name, {create: true, exclusive: true  }, function (fileEntry) {
	        download(fileEntry, url);
	    }, onErrorCreateFile);

	}, onErrorLoadFs);
}

function download(fileEntry, url) {

    var fileTransfer = new FileTransfer();
    var fileURL = fileEntry.toURL();
    fileTransfer.download(
        url,
        fileURL,
        function (entry) {
        	shortToast("다운로드 되었습니다.");
           
        },
        function (error) {
        	shortToast("실패했습니다.");
        },
        null, // or, pass false
        {
            //headers: {
            //    "Authorization": "Basic dGVzdHVzZXJuYW1lOnRlc3RwYXNzd29yZA=="
            //}
        }
    );
}

function onErrorCreateFile(){
//	alert("성공");
}
function onErrorLoadFs(){
//	alert("실패");
}
