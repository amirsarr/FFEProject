function varargout = FCUI(varargin)
% FCUI MATLAB code for FCUI.fig
% Author:     Amir Sarreshtehdari
% Supervisor: Negar Elhami-Khorasani
% Department of Civil, Structural and Environmental Engineering, University at Buffalo

% See also: GUIDE, GUIDATA, GUIHANDLES

% Last Modified by GUIDE v2.5 12-Aug-2020 23:34:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FCUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FCUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
    
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});

end
% End initialization code - DO NOT EDIT


% --- Executes just before FCUI is made visible.
function FCUI_OpeningFcn(hObject, ~, handles, varargin)
% Update handles structure
guidata(hObject, handles);
[~,~,A]=xlsread('Bridges.csv');
handles.A=A;
assignin('base','A',A); 
guidata(hObject, handles)

function varargout = FCUI_OutputFcn(~, ~, ~) 
% varargout{1} = handles.output;

% -------------------------------------------------------------------------
% ------------------------ Axes -------------------------------------------
% -------------------------------------------------------------------------

% 1) Slight DS axes
function Figure_Slight_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.04 .68 .23 .26]);
set(hObject,'FontName','Arial');
set(hObject,'FontSize',15);
set(hObject,'ColorOrder',jet(15));
function Figure_Slight_DeleteFcn(~, ~, ~)
function Slight_txt_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.043 .95 .22 .035]);
set(hObject,'String','Slight Damage State');



% 2) Moderate DS axes
function Figure_Moderate_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.31 .68 .23 .26]);
set(hObject,'FontName','Arial');
set(hObject,'FontSize',15);
set(hObject,'ColorOrder',jet(15));
function Figure_Moderate_DeleteFcn(~, ~, ~)
function Moderate_txt_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.313 .95 .22 .035]);
set(hObject,'String','Moderate Damage State');

% 3) Extensive DS axes
function Figure_Extensive_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.04 .33 .23 .26]);
set(hObject,'FontName','Arial');
set(hObject,'FontSize',15);
set(hObject,'ColorOrder',jet(15));
function Figure_Extensive_DeleteFcn(~, ~, ~)
function Extensive_DS_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.043 .6 .22 .035]);
set(hObject,'String','Extensive Damage State');



% 4) Complete DS axes
function Figure_Complete_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.31 .33 .23 .26]);
set(hObject,'FontName','Arial');
set(hObject,'FontSize',15);
set(hObject,'ColorOrder',jet(15));
function Figure_Complete_DeleteFcn(~, ~, ~)
function Complete_DS_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.313 .6 .22 .035]);
set(hObject,'String','Complete Damage State');

%--------------------------------------------------------------------------
%
% - Listbox Callback

function listbox_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .67 .3 .3]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function listbox_Callback( ~ , ~ , handles)
A=handles.A;
str_listbox = get(handles.listbox,'String');
val_listbox = get(handles.listbox,'Value');
Picked_Info=handles.Picked_Info;

Col1 = find(contains(A(1,:),'Slight')==1);
ColMin = min(Col1);

ColDescrip = find(contains(A(1,:),'Description')==1);
if size(val_listbox,2)==1
set(handles.Description,'String',{Picked_Info{val_listbox,ColDescrip}});

set(handles.Fragility_Parameters,'String',...
   ['Slight med.=',Picked_Info(val_listbox,   ColMin),'Slight disp.='    ,Picked_Info(val_listbox, ColMin+1),' '...
    'Moderate med.=',Picked_Info(val_listbox, ColMin+2),'Moderate disp.=',Picked_Info(val_listbox, ColMin+3),' '...
    'Extensive med.=',Picked_Info(val_listbox,ColMin+4),'Extensive disp.=',Picked_Info(val_listbox,ColMin+5),' '...
    'Complete med.=',Picked_Info(val_listbox, ColMin+6),'Complete disp.=',Picked_Info(val_listbox, ColMin+7)]);

