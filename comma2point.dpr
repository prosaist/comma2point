program comma2point;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, System.IOUtils, System.Classes, System.Diagnostics, StrUtils;
var
  p: Integer;
  fileName, s: String;
  fs: TBufferedFileStream;
  sr: TStreamReader;
  st: TStringList;
  sw: TStopwatch;
begin
  for p := 1 to ParamCount do
  begin
    sw := TStopwatch.StartNew;
    fileName := ParamStr(p);
    fs := TBufferedFileStream.Create(fileName, fmOpenRead, 1048576);
    sr := TStreamReader.Create(fs);
    st := TStringList.Create;
    try
      while not sr.EndOfStream do
      begin
        s := sr.ReadLine;
        if ContainsText(s, '.') then
          s := ReplaceText(s, '.', ',')
        else
          s := ReplaceText(s, ',', '.');
        st.Add(s);
      end;
    finally
      sr.Free;
      fs.Free;
    end;
    st.SaveToFile(fileName);
    sw.Stop;
    Writeln(fileName, ' read ', st.Count, ' lines in ', sw.Elapsed.ToString);
    st.Free;
  end;
end.
