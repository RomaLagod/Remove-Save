unit Remove;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, ToolWin, ImgList, StdActns,
  ActnList, ActnMan,AboutForm, Spin, Buttons, Mask, Gauges,RichEdit,
  CheckLst,  Grids;

type
  TForm1 = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    tbNew: TToolButton;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    ToolButton2: TToolButton;
    tbOpen: TToolButton;
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    tbSaveAs: TToolButton;
    ToolButton5: TToolButton;
    tbCut: TToolButton;
    tbCopy: TToolButton;
    tbPaste: TToolButton;
    ToolButton9: TToolButton;
    tbAbout: TToolButton;
    tbFind: TToolButton;
    tbReplace: TToolButton;
    ToolButton13: TToolButton;
    ActionManager1: TActionManager;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    FindDialog1: TFindDialog;
    ReplaceDialog1: TReplaceDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    meData: TMaskEdit;
    meVTime: TMaskEdit;
    meDTime: TMaskEdit;
    Label6: TLabel;
    meSatelit: TEdit;
    etInterval: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Splitter1: TSplitter;
    pbprocess: TProgressBar;
    CoolBar2: TCoolBar;
    ToolBar2: TToolBar;
    btRemove: TToolButton;
    ToolButton1: TToolButton;
    ToolButton6: TToolButton;
    SDInfobox: TSaveDialog;
    sbaddGPS: TSpeedButton;
    sbCheckGPS: TSpeedButton;
    gbCheckGPS: TGroupBox;
    GPS01: TCheckBox;
    GPS02: TCheckBox;
    GPS03: TCheckBox;
    GPS04: TCheckBox;
    GPS05: TCheckBox;
    GPS06: TCheckBox;
    GPS07: TCheckBox;
    GPS08: TCheckBox;
    GPS09: TCheckBox;
    GPS10: TCheckBox;
    GPS11: TCheckBox;
    GPS12: TCheckBox;
    GPS13: TCheckBox;
    GPS14: TCheckBox;
    GPS15: TCheckBox;
    GPS16: TCheckBox;
    GPS17: TCheckBox;
    GPS18: TCheckBox;
    GPS19: TCheckBox;
    GPS20: TCheckBox;
    GPS21: TCheckBox;
    GPS22: TCheckBox;
    GPS23: TCheckBox;
    GPS24: TCheckBox;
    GPSFile: TRichEdit;
    Activatemesatelit: TCheckBox;
    infobox: TMemo;
    ScrollBox1: TScrollBox;
    GPS25: TCheckBox;
    GPS26: TCheckBox;
    GPS27: TCheckBox;
    GPS28: TCheckBox;
    GPS29: TCheckBox;
    GPS30: TCheckBox;
    GPS31: TCheckBox;
    GPS32: TCheckBox;
    procedure tbNewClick(Sender: TObject);
    procedure tbOpenClick(Sender: TObject);
    procedure tbSaveAsClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tbReplaceClick(Sender: TObject);
    procedure ReplaceDialog1Replace(Sender: TObject);
    procedure ReplaceDialog1Find(Sender: TObject);
    procedure tbFindClick(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure tbAboutClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure GPSFileChange(Sender: TObject);
    procedure GPSFileKeyPress(Sender: TObject; var Key: Char);
    procedure GPSFileMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure meDataKeyPress(Sender: TObject; var Key: Char);
    procedure meDTimeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure sbaddGPSClick(Sender: TObject);
    procedure sbCheckGPSClick(Sender: TObject);
    procedure ActivatemesatelitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Function DataSesion:string;
    Function TimeSesion:string;
    procedure UpdateCursorPos;//позиція курсора
    Procedure FildEnable; //включає поля
    Procedure FildDisable;//виключає поля
    Procedure CheckedGPS;//вибрані супутники
    Procedure NewInfoBox;//чистий інфобокс з шапкою
  end;

var
  Form1: TForm1;
  spos:integer;

implementation

{$R *.dfm}
resourcestring
  sColRowInfo = 'Ряд: %3d   Сим: %3d';


procedure TForm1.tbNewClick(Sender: TObject);
begin
 Case MessageDLG('Зберегти файл?',mtWarning,[mbYes,mbNo,mbCancel],0) of
                    idYes:   tbSaveAsClick(Sender);
                    idNo:   begin
                             GPSFile.Clear;
                             Form1.caption:='Remover - [ Новий ]';
                             StatusBar1.Panels[1].Text:='Рядків : '+IntToStr(Gpsfile.Lines.Count);
                             StatusBar1.Panels[6].Text:='Результат';
                             pbprocess.Position:=0;
                             NewInfoBox;
                            end; {idNo}
                    idCancel:exit;
 end;{Case}
end;

procedure TForm1.tbOpenClick(Sender: TObject);
begin
Case MessageDLG('Зберегти файл?',mtWarning,[mbYes,mbNo,mbCancel],0) of
  idYes:   tbSaveAsClick(Sender);
  idNo:
  begin
   if OpenDialog1.Execute then //если файл выбран, то выполнять следующее
    begin
       Form1.GPSFile.Clear;
       Form1.GPSFile.lines.BeginUpdate;
       Form1.GPSFile.Lines.LoadFromFile(OpenDialog1.FileName); //загрузить в reField выбранный файл
       Form1.GPSFile.lines.EndUpdate;
       Form1.Caption:= Format('%s - [ %s ]', [Application.Title , ExtractFileName(OpenDialog1.FileName)]); //установить заголовок дочернего окна в название файла
       StatusBar1.Panels[1].Text:='Рядків : '+IntToStr(Gpsfile.Lines.Count);
       StatusBar1.Panels[6].Text:='Результат';
       pbprocess.Position:=0;
       NewInfoBox;
    end;{if}
  end;{idNo}
  idCancel: exit;
end;{CAse}
end;

procedure TForm1.tbSaveAsClick(Sender: TObject);
var
   SaveFil:string;
Label verx;
begin
verx:
If SaveDialog1.Execute then
   Begin
    SaveFil:=SaveDialog1.FileName;
    if FileExists(SaveFil) then
     Begin
      case MessageDlg('Файл  '+ExtractFileName(SaveFil)+'  вже існує. '+#13+' Замінити його?',mtWarning,[mbYes,mbNo,mbCancel],0) of
     idYes:   Begin
                Form1.GPSFile.Lines.SaveToFile(SaveDialog1.FileName);
                Form1.GPSFile.modified:=false;
                 StatusBar1.Panels[6].Text:='Результат';
                 pbprocess.Position:=0;
                 NewInfoBox;
                Form1.Caption:= Format('%s - [ %s ]', [Application.Title , ExtractFileName(SaveDialog1.FileName)]);//установить заголовок дочернего окна в название файла
              end; {idYes}
     idNo:     goto verx;
     idCancel: exit;
   end;{Case}
   end {if}
   else
         Begin
           Form1.GPSFile.Lines.SaveToFile(SaveDialog1.FileName);
           Form1.GPSFile.modified:=false;
           //Father.StatusBar1.Panels[1].Text:='';
           Form1.Caption:= Format('%s - [ %s ]', [Application.Title , ExtractFileName(SaveDialog1.FileName)]);//установить заголовок дочернего окна в название файла
         end; {else}
end;{if}
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
Case MessageDlg('Ви хочете зберегти зміни?',mtConfirmation,[mbYes,mbNo,mbCancel],0) of
     idYes:tbSaveAsClick(sender);
     idNo: exit;
     idCancel: CanClose:=FAlse;
end;{case}
end;

procedure TForm1.tbReplaceClick(Sender: TObject);
begin
SPos:=GPSFile.SelStart;
ReplaceDialog1.Execute;
end;

procedure TForm1.ReplaceDialog1Replace(Sender: TObject);
Label
      FinS;
begin
  Form1.GPSFile.HideSelection:=True;
  FinS: if pos(ReplaceDialog1.FindText,Form1.GPSFile.Text)<>0 then
        Begin
             Form1.GPSFile.SelStart:=pos(ReplaceDialog1.FindText,Form1.GPSFile.Text)-1;
             Form1.GPSFile.SelLength:=Length(ReplaceDialog1.FindText);
             Form1.GPSFile.SelText:=ReplaceDialog1.ReplaceText;
             GoTo FinS;
        end; {if}
  Form1.GPSFile.HideSelection:=False;
end;

procedure TForm1.ReplaceDialog1Find(Sender: TObject);
Begin
   with ReplaceDialog1 do
begin
 GPSFile.SelStart:=Pos(AnsiLowerCase(FindText), AnsiLowerCase(Copy(GPSFile.Lines.Text, SPos+1, Length(GPSFile.Lines.Text))))+SPos-1;
    if GPSFile.SelStart>=SPos
    then
    begin
      {Выделение найденного текста}
      GPSFile.SelLength:=Length(FindText);
      {Изменение начальной позиции поиска}
      SPos:=GPSFile.SelStart+GPSFile.SelLength+1;
      end
      else
       MessageDlg('Вираз "'+ReplaceDialog1.FindText+'" не найдене!',mtConfirmation,[mbOk],0);
    end;
GPSFile.SetFocus;
end;


procedure TForm1.tbFindClick(Sender: TObject);
begin
SPos:=GPSFile.SelStart;
FindDialog1.Execute;
end;

procedure TForm1.FindDialog1Find(Sender: TObject);
begin
  with FindDialog1 do
begin
if frMatchCase in Options
  {Поиск с учетом регистра}
  then GPSFile.SelStart:=Pos(FindText,Copy(GPSFile.Lines.Text, SPos+1, Length(GPSFile.Lines.Text)))+SPos-1
  {Поиск без учёта регистра}
  else GPSFile.SelStart:=Pos(AnsiLowerCase(FindText), AnsiLowerCase(Copy(GPSFile.Lines.Text, SPos+1, Length(GPSFile.Lines.Text))))+SPos-1;
    if GPSFile.SelStart>=SPos
    then
    begin
      {Выделение найденного текста}
      GPSFile.SelLength:=Length(FindText);
      {Изменение начальной позиции поиска}
      SPos:=GPSFile.SelStart+GPSFile.SelLength+1;
      end
      else
       MessageDlg('Вираз "'+FindDialog1.FindText+'" не найдене!',mtConfirmation,[mbOk],0);
    end;
GPSFile.SetFocus;
end;

procedure TForm1.tbAboutClick(Sender: TObject);
begin
AboutBox.ShowModal;
end;

//поля включені
Procedure Tform1.FildEnable;
Begin
groupbox1.Enabled:=true;
btRemove.Enabled:=True;
end;{FildEnable}

//поля виключені
Procedure TForm1.FildDisable;
Begin
groupbox1.Enabled:=false;
btRemove.Enabled:=False;
end;{FildDisable}

//вибрані супутники
Procedure Tform1.CheckedGPS;
var
   RemoveSatelit2,GPSNameToRemove2:string;
   nremoveGps2,k2,i2,GPSCount2,ii2:integer;
   NewSatText:string;
Begin
if ActivatemeSatelit.Checked = True then
Begin
if mesatelit.Text<>'' then
 begin
       GPS01.Checked:=False;
       GPS02.Checked:=False;
       GPS03.Checked:=False;
       GPS04.Checked:=False;
       GPS05.Checked:=False;
       GPS06.Checked:=False;
       GPS07.Checked:=False;
       GPS08.Checked:=False;
       GPS09.Checked:=False;
       GPS10.Checked:=False;
       GPS11.Checked:=False;
       GPS12.Checked:=False;
       GPS13.Checked:=False;
       GPS14.Checked:=False;
       GPS15.Checked:=False;
       GPS16.Checked:=False;
       GPS17.Checked:=False;
       GPS18.Checked:=False;
       GPS19.Checked:=False;
       GPS20.Checked:=False;
       GPS21.Checked:=False;
       GPS22.Checked:=False;
       GPS23.Checked:=False;
       GPS24.Checked:=False;
       GPS25.Checked:=False;
       GPS26.Checked:=False;
       GPS27.Checked:=False;
       GPS28.Checked:=False;
       GPS29.Checked:=False;
       GPS30.Checked:=False;
       GPS31.Checked:=False;
       GPS32.Checked:=False;
  if pos('G',mesatelit.text)<>0 then
   Begin
       //знаходимо к-ть супутників
      RemoveSatelit2:=meSatelit.Text;
      nRemoveGPS2:=0;
      k2:=length(RemoveSatelit2);
      For i2:=1 to k2 do
       if RemoveSatelit2[i2]='G' then
        nRemoveGPS2:=nRemoveGPS2+1;  //к-ть супутників в полі me satelit

      //знаходимо співпадання і ставим галку
      GPSCount2:=1;
      for ii2:=1 to nRemoveGPS2 do
       begin
        GPSNameToRemove2:=Copy(RemoveSatelit2,GPSCount2,3);
          if GPSNameToRemove2 = 'G 1' then
           GPS01.Checked:=True;
          if GPSNameToRemove2 = 'G 2' then
           GPS02.Checked:=True;
          if GPSNameToRemove2 = 'G 3' then
           GPS03.Checked:=True;
          if GPSNameToRemove2 = 'G 4' then
           GPS04.Checked:=True;
          if GPSNameToRemove2 = 'G 5' then
           GPS05.Checked:=True;
          if GPSNameToRemove2 = 'G 6' then
           GPS06.Checked:=True;
          if GPSNameToRemove2 = 'G 7' then
           GPS07.Checked:=True;
          if GPSNameToRemove2 = 'G 8' then
           GPS08.Checked:=True;
          if GPSNameToRemove2 = 'G 9' then
           GPS09.Checked:=True;
          if GPSNameToRemove2 = 'G10' then
           GPS10.Checked:=True;
          if GPSNameToRemove2 = 'G11' then
           GPS11.Checked:=True;
          if GPSNameToRemove2 = 'G12' then
           GPS12.Checked:=True;
          if GPSNameToRemove2 = 'G13' then
           GPS13.Checked:=True;
          if GPSNameToRemove2 = 'G14' then
           GPS14.Checked:=True;
          if GPSNameToRemove2 = 'G15' then
           GPS15.Checked:=True;
          if GPSNameToRemove2 = 'G16' then
           GPS16.Checked:=True;
          if GPSNameToRemove2 = 'G17' then
           GPS17.Checked:=True;
          if GPSNameToRemove2 = 'G18' then
           GPS18.Checked:=True;
          if GPSNameToRemove2 = 'G19' then
           GPS19.Checked:=True;
          if GPSNameToRemove2 = 'G20' then
           GPS20.Checked:=True;
          if GPSNameToRemove2 = 'G21' then
           GPS21.Checked:=True;
          if GPSNameToRemove2 = 'G22' then
           GPS22.Checked:=True;
          if GPSNameToRemove2 = 'G23' then
           GPS23.Checked:=True;
          if GPSNameToRemove2 = 'G24' then
           GPS24.Checked:=True;
          if GPSNameToRemove2 = 'G25' then
           GPS25.Checked:=True;
          if GPSNameToRemove2 = 'G26' then
           GPS26.Checked:=True;
          if GPSNameToRemove2 = 'G27' then
           GPS27.Checked:=True;
          if GPSNameToRemove2 = 'G28' then
           GPS28.Checked:=True;
          if GPSNameToRemove2 = 'G29' then
           GPS29.Checked:=True;
          if GPSNameToRemove2 = 'G30' then
           GPS30.Checked:=True;
          if GPSNameToRemove2 = 'G31' then
           GPS31.Checked:=True;
          if GPSNameToRemove2 = 'G32' then
           GPS32.Checked:=True;
          GpsCount2:=GpsCount2+3;
       end;{for}
   end;{if}
 end;{if}
end{if}
else
    Begin
     meSatelit.Text:='';
     NewSatText:='';
     if GPS01.Checked = True then
      NewSatText:=NewsatText+'G 1';
     if GPS02.Checked = True then
      NewSatText:=NewsatText+'G 2';
     if GPS03.Checked = True then
      NewSatText:=NewsatText+'G 3';
     if GPS04.Checked = True then
      NewSatText:=NewsatText+'G 4';
     if GPS05.Checked = True then
      NewSatText:=NewsatText+'G 5';
     if GPS06.Checked = True then
      NewSatText:=NewsatText+'G 6';
     if GPS07.Checked = True then
      NewSatText:=NewsatText+'G 7';
     if GPS08.Checked = True then
      NewSatText:=NewsatText+'G 8';
     if GPS09.Checked = True then
      NewSatText:=NewsatText+'G 9';
     if GPS10.Checked = True then
      NewSatText:=NewsatText+'G10';
     if GPS11.Checked = True then
      NewSatText:=NewsatText+'G11';
     if GPS12.Checked = True then
      NewSatText:=NewsatText+'G12';
     if GPS13.Checked = True then
      NewSatText:=NewsatText+'G13';
     if GPS14.Checked = True then
      NewSatText:=NewsatText+'G14';
     if GPS15.Checked = True then
      NewSatText:=NewsatText+'G15';
     if GPS16.Checked = True then
      NewSatText:=NewsatText+'G16';
     if GPS17.Checked = True then
      NewSatText:=NewsatText+'G17';
     if GPS18.Checked = True then
      NewSatText:=NewsatText+'G18';
     if GPS19.Checked = True then
      NewSatText:=NewsatText+'G19';
     if GPS20.Checked = True then
      NewSatText:=NewsatText+'G20';
     if GPS21.Checked = True then
      NewSatText:=NewsatText+'G21';
     if GPS22.Checked = True then
      NewSatText:=NewsatText+'G22';
     if GPS23.Checked = True then
      NewSatText:=NewsatText+'G23';
     if GPS24.Checked = True then
      NewSatText:=NewsatText+'G24';
     if GPS25.Checked = True then
      NewSatText:=NewsatText+'G25';
     if GPS26.Checked = True then
      NewSatText:=NewsatText+'G26';
     if GPS27.Checked = True then
      NewSatText:=NewsatText+'G27';
     if GPS28.Checked = True then
      NewSatText:=NewsatText+'G28';
     if GPS29.Checked = True then
      NewSatText:=NewsatText+'G29';
     if GPS30.Checked = True then
      NewSatText:=NewsatText+'G30';
     if GPS31.Checked = True then
      NewSatText:=NewsatText+'G31';
     if GPS32.Checked = True then
      NewSatText:=NewsatText+'G32';
     meSatelit.Text:=NewSatText;
    end;{else}
end;{CheckedGps}

//визначаємо дату для пошуку
Function TForm1.DataSesion:string;
var
   datastr:string;
   j:integer;
begin
datastr:=meData.text;
insert(' ',datastr,1);
for j:=1 to 2 do
Delete(datastr,pos('.',dataStr),length('.'));
insert(' ',datastr,4);
insert(' ',datastr,7);
if datastr[5]='0' then
begin
insert(' ',datastr,5);
Delete(datastr,6,1);
end;{if}
if datastr[7]='0' then
begin
insert(' ',datastr,7);
Delete(datastr,8,1);
end;{if}
DataSesion:=datastr;
end;

//визначаємо початковий час пошуку
Function TForm1.TimeSesion:string;
var
   DataVTime:string;
   j:integer;
begin
DataVTime:=meVTime.text;
 insert(' ',DataVTime,1);
for j:=1 to 2 do
Delete(DataVTime,pos(':',DataVTime),length(':'));
insert(' ',DataVTime,4);
insert(' ',DataVTime,7);
if DataVTime[2]='0' then
begin
insert(' ',DataVTime,2);
Delete(DataVTime,3,1);
end;{if}
if DataVTime[5]='0' then
begin
insert(' ',DataVTime,5);
Delete(DataVTime,6,1);
end;{if}
if DataVTime[8]='0' then
begin
insert(' ',DataVTime,8);
Delete(DataVTime,9,1);
end;{if}
TimeSesion:=DataVTime;
end;

Procedure Tform1.NewInfoBox;
Begin
    //формуємо заголовок таблиці інфобокса
  Infobox.Clear;
  Infobox.Lines.Add('Відомість видалення');
  Infobox.Lines.Add('');
  Infobox.Lines.Add('————————————————————————————————————————————————————————————————————————————————————————————————————————————————');
  Infobox.Lines.Add('|    Дата і час    |  Рядок   |Суп. до|Суп. після|     Суп. для       |   Видалені суп.    |    Дата і час     |');
  Infobox.Lines.Add('|                  |          |       |          |     видалення      |                    |    видалення      |');
  Infobox.Lines.Add('————————————————————————————————————————————————————————————————————————————————————————————————————————————————');
end;

//позиція курсора в рядку статусу
procedure TForm1.UpdateCursorPos;
var
  CharPos: TPoint;
begin
 CharPos.Y:=GPSFile.CaretPos.Y+1;
  CharPos.X:=GPSFile.CaretPos.X+1;
  StatusBar1.Panels[0].Text := Format(sColRowInfo, [CharPos.Y, CharPos.X]);
end;

procedure TForm1.btRemoveClick(Sender: TObject);
var
   paramStr:string;  //рядок з параметрами
   RemoveSatelit:string; //супутники з рядка me satelit
   GPSNameToRemove:string; //cупутник який видаляється
   Line1,NewTimeSesion:string;
   nGPS,nRemoveGPS,posGPS:integer;     //к-ть супутників у рядку
   k:integer;    //довжина ряка з параметрами
   i,i1,ii,cp,gpsCount,res1:integer;
   insertSatelit:integer; //супутникі які вставляються у рядок
   VHour,Vmin,DHour,Dmin:integer;
   Vsec,Dsec:real;
   procentFor,interval1:integer;
   vgg,dgg,procent,pp1:real;
   ibrows:integer;
   ibdel, ibInSatline,ibSatIn:string;
   lengthIB:integer;
   cpib,ngpsib,insertsatelitib,datatimeib,line1ib,textib:string;
begin
//поля неактивні
  FildDisable;
//вибрані супутники для видалення
CheckedGPS;
//ініціалізація змінних
ibrows:=1; ibdel:=''; ibSatIn:=''; insertSatelit:=0;  cp:=1;
VHour:=StrToInt(copy(meVTime.Text,1,2));
Vmin:=StrToInt(copy(meVTime.Text,4,2));
Vsec:=StrToFloat(copy(meVTime.Text,7,10));
DHour:=StrToInt(copy(meDTime.Text,1,2));
Dmin:=StrToInt(copy(meDTime.Text,4,2));
Dsec:=StrToFloat(copy(meDTime.Text,7,10));
Line1:=DataSesion+TimeSesion;
NewTimeSesion:='';
//встановлюємо значення прогрес бара
interval1:=StrToInt(etInterval.Text);
vgg:=vsec+vmin*60+vhour*3600;
dgg:=dsec+dmin*60+dhour*3600;
procent:=((dgg-vgg)/interval1);
pbprocess.Max:=Round(procent);

//завантаження параметрів у рядок статусу
StatusBar1.Panels[5].Text:=etInterval.Text;
StatusBar1.Panels[3].Text:=IntToSTR(dHour-vhour)+':'+IntToSTR(dmin-vmin)+':'+FloatToSTR(dsec-vsec);
statusbar1.Update;
REPEAT
//знаходимо рядок першого параметра
GPSFile.HideSelection:=True;
if pos(Line1,GPSFile.Text) <> 0 then
 Begin
     Form1.GPSFile.lines.BeginUpdate;
     //GPSFile.SetFocus();
     GPSFile.HideSelection:=False;
     GPSFile.SelStart:=Pos(Line1,GPSFile.Text)-1;
     cp:=gpsfile.CaretPos.Y;
     paramStr:= GPSFile.Lines.Strings[cp];
     ibInsatLine:=paramstr;

//знаходимо к-ть супутників у рядку
      nGPS:=0;
      k:=length(paramStr);
      For i:=1 to k do
       if paramStr[i]='G' then
        nGPS:=nGps+1;  //к-ть супутників у рядку

//знаходимо к-ть супутників в полі maSatelite
      RemoveSatelit:=meSatelit.Text;
      nRemoveGPS:=0;
      k:=length(RemoveSatelit);
      For i:=1 to k do
       if RemoveSatelit[i]='G' then
        nRemoveGPS:=nRemoveGPS+1;  //к-ть супутників в полі me satelit
        StatusBar1.Panels[4].Text:=IntToStr(nRemoveGPS);
        statusbar1.Update;

//Знаходимо співпадання супутників супутники
      posgps:=0;
      GPSCount:=1;
      for ii:=1 to nRemoveGPS do
       begin
        GPSNameToRemove:=Copy(RemoveSatelit,GPSCount,3);
        if pos(GPSNameToRemove,paramStr) <> 0 then
         Begin
             posgps:=posgps+1;  //к-ть супутників у рядку
             ibdel:=ibdel+GPSNameToRemove;//назви супутників для видалення
             GpsCount:=GpsCount+3;
         end; {if}
          insertSatelit:=nGPS-posgps;
       end;{for}

//вставляємо нову к-ть супутників
    //  insertSatelit:=nGPS-nRemoveGPS;
       if (nGPS>=10) and (insertSatelit<10) then
        begin
         insert(' '+IntToStr(insertSatelit),paramStr,pos('G',paramStr)-2);
         Delete(paramStr,pos('G',paramStr)-2,length(IntTostr(nGPS)));
        end;{if}
       if (nGPS>=10) and (insertSatelit>=10) then
        begin
         insert(IntToStr(insertSatelit),paramStr,pos('G',paramStr)-2);
         Delete(paramStr,pos('G',paramStr)-2,length(IntTostr(nGPS)));
        end;{if}
       if (nGPS<10) and (insertSatelit<10) then
        begin
         insert(IntToStr(insertSatelit),paramStr,pos('G',paramStr)-1);
         Delete(paramStr,pos('G',paramStr)-1,length(IntTostr(nGPS)));
        end;{if}

//видаляюмо непотрібні дані супутників
      posgps:=0;
      GPSCount:=1;
      for ii:=1 to nRemoveGPS do
       begin
        GPSNameToRemove:=Copy(RemoveSatelit,GPSCount,3);
        if pos(GPSNameToRemove,paramStr) <> 0 then
         Begin
          k:=pos(GPSNameToRemove,paramStr);
          For i:=1 to k do
           begin
            if paramStr[i]='G' then
             posgps:=posgps+1;  //к-ть супутників у рядку
           end; {for}
          if posgps <> 0 then
           Begin
            gpsfile.Lines.Insert(cp+(posgps*2)-1,'empty');
            gpsfile.Lines.Insert(cp+(posgps*2),'empty');
            gpsfile.Lines.Delete(cp+(posgps*2)+1);
            gpsfile.Lines.Delete(cp+(posgps*2)+1);
          end;{if}
          GPSCount:=GPSCount+3;
          posgps:=0;
         end;{if}
       end;{for}

       
       for i1:=1 to nRemoveGPS do
        begin
         if pos('empty',GPSFile.Text) <> 0 then
          Begin
           GPSFile.SelStart:=Pos('empty',Copy(GPSFile.Text, SPos+1, Length(GPSFile.Text)))+SPos-1;
           if GPSFile.SelStart>=SPos then
           {Изменение начальной позиции поиска}
            SPos:=GPSFile.SelStart+5;
           gpsfile.Lines.Delete(gpsfile.CaretPos.Y);
           gpsfile.Lines.Delete(gpsfile.CaretPos.Y);
          end;{if}
        end;{for}

//вставляємо новий рядок параметрів
       GPSCount:=1;
       for ii:=1 to nRemoveGPS do
        begin
         GPSNameToRemove:=Copy(RemoveSatelit,GPSCount,3);
         k:=pos(GPSNameToRemove,paramStr);
         Delete(paramStr,k,3);
         GPSCount:=GPSCount+3;
        end;{for}
       //gpsfile.Lines.Text := StringReplace(GPSFile.Lines.Text,gpsfile.Lines.Strings[cp],paramstr,[rfReplaceAll]);

       gpsfile.Lines.Insert(cp,paramSTR);
       gpsfile.Lines.Delete(cp+1);

//Додаємо дані до Інfобокса
{if pos('G',ibInSatLine) <> 0 then
Begin
 while pos('G',ibInSatLine) <> 0 do
  Begin
   ibSatIn:=ibSatIn+Copy(ibInSatLine,pos('G',ibInSatLine),3);
   Delete(ibInSatLine,pos('G',ibInSatLine),3);
  end;{while}
{end;{if}
line1ib:=line1;
cpib:=IntToStr(cp);
ngpsib:=IntTostr(ngps);
insertsatelitib:=IntTostr(insertSatelit);
textib:=meSatelit.Text;
DataTimeib:=(dateTostr(date)+'/'+timetostr(time));
if pos('.',line1ib)<>0 then
 delete(line1ib,pos('.',line1ib),8);
 with infobox do
  begin
   if length(cpib)<10 then
    for lengthib:=1 to 10-length(cpib) do
     cpib:=cpib+' ';
   if length(ngpsib)<7 then
    for lengthib:=1 to 7-length(ngpsib) do
     ngpsib:=ngpsib+' ';
   if length(insertsatelitib)<10 then
    for lengthib:=1 to 10-length(insertsatelitib) do
     insertsatelitib:=insertsatelitib+' ';
   if length(textib)<20 then
    for lengthib:=1 to 20-length(textib) do
     textib:=textib+' ';
   if length(ibdel)<20 then
    for lengthib:=1 to 20-length(ibdel) do
     ibdel:=ibdel+' ';
   lines.Add(line1ib+' |'+                     //Дата і час
             cpib+'|'+              //Рядо
             ngpsib+'|'+            //Супутників до
             insertsatelitib+'|'+   //Супутників після
             textib+'|'+            //Супутники для видалення
             ibdel+'|'+                     //видалені супутники
             datatimeib+'|') //дата і Час видалення
  end;{with}
infobox.Update;
ibdel:='';

//перехід до іншого рядка параметрів
       Vsec:=Vsec+StrToFloat(etInterval.Text);
       if Vsec>= 60 then
        Begin
         Vsec:=Vsec-60;
         Vmin:=Vmin+1;
         if Vmin>=60 then
          Begin
           Vmin:=Vmin-60;
           VHour:=VHour+1;
           if VHour>=24 then
            Begin
             MessageDlg('Кількість годин перевищує допустиму норму!'+#13+'Зміньть дату та поставте новий час пошуку.',mtError,[mbOk],0);
             exit;
            end;{if}
          end;{if}
        end;{if}
       if VHour<10 then
         NewTimeSesion:='  '+IntToStr(VHour)
       else NewTimeSesion:=' '+IntToStr(VHour);
       if Vmin<10 then
        NewTimeSesion:=NewTimeSesion+'  '+IntToStr(Vmin)
       else NewTimesesion:=NewTimeSesion+' '+IntToStr(Vmin);
       if Vsec<10 then
        NewTimeSesion:=NewTimeSesion+'  '+FloatToStr(vsec)
       else NewTimeSesion:=NewTimeSesion+' '+FloatToStr(vsec);
       //прогрес бар
       pbprocess.Position:=pbprocess.Position+1;
       pbprocess.Update;
       Line1:=DataSesion+NewTimeSesion;
 Form1.GPSFile.lines.EndUpdate;
 end{if}
 else exit;
UNTIL (Vhour=Dhour) and (vmin=dmin) and (vsec=dsec);

 StatusBar1.Panels[2].Text:='Рядків : '+IntToStr(Gpsfile.Lines.Count);
 StatusBar1.Panels[6].Text:='Готово';
 statusbar1.Update;
 pbprocess.Position:=pbprocess.Max;
 pbprocess.Update;
 MessageDlg('Процедура видалення успішно завершена',mtInformation,[mbOk],0);
 //поля активні
 fildEnable;
end;

procedure TForm1.GPSFileChange(Sender: TObject);
begin
UpdateCursorPos;
end;

procedure TForm1.GPSFileKeyPress(Sender: TObject; var Key: Char);
begin
UpdateCursorPos;
end;

procedure TForm1.GPSFileMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
UpdateCursorPos;
end;

procedure TForm1.meDataKeyPress(Sender: TObject; var Key: Char);
begin
  Case Key of
    #8,'0'..'9':   ;
    #13: SelectNext(Sender as TWinControl, True, True );
  else Key:=Chr(0);
 end;{Case}
end;

procedure TForm1.meDTimeKeyPress(Sender: TObject; var Key: Char);
begin
  Case Key of
    #8,'0'..'9':   ;
    #13: etInterval.SetFocus;
  else Key:=Chr(0);
 end;{Case}
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
NewInfoBox
end;{TForm1.FormCreate}

procedure TForm1.ToolButton6Click(Sender: TObject);
var
   SaveFil:string;
Label verx;
begin
verx:
If SDinfobox.Execute then
   Begin
    SaveFil:=SDinfobox.FileName;
    if FileExists(SaveFil) then
     Begin
      case MessageDlg('Файл  '+ExtractFileName(SaveFil)+'  вже існує. '+#13+' Замінити його?',mtWarning,[mbYes,mbNo,mbCancel],0) of
     idYes:   Begin
               infobox.Lines.SaveToFile(sdinfobox.FileName);
              end; {idYes}
     idNo:     goto verx;
     idCancel: exit;
   end;{Case}
   end {if}
   else
         Begin
         infobox.Lines.SaveToFile(sdinfobox.FileName);
         end; {else}
end;{if}

end;

procedure TForm1.sbaddGPSClick(Sender: TObject);
begin
 if mesatelit.Visible = false then
  Begin
   mesatelit.Visible:=True;
   gbCheckGPS.Visible:=False;
   Activatemesatelit.Visible:=true;
  end{if}
 else
     Begin
      mesatelit.Visible:=False;
      Activatemesatelit.Visible:=false;
     end;{else}
end;

procedure TForm1.sbCheckGPSClick(Sender: TObject);
begin
 if ActivatemeSatelit.checked = false then
  Begin
    if gbCheckGPS.Visible = false then
      Begin
       gbCheckGPS.Visible:=true;
        mesatelit.Visible:=False;
        Activatemesatelit.Visible:=false;
    end{if}
    else gbCheckGPS.Visible:=false
  end;{if}
end;

procedure TForm1.ActivatemesatelitClick(Sender: TObject);
begin
if ActivatemeSatelit.Checked = true then
 meSatelit.Enabled:=true
else meSatelit.Enabled:=False;
end;

end.