else
   set(handles.Description,'String','Description');
   set(handles.Fragility_Parameters,'String','Fragility Curves Parameters');
end

%--------------------------------------------------------------------------
function Fragility_Parameters_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.88 .46 .1 .52]);
set(hObject,'HorizontalAlignment','left');

function Border_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.879 .459 .102 .5225]);
set(hObject,'String',' ');

function Description_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.73 .335 .13 .3]);

function Border2_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.729 .334 .132 .3025]);

% -------------------------------------------------------------------------
% ------------------------ Buttons ----------------------------------------
% -------------------------------------------------------------------------
%
% - Clear_Plot    : 
% - Clear_Listbox : 
% - ClearTable    : 
% - FcRange       : calculates the range of median and standard deviation
% - Plot_Button   : plot the selcted data

%--------------------------------------------------------------------------
% - Clear_Plot button

function Clear_Plot_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.89 .27 .075 .05]);

function Clear_Plot_Callback(~, ~, handles)

cla(handles.Figure_Slight);
delete(handles.Figure_Slight.Legend)
cla(handles.Figure_Moderate);
delete(handles.Figure_Moderate.Legend)
cla(handles.Figure_Extensive);
delete(handles.Figure_Extensive.Legend)
cla(handles.Figure_Complete);
delete(handles.Figure_Complete.Legend)


%--------------------------------------------------------------------------
% - Clear_Listbox button

function Clear_Listbox_Callback(~, ~, handles)
set(handles.listbox,'String',' ');

function Clear_Listbox_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.89 .32 .075 .05]);

%--------------------------------------------------------------------------
% - ClearTable button

function ClearTable_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.89 .37 .075 .05]);

function ClearTable_Callback(~, ~, handles)
TabSlctdIndex = handles.TabSlctdIndex;
handles.FC_Table.Data(TabSlctdIndex(:,1),TabSlctdIndex(:,2))={[]};

%--------------------------------------------------------------------------
% - FcRange button

function FcRange_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.89 .119 .075 .05]);

function FcRange_Callback( ~ , ~ , handles)
A = handles.A;
Font_Size = str2double(get(handles.Legend_Size,'string'));
str_listbox = get(handles.listbox,'String');
val_listbox = get(handles.listbox,'Value');
Picked_Info = handles.Picked_Info;

Med=[];
SD= [];

Col1 = find(contains(A(1,:),'Slight')==1);
ColMin = min(Col1);
Col2 = find(contains(A(1,:),'Complete')==1);
ColMax = max(Col2);

Med=cell2mat(Picked_Info(val_listbox,[Col1:2:ColMax-1]));
SD =cell2mat(Picked_Info(val_listbox,[Col1+1:2:ColMax]));
   
BrValue=[{min(Med(:,1),[],1)},{max(Med(:,1),[],1)},...
         {min(SD(:,1),[],1)},{max(SD(:,1),[],1)},...
         {min(Med(:,2),[],1)},{max(Med(:,2),[],1)},...
         {min(SD(:,2),[],1)},{max(SD(:,2),[],1)},...
         {min(Med(:,3),[],1)},{max(Med(:,3),[],1)},...
         {min(SD(:,3),[],1)},{max(SD(:,3),[],1)},...
         {min(Med(:,4),[],1)},{max(Med(:,4),[],1)},...
         {min(SD(:,4),[],1)},{max(SD(:,4),[],1)}];
     
  FCTabDat=get(handles.FC_Table,'Data');
  BrStr = str2num(get(handles.BrRow,'string'));
  RowTmp = reshape(BrStr,length(BrStr),1);
FCTabDat(RowTmp,:) = repmat(BrValue,length(BrStr),1);
set(handles.FC_Table,'Data',FCTabDat)

%--------------------------------------------------------------------------
% - Show button

function Show_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.89 .22 .075 .05]);

function Show_Callback(hObject, ~ , handles)

A=handles.A;
assignin('base','handles',handles);
str_Super = get(handles.Superstructure_Type,'String');
   val_Super = get(handles.Superstructure_Type,'Value');
