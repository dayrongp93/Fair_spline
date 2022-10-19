function varargout = Revolucion(varargin)
% REVOLUCION MATLAB code for Revolucion.fig
%      REVOLUCION, by itself, creates a new REVOLUCION or raises the existing
%      singleton*.
%
%      H = REVOLUCION returns the handle to a new REVOLUCION or the handle to
%      the existing singleton*.
%
%      REVOLUCION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REVOLUCION.M with the given input arguments.
%
%      REVOLUCION('Property','Value',...) creates a new REVOLUCION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Revolucion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Revolucion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Revolucion

% Last Modified by GUIDE v2.5 23-Apr-2016 17:53:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Revolucion_OpeningFcn, ...
                   'gui_OutputFcn',  @Revolucion_OutputFcn, ...
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


% --- Executes just before Revolucion is made visible.
function Revolucion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Revolucion (see VARARGIN)

% Choose default command line output for Revolucion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Revolucion wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Para cambiar el icono del boton de mover el plano
[a,map]=imread('images/hand.png');
[r,c,d]=size(a);
x=ceil(r/25);
y=ceil(c/45);
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;
set(handles.pushbutton3,'CData',g);

% Para cambiar el icono del boton de mover el plano
[a,map]=imread('images/rotate.jpg');
[r,c,d]=size(a);
x=ceil(r/25);
y=ceil(c/45);
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;
set(handles.pushbutton4,'CData',g);

% --- Outputs from this function are returned to the command line.
function varargout = Revolucion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

uicontrol('Style','pushbutton', ...
'Units','normalized', ...
'Position',[.87 .17 .10 .05], ...
'FontSize',10, ...
'String','Reiniciar',...
'Callback','clear all; close ;clc; Revolucion;');


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

Val = get(hObject,'Value');
handles.rango = 10 + 90*Val;
a = handles.rango;
axis([0 a 0 a 0 a])
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pan on


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

rotate3d on

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load('start/Ipoints.mat')
if ipoints == 0
    errordlg('ERROR: No se ha mostrado la curva interpolante. Cierre la ventana y vuelva a la ventana de ploteo','ERROR')
else
    set(handles.popupmenu1,'Enable','on')
    % Vamos a generar la superficie de revolución
    load('start/superficie.mat')
    load('start/Eje.mat')
    [X,Y,Z] = superficie(P',xy,50);
    surf(X,Y,Z)
    axis equal
    shading flat
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

% Este menú es para darle color a la superficie de revolución

inf=get(hObject,'Value');

switch inf
    case 1
        colormap jet
    case 2
        colormap hsv
    case 3
        colormap hot
    case 4
        colormap cool
    case 5
        colormap spring
    case 6
        colormap summer
    case 7
        colormap autumn
    case 8
        colormap winter
    case 9
        colormap gray
    case 10
        colormap bone
    case 11
        colormap copper
    case 12
        colormap pink
    case 13
        colormap lines
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
