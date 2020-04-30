unit SimpleLogEventSetupMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    Edit3: TEdit;
    Button2: TButton;
    Button3: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    found32: string;
    found64: string;
    procedure CheckInstallation;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{$R DllRes.res}

uses
  ShellApi, ShlObj, Registry;

Function Wow64DisableWow64FsRedirection(Var Wow64FsEnableRedirection: LongBool): LongBool; StdCall;
  External 'Kernel32.dll' Name 'Wow64DisableWow64FsRedirection';
Function Wow64EnableWow64FsRedirection(Wow64FsEnableRedirection: LongBool): LongBool; StdCall;
  External 'Kernel32.dll' Name 'Wow64EnableWow64FsRedirection';

procedure RunAndWaitShell(Executable, Parameter: STRING; ShowParameter: INTEGER);
var
  Info: TShellExecuteInfo;
  pInfo: PShellExecuteInfo;
  exitCode: DWord;
begin
  // Source: https://www.delphipraxis.net/31067-shellexecute-wait.html
  pInfo := @Info;
  with Info do
  begin
    cbSize := SizeOf(Info);
    fMask := SEE_MASK_NOCLOSEPROCESS;
    wnd   := application.Handle;
    lpVerb := NIL;
    lpFile := PChar(Executable);
    lpParameters := PChar(Parameter + #0);
    lpDirectory := NIL;
    nShow       := ShowParameter;
    hInstApp    := 0;
  end;
  ShellExecuteEx(pInfo);
  repeat
    exitCode := WaitForSingleObject(Info.hProcess, 500);
    Application.ProcessMessages;
  until (exitCode <> WAIT_TIMEOUT);
end;

procedure RegSvr32(const dll: string);
begin
  //ShellExecute(Form1.Handle, 'open', 'regsvr32.exe', PChar('"' + dll + '"'), '', SW_NORMAL);
  RunAndWaitShell('regsvr32.exe', '"'+dll+'"', SW_NORMAL);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  rs: TResourceStream;
  Wow64FsEnableRedirection: LongBool;
  reg: TRegistry;
  sl: TStringList;
  kn: string;
  test: string;
  lastregfile: string;
begin
  if not IsUserAnAdmin  then
  begin
    raise Exception.Create('To register the libraries, this application needs to run as administrator.');
  end;

  try
    {$REGION 'Copy DLL to common files'}

    if TOSVersion.Architecture = TOSVersion.TArchitecture.arIntelX86 then
    begin
      {$REGION '32 Bit Windows'}
      lastregfile := 'C:\Program Files\Common Files\ViaThinkSoft\ViaThinkSoftSimpleLogEvent32.dll';
      ForceDirectories(ExtractFilePath(lastregfile));
      rs := TResourceStream.CreateFromID(HInstance, 32, PChar('DLL'));
      rs.SaveToFile(lastregfile);
      rs.Free;
      RegSvr32(lastregfile);
      {$ENDREGION}
    end;

    if TOSVersion.Architecture = TOSVersion.TArchitecture.arIntelX64 then
    begin
      {$REGION '64 Bit Windows'}
      Wow64DisableWow64FsRedirection(Wow64FsEnableRedirection);
      try
        lastregfile := 'C:\Program Files (x86)\Common Files\ViaThinkSoft\ViaThinkSoftSimpleLogEvent32.dll';
        ForceDirectories(ExtractFilePath(lastregfile));
        rs := TResourceStream.CreateFromID(HInstance, 32, PChar('DLL'));
        rs.SaveToFile(lastregfile);
        rs.Free;
        RegSvr32(lastregfile);

        lastregfile := 'C:\Program Files\Common Files\ViaThinkSoft\ViaThinkSoftSimpleLogEvent64.dll';
        ForceDirectories(ExtractFilePath(lastregfile));
        rs := TResourceStream.CreateFromID(HInstance, 64, PChar('DLL'));
        rs.SaveToFile(lastregfile);
        rs.Free;
        RegSvr32(lastregfile);
      finally
        Wow64EnableWow64FsRedirection(Wow64FsEnableRedirection);
      end;
      {$ENDREGION}
    end;

    {$ENDREGION}

    {$REGION 'Update DLL path in log provider list'}
    reg := TRegistry.Create;
    sl := TStringList.Create;
    try
      reg.RootKey := HKEY_LOCAL_MACHINE;
      if reg.OpenKey('SYSTEM\CurrentControlSet\services\eventlog\Application', false) then
      begin
        reg.GetKeyNames(sl);
        reg.CloseKey;
        for kn in sl do
        begin
          if reg.OpenKey('SYSTEM\CurrentControlSet\services\eventlog\Application\' + kn, false) then
          begin
            test := reg.ReadString('EventMessageFile');
            if Pos('VIATHINKSOFTSIMPLELOGEVENT', UpperCase(test)) > 0 then
            begin
              if test <> lastregfile then
              begin
                reg.WriteString('EventMessageFile', lastregfile);
              end;
            end;
            reg.CloseKey;
          end;
        end;
      end;
    finally
      FreeAndNil(reg);
      FreeAndNil(sl);
    end;
    {$ENDREGION}

  finally
    CheckInstallation;
  end;
end;

const
  DEFECTIVE_SUFFIX = ' (defective)';

procedure RegisterEventLogProvider(ProviderName, MessageFile: string);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if not reg.OpenKey('SYSTEM\CurrentControlSet\Services\Eventlog\Application\'+ProviderName, true) then
    begin
      raise Exception.Create('Cannot register EventLog provider! Please run the application as administrator');
    end
    else
    begin
      reg.WriteInteger('CategoryCount', 0);
      reg.WriteInteger('TypesSupported', 7);
      reg.WriteString('EventMessageFile', MessageFile);
      reg.WriteString('CategoryMessageFile', MessageFile);
      reg.CloseKey;
    end;
  finally
    reg.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if FileExists(found64) then
  begin
    RegisterEventLogProvider(Edit3.Text, found64);
  end
  else if FileExists(found32) then
  begin
    RegisterEventLogProvider(Edit3.Text, found32);
  end
  else
  begin
    raise Exception.Create('Please first register the DLL');
  end;

  CheckInstallation;

  Edit3.Text := '';
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  text: string;
  reg: TRegistry;
begin
  if ListBox1.ItemIndex = -1 then exit;
  text := ListBox1.Items.Strings[ListBox1.ItemIndex];
  text := StringReplace(text, DEFECTIVE_SUFFIX, '', []);

  reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if not reg.DeleteKey('SYSTEM\CurrentControlSet\services\eventlog\Application\' + text) then
    begin
      raise Exception.Create('Failed to remove item. Are you admin?');
    end;
  finally
    FreeAndNil(reg);
  end;

  CheckInstallation;
end;

procedure TForm1.CheckInstallation;
var
  reg: TRegistry;
  filename: string;
  Wow64FsEnableRedirection: LongBool;
  sl: TStrings;
  kn: string;
  test: string;
begin
  found32 := '';
  found64 := '';

  if TOSVersion.Architecture = TOSVersion.TArchitecture.arIntelX64 then
  begin
    Wow64DisableWow64FsRedirection(Wow64FsEnableRedirection);
  end;
  try
    {$REGION '32 Bit'}
    reg := TRegistry.Create;
    try
      reg.RootKey := HKEY_CLASSES_ROOT;
      if not reg.OpenKeyReadOnly('TypeLib\{D7654BA7-41D0-4FF9-8543-C3A4DA936856}\1.0\0\win32') then
      begin
        Edit1.Text := 'NOT INSTALLED';
        Edit1.Color := clRed;
      end
      else
      begin
        filename := reg.ReadString('');
        if FileExists(filename) then
        begin
          Edit1.Text := 'Installed at ' + FileName;
          Edit1.Color := clLime;
          found32 := FileName;
        end
        else
        begin
          Edit1.Text := 'MISSING at location ' + FileName;
          Edit1.Color := clRed;
        end;
        reg.CloseKey;
      end;
    finally
      FreeAndNil(reg);
    end;
    {$ENDREGION}

    {$REGION '64 Bit'}
    if TOSVersion.Architecture = TOSVersion.TArchitecture.arIntelX86 then
    begin
      Edit2.Text := 'Not applicable on a 32-bit operating system';
      Edit2.Color := clLime;
    end
    else
    begin
      reg := TRegistry.Create;
      try
        reg.RootKey := HKEY_CLASSES_ROOT;
        if not reg.OpenKeyReadOnly('TypeLib\{D7654BA7-41D0-4FF9-8543-C3A4DA936856}\1.0\0\win64') then
        begin
          Edit2.Text := 'NOT INSTALLED';
          Edit2.Color := clRed;
        end
        else
        begin
          filename := reg.ReadString('');
          if FileExists(filename) then
          begin
            Edit2.Text := 'Installed at ' + FileName;
            Edit2.Color := clLime;
            found64 := FileName;
          end
          else
          begin
            Edit2.Text := 'MISSING at location ' + FileName;
            Edit2.Color := clRed;
          end;
          reg.CloseKey;
        end;
      finally
        FreeAndNil(reg);
      end;
    end;
    {$ENDREGION}

  finally
    if TOSVersion.Architecture = TOSVersion.TArchitecture.arIntelX64 then
    begin
      Wow64EnableWow64FsRedirection(Wow64FsEnableRedirection);
    end;
  end;

  {$REGION 'List providers'}
  ListBox1.Clear;
  reg := TRegistry.Create;
  sl := TStringList.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.OpenKeyReadOnly('SYSTEM\CurrentControlSet\services\eventlog\Application') then
    begin
      reg.GetKeyNames(sl);
      reg.CloseKey;
      for kn in sl do
      begin
        if reg.OpenKeyReadOnly('SYSTEM\CurrentControlSet\services\eventlog\Application\' + kn) then
        begin
          test := reg.ReadString('EventMessageFile');
          if Pos('VIATHINKSOFTSIMPLELOGEVENT', UpperCase(test)) > 0 then
          begin
            if not FileExists(test) then
              ListBox1.Items.Add(kn + DEFECTIVE_SUFFIX)
            else
              ListBox1.Items.Add(kn);
          end;
          reg.CloseKey;
        end;
      end;
    end;
  finally
    FreeAndNil(reg);
    FreeAndNil(sl);
  end;
  {$ENDREGION}
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  CheckInstallation;
end;

end.