str_Intensity = get(handles.Intensity_Type,'String');
   val_Intensity = get(handles.Intensity_Type,'Value');
str_Span = get(handles.No_of_Span,'String');
   val_Span = get(handles.No_of_Span,'Value');
str_Joint = get(handles.Joint_Type,'String');
   val_Joint = get(handles.Joint_Type,'Value');  
str_Soil = get(handles.Soil_Type,'String');
   val_Soil = get(handles.Soil_Type,'Value');   
str_Columns = get(handles.No_of_Columns,'String');
   val_Columns = get(handles.No_of_Columns,'Value');
str_Skew = get(handles.Skewed_or_NonSkewed,'String');
   val_Skew = get(handles.Skewed_or_NonSkewed,'Value');
str_Curve = get(handles.Horizontal_Curve,'String');
   val_Curve = get(handles.Horizontal_Curve,'Value');
str_Abutment = get(handles.Abutment_Stiffness,'String');
   val_Abutment = get(handles.Abutment_Stiffness,'Value');
str_SD_NSD = get(handles.SD_NSD,'String');
   val_SD_NSD = get(handles.SD_NSD,'Value');
str_State = get(handles.State,'String');
   val_State = get(handles.State,'Value');
str_Retrofit = get(handles.Retrofitting,'String');
   val_Retrofit = get(handles.Retrofitting,'Value');
str_Fault = get(handles.Fault,'String');
   val_Fault = get(handles.Fault,'Value');
str_Time = get(handles.Time_Dependency,'String');
   val_Time = get(handles.Time_Dependency,'Value');
str_Env = get(handles.Environment,'String');
   val_Env = get(handles.Environment,'Value');
   
main=[num2str(val_Super),num2str(val_Intensity),num2str(val_Span),num2str(val_Joint),...
      num2str(val_Soil),num2str(val_Columns),num2str(val_Skew),num2str(val_Curve),...
      num2str(val_Abutment),num2str(val_SD_NSD),num2str(val_State),num2str(val_Retrofit),...
      num2str(val_Fault),num2str(val_Time),num2str(val_Env)];

Str_Form=[cellstr(str_Super{val_Super}),str_Intensity{val_Intensity},str_Span{val_Span},...
           str_Joint{val_Joint},str_Soil{val_Soil},str_Columns{val_Columns},...
           str_Skew{val_Skew},str_Curve{val_Curve},str_Abutment{val_Abutment},...
           str_SD_NSD{val_SD_NSD},str_State{val_State},str_Retrofit{val_Retrofit},...
           str_Fault{val_Fault},str_Time{val_Time},str_Env{val_Env}];  
       
assignin('base','str_Form',Str_Form);   

k=1;
for i=1:size(main,2)
   if strcmp(main(1,i),'1')~=1
        Picked{:,k}=[num2str(i+1);main(i);Str_Form(i)]; 
          k=k+1;
      elseif strcmp(main(1,i),'1')==1
      continue
   end
end
assignin('base','main',main);
   assignin('base','Picked',Picked);

   
   
B=zeros(size(A,1),15);
for j=1:size(Picked,2)
    for i=1:size(A,1)
        if strcmp(A{i,str2num(Picked{1,j}{1,1})},(Picked{1,j}{3,1}))==1
            B(i,str2num(Picked{1,j}{1,1}))=1;
        else 
            continue
        end
    end
end



for i=1:size(B,1)
    C(i,1)=sum(B(i,:));
    if C(i,1)==size(Picked,2)
         D(i,:)=A(i,:);
    elseif C(i,1)~=size(Picked,2)
        continue
    end
end


assignin('base','C',C);
assignin('base','B',B);



for j=1:size(D,2)
k=1;
for i=1:size(D,1)
    if isequal(D(i,j),{[]})~=1
        Picked_Info{k,j}=D{i,j};
        k=k+1;
    else 
        continue
    end
end
end
assignin('base','Picked_Info',Picked_Info);
handles.Picked_Info=Picked_Info;

