// codeunit 50099 ReportHelper
// {
//     // version CLAUSL


//     trigger OnRun()
//     begin
//     end;

//     procedure DownloadToClientFileName(ServerFileName: Text[250];ToFile: Text[250]): Text[250]
//     var
//         ClientFileName: Text[250];
//         objScript: Automation ;
//         CR: Text[1];
//     begin
//         ClientFileName := ToFile;
//         IF NOT DOWNLOAD(ServerFileName, '', '<TEMP>','', ClientFileName) THEN
//           EXIT('');
//         IF CREATE(objScript,TRUE,TRUE) THEN
//         BEGIN
//           CR := ' '; CR[1] := 13;
//           objScript.Language := 'VBScript';
//           objScript.AddCode(
//           'function RenameTempFile(fromFile, toFile)'+CR+
//           'set fso = createobject("Scripting.FileSystemObject")'+CR+
//           'set x = createobject("Scriptlet.TypeLib")'+CR+
//           'path = fso.getparentfoldername(fromFile)'+CR+
//           'toPath = path+"\"+left(x.GUID,38)'+CR+
//           'fso.CreateFolder toPath'+CR+
//           'fso.MoveFile fromFile, toPath+"\"+toFile'+CR+
//           'RenameTempFile = toPath'+CR+
//           'end function');
//           ClientFileName := objScript.Eval('RenameTempFile("'+ClientFileName+'","'+ToFile+'")');
//           ClientFileName := ClientFileName+'\'+ToFile;
//         END;
//         EXIT(ClientFileName);
//     end;
// }