PickedNum=cellstr(num2str([1:1:size(Picked_Info,1)]'));
Picked_Info_w_Num = strcat(PickedNum, {'- '}, Picked_Info(:,1));

set(handles.listbox,'String',Picked_Info_w_Num);
guidata(hObject, handles);
%--------------------------------------------------------------------------
% - Plot button

function Plot_Button_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.89 .169 .075 .05]);

function Plot_Button_Callback(hObject, ~ , handles)

% Numbers were derived from the file DATA when the program is running
A=handles.A; 
Picked_Info=handles.Picked_Info;
x=[0:0.01:1.5];
str_listbox = get(handles.listbox,'String');
   val_listbox = get(handles.listbox,'Value');
assignin('base','Picked_Info',Picked_Info);
assignin('base','val_listbox',val_listbox);
y = zeros(4*size(val_listbox,2),length(x));



Col1 = find(contains(A(1,:),'Slight')==1);
ColMin = min(Col1);
Col2 = find(contains(A(1,:),'Complete')==1);
ColMax = max(Col2);



k1=1;
for i=1:size(val_listbox,2)
for j = ColMin : 2 : ColMax
y(k1,:)=logncdf(x,log(Picked_Info{val_listbox(1,i),j}),Picked_Info{val_listbox(1,i),j+1});
k1 = k1 + 1;
end
end 

assignin('base','x',x);
assignin('base','y',y);
Font_Size=str2double(get(handles.Legend_Size,'string'));
legend_1=get(handles.Legend);
legend_0=get(handles.No_legend);
handles.y=y;
handles.x=x;
fs = 12;
fn = 'Arial';

PickedNum=cellstr(num2str([1:1:size(Picked_Info,1)]'));
Picked_Info_w_Num = strcat(PickedNum, {'- '}, Picked_Info(:,1));

if legend_1.Value==1 && legend_0.Value==0 && isempty(Font_Size)==0
for j=0:((size(y,1)/4)-1)
    
        Plottxt = [Picked_Info_w_Num{val_listbox(1,j+1),1}([1:min(end,14)]),'...'];
        
        axes(handles.Figure_Slight);
        hSlight = plot(x,y(1+4*j,:),'DisplayName',Plottxt,'LineWidth',1.5);
        legend('Show','Location','southeast','NumColumns',1,'FontSize',Font_Size);
        xlim([0 1.5]);
        ylim([0 1]);
        set(gca,'FontSize',fs);
        set(gca,'FontName',fn);
        set(gca,'XGrid','on');
        set(gca,'YGrid','on'); 
        set(gca,'GridLineStyle',':');
        set(gca,'GridColor',[0 0 0]);
        set(gca,'GridAlpha',0.6);
        hold on

        
        
        axes(handles.Figure_Moderate);
        plot(x,y(2+4*j,:),'DisplayName',Plottxt,'LineWidth',1.5);
        legend('Show','Location','southeast','NumColumns',1,'FontSize',Font_Size);
        set(gca,'FontSize',Font_Size);
        set(gca,'FontSize',fs);
        set(gca,'FontName',fn);
        set(gca,'XGrid','on');
        set(gca,'YGrid','on'); 
        set(gca,'GridLineStyle',':');
        set(gca,'GridColor',[0 0 0]);
        set(gca,'GridAlpha',0.6);        
        xlim([0 1.5]);
        ylim([0 1]);
        hold on
        
        
        
        axes(handles.Figure_Extensive);
        plot(x,y(3+4*j,:),'DisplayName',Plottxt,'LineWidth',1.5);
        legend('Show','Location','southeast','NumColumns',1,'FontSize',Font_Size);
        set(gca,'FontSize',Font_Size);
        set(gca,'FontSize',fs);
        set(gca,'FontName',fn);
        set(gca,'XGrid','on');
        set(gca,'YGrid','on'); 
        set(gca,'GridLineStyle',':');
        set(gca,'GridColor',[0 0 0]);
        set(gca,'GridAlpha',0.6);        
        xlim([0 1.5]);
        ylim([0 1]);
        hold on
        
        
        
        axes(handles.Figure_Complete);
        plot(x,y(4+4*j,:),'DisplayName',Plottxt,'LineWidth',1.5);
        legend('Show','Location','southeast','NumColumns',1,'FontSize',Font_Size);
        set(gca,'FontSize',Font_Size);
        set(gca,'FontSize',fs);
        set(gca,'FontName',fn);
        set(gca,'XGrid','on');
        set(gca,'YGrid','on'); 
        set(gca,'GridLineStyle',':');
        set(gca,'GridColor',[0 0 0]);
        set(gca,'GridAlpha',0.6);        
        xlim([0 1.5]);
        ylim([0 1]);
        hold on
end 
elseif legend_1.Value==0 && legend_0.Value==1

for j=0:((size(y,1)/4)-1)
    
    
    
        axes(handles.Figure_Slight);
        Slight_axes_line = ['Slight_axes_',num2str(j)];
        plot(x,y(1+4*j,:),'LineWidth',1.5);
        set(gca,'FontSize',fs);
        set(gca,'FontName',fn);
        set(gca,'XGrid','on');
        set(gca,'YGrid','on'); 
        set(gca,'GridLineStyle',':');
        set(gca,'GridColor',[0 0 0]);
        set(gca,'GridAlpha',0.6);        
        xlim([0 1.5]);
        ylim([0 1]); 
        hold on
        
        
        
        axes(handles.Figure_Moderate);
        plot(x,y(2+4*j,:),'LineWidth',1.5);
        set(gca,'FontSize',fs);
        set(gca,'FontName',fn);
        set(gca,'XGrid','on');
        set(gca,'YGrid','on'); 
        set(gca,'GridLineStyle',':');
        set(gca,'GridColor',[0 0 0]);
        set(gca,'GridAlpha',0.6);        
        xlim([0 1.5]);
        ylim([0 1]);        
        hold on
        
        
        
        axes(handles.Figure_Extensive);
        plot(x,y(3+4*j,:),'LineWidth',1.5);
        set(gca,'FontSize',fs);
        set(gca,'FontName',fn);
        set(gca,'XGrid','on');
        set(gca,'YGrid','on'); 
        set(gca,'GridLineStyle',':');
        set(gca,'GridColor',[0 0 0]);
        set(gca,'GridAlpha',0.6);        
        xlim([0 1.5]);
        ylim([0 1]);        
        hold on
        
        
        
        axes(handles.Figure_Complete);
        plot(x,y(4+4*j,:),'LineWidth',1.5);
        set(gca,'FontSize',fs);
        set(gca,'FontName',fn);
        set(gca,'XGrid','on');
        set(gca,'YGrid','on'); 
        set(gca,'GridLineStyle',':');
        set(gca,'GridColor',[0 0 0]);
        set(gca,'GridAlpha',0.6);        
        xlim([0 1.5]);
        ylim([0 1]);        
        hold on
end   
end
guidata(hObject, handles);

% -------------------------------------------------------------------------
% --------------------------- Listbox List --------------------------------
% -------------------------------------------------------------------------

function Superstructure_Type_Callback(~, ~, ~)
function Superstructure_Type_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .62 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function Intensity_Type_Callback(hObject, ~, handles)
guidata(hObject,handles);
function Intensity_Type_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .584 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function No_of_Span_Callback(~, ~, ~)
function No_of_Span_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .548 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function Joint_Type_Callback(~, ~, ~)
function Joint_Type_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .512 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function Soil_Type_Callback(~, ~, ~)
function Soil_Type_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .476 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function No_of_Columns_Callback(~, ~, ~)
function No_of_Columns_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .44 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function Skewed_or_NonSkewed_Callback(~, ~, ~)
function Skewed_or_NonSkewed_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .404 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function Horizontal_Curve_Callback(~, ~, ~)
function Horizontal_Curve_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .369 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function Abutment_Stiffness_Callback(~, ~, ~)
function Abutment_Stiffness_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .333 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function SD_NSD_Callback(~, ~, ~)
function SD_NSD_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .297 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
% --- Executes on selection change in State.
function State_Callback(~, ~, ~)
function State_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .261 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function Retrofitting_Callback(~, ~, ~)
function Retrofitting_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .225 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function Fault_Callback(~, ~, ~)
function Fault_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .189 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function Time_Dependency_Callback(~, ~, ~)
function Time_Dependency_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .153 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function Environment_Callback(~, ~, ~)
function Environment_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .117 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function Environment_Exposure_Callback(~, ~, ~)
function Environment_Exposure_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .10 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function edit2_Callback(~, ~, ~)
function edit2_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .06 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------
function Skew_Value_Callback(~, ~, ~)
function Skew_Value_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .02 .16 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% -------------------------------------------------------------------------
function Plot_Out_Callback(~, ~, ~)
function FCUI_Callback(~, ~, ~)
function Untitled_1_Callback(~, ~, ~)
function Untitled_2_Callback(~, ~, ~)
function No_Environment_Exposure_Callback(~, ~, ~)
function Marine_Splash_Exposure_Callback(~, ~, ~)
function Marine_Atmospheric_Exposure_Condition_Callback(~, ~, ~)
function Deicing_Salt_Exposure_Callback(~, ~, ~)

% -------------------------------------------------------------------------
% --------------------------- FC table ------------------------------------
% -------------------------------------------------------------------------

function FC_Table_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.038 .013 .464 .26]);
ColName = [{'LB Med.(Slight)'},{'UB Med.(Slight)'},...
           {'LB Disp.(Slight)'},{'UB Disp.(Slight)'},...
           {'LB Med.(Mod.)'},{'UB Med.(Mod.)'},...
           {'LB Disp.(Mod.)'},{'UB Disp.(Mod.)'},...
           {'LB Med.(Ext.)'},{'UB Med.(Ext.)'},...
           {'LB Disp.(Ext.)'},{'UB Disp.(Ext.)'},...
           {'LB Med.(Comp.)'},{'UB Med.(Comp.)'},...
           {'LB Disp.(Comp.)'},{'UB Disp.(Comp.)'}];
set(hObject,'ColumnName',ColName);
set(hObject,'FontSize',12);
function FC_Table_CellSelectionCallback(hObject, eventdata, handles)
TabSlctdIndex = eventdata.Indices;
handles.TabSlctdIndex = TabSlctdIndex;
assignin('base','TabSlctdIndex',TabSlctdIndex);
guidata(hObject, handles);
function FC_Table_CellEditCallback(~, ~, ~)
% -------------------------------------------------------------------------
% - BrRow : to define the bridge row to assign input
function BrRow_Callback(~, ~, ~)
function BrRow_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.842 .162 .039 .065]);
set(hObject,'FontWeight','normal');
set(hObject,'FontSize',10);
set(hObject,'BackgroundColor',[0.7 0.7 0.7]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function BridgeRowtxt_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.733 .162 .11 .065]);
set(hObject,'FontSize',10);
set(hObject,'FontWeight','bold');
set(hObject,'String',['Bridge number','(multiple entry in table)']);

function NumBrEdit_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.84 .241 .04 .065]);
set(hObject,'FontSize',10);
set(hObject,'FontWeight','normal');
set(hObject,'string','e.g. 10');
set(hObject,'BackgroundColor',[0.7 0.7 0.7]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function NumBrTxt_CreateFcn( hObject, ~ , ~ )
set(hObject,'Units','normalized');
set(hObject,'Position',[.732 .241 .11 .065]);
set(hObject,'FontSize',10);
set(hObject,'FontWeight','bold');
set(hObject,'BackgroundColor',[119 172 48]./255);
set(hObject,'String','Total number of bridges');
function NumBrEdit_Callback(hObject, ~, handles)
NumBr=str2double(get(handles.NumBrEdit,'String'));
handles.output = hObject;
handles.NumBr=NumBr;
handles.FC_Table.Data=repmat({},NumBr,16);
for i = 1:NumBr
    RowNameTab(i,1)=cellstr(['Bridge (',num2str(i),')']);
end
handles.FC_Table.RowName=RowNameTab;

% --------------------------------------------------------------------
function uibuttongroup_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.56 .01 .1 .09]);
set(hObject,'FontSize',12);
set(hObject,'BackgroundColor',[1 1 1]);
set(hObject,'HighlightColor',[1 1 1]);

function uibuttongroup_ButtonDownFcn(~, ~, ~)

% -------------------------------------------------------------------------
% --------------------------- Legend --------------------------------------
% -------------------------------------------------------------------------

function Legend_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'FontSize',12);
set(hObject,'BackgroundColor',[1 1 1]);
set(hObject,'Position',[0.032 0.523 0.952 0.446]);
function Legend_ButtonDownFcn(~, ~, ~)
function Legend_Callback(~, ~, ~)

function No_legend_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'FontSize',12);
set(hObject,'BackgroundColor',[1 1 1]);
set(hObject,'Position',[0.032 0.092 0.952 0.446]);
function No_legend_ButtonDownFcn(~, ~, ~)
function No_legend_Callback(~, ~, ~)

function Legend_Size_Callback(~, ~, ~)
function Legend_Size_CreateFcn(hObject, ~, ~)
set(hObject,'Units','normalized');
set(hObject,'Position',[.66 .035 .067 .03]);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% -------------------------------------------------------------------------
% ------------- Open_File and Save_data Command ---------------------------
% -------------------------------------------------------------------------

function Save_data_ClickedCallback(~, ~, handles)
Picked_Info=handles.Picked_Info;
val_listbox = get(handles.listbox,'Value');
A=handles.A;

Saved_Info=cell(size(val_listbox,1)+1,size(Picked_Info,2));
Saved_Info(1,:)=A(1,:);
for i=1:size(val_listbox,2)
    Saved_Info(i+1,:)=Picked_Info(val_listbox(1,i),:);
end
assignin('base','Saved_Info',Saved_Info);
delete('Data.xlsx');
xlswrite('Data.xlsx',Saved_Info);
% set(handles.figure1,'PaperPositionMode','auto');
% set(handles.figure1,'Renderer','painters');
% saveas(handles.figure1,'GUI_snap','meta');

% --------------------------------------------------------------------
function Save_Plot_Data_ClickedCallback(~, ~, handles)
x=handles.x;
y=handles.y;
DS=[cellstr('Slight');'Moderate';'Extensive';'Complete'];
Picked_Info=handles.Picked_Info;
str_listbox = get(handles.listbox,'String');
   val_listbox = get(handles.listbox,'Value');
for j=1:size(val_listbox,2)
   for i=1:size(DS,1)
     title(i+size(DS,1)*(j-1),:)=[DS(i,:),Picked_Info(val_listbox(1,j),1)];
   end
end
assignin('base','title',title);
PlotData=[[{'IM'},{'X'};title],[num2cell(x);num2cell(y)]];
assignin('base','saved_Info_Plot',PlotData);
PlotData=[PlotData(1,:);sortrows(PlotData([2:size(PlotData)],:),1)];
uisave('PlotData','PlotData');
% --------------------------------------------------------------------
function Open_File_ClickedCallback(~, ~, ~)

% --------------------------------------------------------------------
function Save_Table_Data_ClickedCallback(~, ~, handles)
BrFCParRng = get(handles.FC_Table,'Data');
uisave('BrFCParRng','BrFCParRng');

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(~, ~, ~)
function figure1_SizeChangedFcn(~, ~, ~)


% --- Executes during object creation, after setting all properties.
function Instruction_txt_CreateFcn(hObject, ~, ~)
set(hObject','FontSize',9);
set(hObject,'FontWeight','normal');
set(hObject,'Units','normalized');
set(hObject,'Position',[.73 .02 .1 .11]);
