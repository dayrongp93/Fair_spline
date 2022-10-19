function varargout = Ploteo(varargin)
% PLOTEO MATLAB code for Ploteo.fig
%      PLOTEO, by itself, creates a new PLOTEO or raises the existing
%      singleton*.
%
%      H = PLOTEO returns the handle to a new PLOTEO or the handle to
%      the existing singleton*.
%
%      PLOTEO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTEO.M with the given input arguments.
%
%      PLOTEO('Property','Value',...) creates a new PLOTEO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Ploteo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Ploteo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Ploteo

% Last Modified by GUIDE v2.5 14-May-2016 14:16:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Ploteo_OpeningFcn, ...
                   'gui_OutputFcn',  @Ploteo_OutputFcn, ...
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


% --- Executes just before Ploteo is made visible.
function Ploteo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Ploteo (see VARARGIN)

% Choose default command line output for Ploteo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Ploteo wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Para cambiar el icono del boton de mover el plano
[a,map]=imread('images/hand.png');
[r,c,d]=size(a);
x=ceil(r/25);
y=ceil(c/45);
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;
set(handles.pushbutton12,'CData',g);

% Esto es para mostrar los mensajes de error adecuadamente cuando se inicia
% la interfaz
ipuntos = 0;
ipuntos2 = 0;
itang = 0;
ipoints = 0;
save('start/Ipuntos.mat','ipuntos')
save('start/Itang.mat','itang')
save('start/Ipuntos2.mat','ipuntos2')
save('start/Ipoints.mat','ipoints')

% --- Outputs from this function are returned to the command line.
function varargout = Ploteo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

uicontrol('Style','pushbutton', ...
'Units','normalized', ...
'Position',[.85 .11 .12 .05], ...
'FontSize',10, ...
'String','Reiniciar',...
'Callback','clear all; close all;clc; Ploteo;');

uicontrol('Style','pushbutton', ...
'Units','normalized', ...
'Position',[.86 .25 .10 .05], ...
'FontSize',10, ...
'String','Mostrar Superficie',...
'Callback','Revolucion;');


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% En esta sección vamos a pedir al usuario que introdusca los puntos que
% desea interpolar 
set(handles.pushbutton16,'Enable','off')
set(handles.pushbutton17,'Enable','off')
% Para fijar los ejes donde se describen los puntos de interpolación

hold on
% Initially, the list of points is empty.
a = handles.rango;
axis([0 a 0 a])
xy = [];
m = 0;
but = 1;
while but == 1
    [xi,yi,but] = ginput(1);
    plot(xi,yi,'o','MarkerEdgeColor','k',...
                'MarkerFaceColor','b',...
                'MarkerSize',5)
    m = m+1;
    xy(:,m) = [xi;yi];
end
save('start/aux2.mat','m')
ipuntos = 1;
save('start/Ipuntos.mat','ipuntos')
% Vamos a guardar la configuración de puntos
handles.puntos = xy;
guidata(hObject,handles)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% En esta seccion vamos a pedir al usuario que defina las direcciones
% tangentes asociadas a cada punto.

load('start/Ipuntos.mat')
if ipuntos == 0
    errordlg('ERROR: Los puntos de interpolación no se han insertado.','ERROR')
else
    set(handles.pushbutton16,'Enable','off')
    set(handles.pushbutton17,'Enable','off')
    hold on
    % Initially, the list of points is empty.
    a = handles.rango;
    axis([0 a 0 a])
    p = handles.puntos;
    k = size(p,2);
    xy = zeros(2,k);
    for i = 1:k
        [xi,yi] = ginput(1);
        plot(xi,yi,'o','MarkerEdgeColor','k',...
                    'MarkerFaceColor','k',...
                    'MarkerSize',3)
        xy(:,i) = [xi;yi];
    end
    % Vamos a plotear las direcciones tangentes asociadas a cada punto
    tang = zeros(2,2*k);
    hold on
    for i=1:k
        tang(:,2*i-1) = p(:,i);
        tang(:,2*i) = xy(:,i);
        plot([p(1,i) xy(1,i)],[p(2,i) xy(2,i)],'k','LineWidth',2)
    end 

    % Vamos a guardar la configuración de puntos
    itang = 1;
    save('start/Itang.mat','itang')
    handles.tangentes = tang;
    n = size(tang,2)/2;
    Tang = zeros(2,n);
    for i=1:n
        Tang(:,i) = tang(:,2*i) - tang(:,2*i-1);
    end
    Puntos = handles.puntos;
    Tangentes = Tang;
    save('start/Datos.mat','Puntos','Tangentes')
end
guidata(hObject,handles)

% --- Executes when uipanel1 is resized.
function uipanel1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Vamos a generar la curva interpolante
% Primeramente carguemos los puntos del plano y las tangentes
load('start/Datos.mat')
load('start/Ipuntos.mat')
load('start/Itang.mat')
local = 0;
if ipuntos == 0
    errordlg('ERROR: No se han insertado los puntos de interpolación.','ERROR')
elseif itang == 0
    errordlg('ERROR: No se han insertado los puntos de interpolación.','ERROR')
else
    local = size(Puntos,2)-1;
    Points = cell(1,local);
    iter = handles.iter; % Número de iteraciones del proceso de subdivisión
    % Vamos a ver la seleccion del usuario. Si seleccionó el método de
    % Newton o el de la regla de Oro.
    seleccion = handles.seleccion;
    if seleccion == 1
        % Vamos a resolver el problema de forma local
        for k=1:local
            b0 = Puntos(:,k);
            b2 = Puntos(:,k+1);
            v1 = Tangentes(:,k);
            v2 = Tangentes(:,k+1);
            b1 = BTP(b0,b2,v1,v2);
            if b1==0
                errordlg('ERROR: Dos vectores son colineales','ERROR')
                break
            end
            B = [b0';b1;b2'];
            omega = minimizar(B,iter);
            [~,Points{k},~,~,~] = Subdivision_rule_1(B,abs(omega),iter);
            Subdivision_rule(B,omega,iter)
        end
        ipoints = 1;
        save('start/Ipoints.mat','ipoints')
        P = Points{1}';
        for i=2:local
            P = [P;Points{i}'];
        end
        save('start/superficie.mat','P')
    elseif seleccion == 2
        % Vamos a resolver el problema de forma local
        for k=1:local
            b0 = Puntos(:,k);
            b2 = Puntos(:,k+1);
            v1 = Tangentes(:,k);
            v2 = Tangentes(:,k+1);
            b1 = BTP(b0,b2,v1,v2);
            if b1==0
                errordlg('ERROR: Dos vectores son colineales','ERROR')
                break
            end
            B = [b0';b1;b2'];
            omega = oro(B,iter);
            [~,Points{k},~,~,~] = Subdivision_rule_1(B,abs(omega),iter);
            Subdivision_rule(B,omega,iter)
        end
        ipoints = 1;
        save('start/Ipoints.mat','ipoints')
        P = Points{1}';
        for i=2:local
            P = [P;Points{i}'];
        end
        save('start/superficie.mat','P')
    end
end
handles.local = local;
guidata(hObject,handles)



% --- Executes when uipanel4 is resized.
function uipanel4_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when uipanel2 is resized.
function uipanel2_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when uipanel3 is resized.
function uipanel3_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to uipanel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

% Vamos a dar las especificaciones de la entrada del número de iteraciones
Val = get(hObject,'String');
Newval = str2double(Val);
if isnan(Newval)==1
    errordlg('Introdusca un valor numérico','ERROR')
    set(hObject,'String','6')
    handles.iter = 6;
elseif strcmp(Newval,'')==1
    msbox('Introdusca un valor numérico')
    set(hObject,'String','6')
    handles.iter = 6;
else
    if Newval <=0
        warndlg('ADVERTENCIA: El número de iteraciones debe ser positivo','ADVERTENCIA')
        set(hObject,'String','6')
        handles.iter = 6;
    elseif Newval >= 15
        resp = questdlg('La canidad de iteraciones que desea que se ejecute es demasiado alta. ¿Desea cambiar el número de iteraciones?','ADVERTENCIA','Si','No','Si');
        if strcmp(resp,'No')
            handles.iter = Newval;
            return;
        else
            set(hObject,'String','6')
            handles.iter = 6;
        end
    elseif round(Newval)~=Newval
        warndlg('El número de iteraciones debe ser un número entero','ADVERTENCIA')
        Newval = round(Newval);
        aux = num2str(Newval);
        set(hObject,'String',aux)
        handles.iter = Newval;
    else
        handles.iter = Newval;
    end
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.iter = 6;
guidata(hObject,handles);


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
axis([0 a 0 a])
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
handles.rango = 10;
guidata(hObject,handles);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% En esta sección vamos a pedir al usuario que introduzca nuevos puntos
% para la interpolación. 

load('start/Ipuntos.mat')
load('start/Itang.mat')
load('start/Datos.mat')
if ipuntos==0 
    errordlg('ERROR: No se han insertado los puntos de interpolación primeros','ERROR')
elseif itang==0
    errordlg('ERROR: No se han insertado las tangentes de interpolación','ERROR')
else
    hold on
    % Initially, the list of points is empty.
    p = handles.puntos;
    k = size(p,2);
    xy = zeros(2,k-1);
    for i = 1:k-1
        [xi,yi] = ginput(1);
        plot(xi,yi,'o','MarkerEdgeColor','k',...
                    'MarkerFaceColor','g',...
                    'MarkerSize',5)
        xy(:,i) = [xi;yi];
    end
    ipuntos2 = 1;
    save('start/Ipuntos2.mat','ipuntos2')
    % Vamos a guardar la configuración de puntos
    handles.puntos2 = xy;
    Puntos2 = xy;
    save('start/Datos.mat','Puntos','Tangentes','Puntos2')
end
guidata(hObject,handles)


% --- Executes when selected object is changed in uipanel7.
function uipanel7_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel7 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

% Este es para el panel de selección
if (hObject == handles.radiobutton1)
    % Se ha seleccionado el primero
    set(handles.radiobutton1,'ForegroundColor','Black')
    set(handles.radiobutton2,'ForegroundColor','White')
    set(handles.pushbutton9,'Enable','off')
    set(handles.pushbutton10,'Enable','on')
    set(handles.pushbutton11,'Enable','on')
    set(handles.radiobutton3,'ForegroundColor','White')
    set(handles.radiobutton3,'Enable','off')
    set(handles.radiobutton4,'ForegroundColor','White')
    set(handles.radiobutton4,'Enable','off')
elseif (hObject == handles.radiobutton2)
    % Se ha seleccionado la segunda
    set(handles.radiobutton1,'ForegroundColor','White')
    set(handles.radiobutton2,'ForegroundColor','Black')
    set(handles.pushbutton10,'Enable','off')
    set(handles.pushbutton11,'Enable','off')
    set(handles.pushbutton9,'Enable','on')
    set(handles.radiobutton3,'ForegroundColor','Black')
    set(handles.radiobutton3,'Enable','on')
    set(handles.radiobutton4,'ForegroundColor','Black')
    set(handles.radiobutton4,'Enable','on')
end

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Primeramente vamos a crgar los datos
load('start/Datos.mat')
% Veamos si ya se cargaron los puntos a interpolar
load('start/Ipuntos2.mat')
local = 0;
if ipuntos2 == 0
    % No se han cargado
    errordlg('ERROR: No se han cargado los datos.','ERROR')
elseif ipuntos2 == 1
    % Se cargaron
    local = size(Puntos,2)-1;
    Points = cell(1,local);
    iter = handles.iter; % Número de iteraciones del proceso de subdivisión
    % Vamos a resolver el problema de forma local
    for k=1:local
        b0 = Puntos(:,k);
        b2 = Puntos(:,k+1);
        v1 = Tangentes(:,k);
        v2 = Tangentes(:,k+1);
        b1 = BTP(b0,b2,v1,v2);
        if b1==0
            errordlg('ERROR: Dos vectores son colineales','ERROR')
            break
        end
        B = [b0';b1;b2'];
        P = Puntos2(:,k);
        omega = Baricentricas(B',P);
        if omega == -1
            plot(Puntos2(1,k),Puntos2(2,k),'o','MarkerEdgeColor','k',...
                        'MarkerFaceColor','g',...
                        'MarkerSize',8)
            warndlg('ADVERTENCIA: Uno de los puntos no está en el interior de un triángulo','ADVERTENCIA')
        else
            [~,Points{k},~,~,~] = Subdivision_rule_1(B,abs(omega),iter);
            Subdivision_rule(B,omega,iter)
            plot(Puntos2(1,k),Puntos2(2,k),'o','MarkerEdgeColor','k',...
                        'MarkerFaceColor','g',...
                        'MarkerSize',8) 
        end
    end
    ipoints = 1;
    save('start/Ipoints.mat','ipoints')
    P = Points{1}';
    for i=2:local
        P = [P;Points{i}'];
    end
    save('start/superficie.mat','P')
end
handles.local = local;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function uipanel7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.seleccion=1;
guidata(hObject,handles);


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pan on


% --- Executes during object creation, after setting all properties.
function pushbutton12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Para cambiar el icono del boton de mover el plano


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% En esta sección vamos a pedir al usuario que introduzca los puntos
% del eje de simetría de la superficie.

load('start/Ipuntos.mat')
load('start/Itang.mat')
load('start/Datos.mat')
load('start/Ipoints.mat')
load('start/Points.mat')
if ipuntos==0 
    errordlg('ERROR: No se han insertado los puntos de interpolación primeros','ERROR')
elseif itang==0
    errordlg('ERROR: No se han insertado las tangentes de interpolación','ERROR')
elseif ipoints==0
    errordlg('ERROR: No se ha representado la curva','ERROR')
else
    hold on
    % Initially, the list of points is empty.
    xy = [];
    for i = 1:2
        [xi,yi] = ginput(1);
        plot(xi,yi,'o','MarkerEdgeColor','k',...
                    'MarkerFaceColor','y',...
                    'MarkerSize',5)
        xy(:,i) = [xi;yi];
    end
    handles.eje = xy;
    plot([xy(1,1) xy(1,2)],[xy(2,1) xy(2,2)],'y','Linewidth',2)
    save('start/Eje.mat','xy')
end
% Vamos a guardar la configuración de puntos
guidata(hObject,handles)


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton4,'Enable','off')
set(handles.pushbutton5,'Enable','off')
set(handles.text3,'ForegroundColor','white')   	
% Con este botón el usuario puede abrir una base de puntos ya elaborada
[FileName,Path]=uigetfile({'*.mat'}, 'Abrir');
if isequal(FileName,0)
    return
else
    load([Path,'/',FileName]);
    hold on
    a = handles.rango;
    axis([0 a 0 a])
    plot(Puntos(1,:),Puntos(2,:),'o','MarkerEdgeColor','k',...
                'MarkerFaceColor','b',...
                'MarkerSize',5)
    ipuntos = 1;
    save('start/Ipuntos.mat','ipuntos')
end
handles.puntos = Puntos;
guidata(hObject,handles)

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Con este botón el usuario puede abrir una base de tangentes ya elaborada
load('start/Ipuntos.mat')
if ipuntos == 0
    errordlg('ERROR: Los puntos de interpolación no se han insertado.','ERROR')
else
    set(handles.pushbutton4,'Enable','off')
    set(handles.pushbutton5,'Enable','off')
    set(handles.text3,'ForegroundColor','white')
    [FileName,Path]=uigetfile({'*.mat'}, 'Abrir');
    if isequal(FileName,0)
        return
    else
        p = handles.puntos;
        k = size(p,2);
        load([Path,'/',FileName]);
        p2 = p + Tangentes;
        a = handles.rango;
        axis([0 a 0 a])
        for i=1:k
            plot(p2(1,i),p2(2,i),'o','MarkerEdgeColor','k',...
                    'MarkerFaceColor','k',...
                    'MarkerSize',3)
            plot([p(1,i) p2(1,i)],[p(2,i) p2(2,i)],'k','LineWidth',2)
        end
        itang = 1;
        save('start/Itang.mat','itang')
        handles.tangentes = Tangentes;
        Puntos = handles.puntos;
        save('start/Datos.mat','Puntos','Tangentes')
    end
end

guidata(hObject,handles)


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
cond = get(hObject,'Value');
if cond == 1
    axis equal
else
    axis normal
end

% --- Executes when selected object is changed in uipanel11.
function uipanel11_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel11 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

% Este es para el panel de selección
if (hObject == handles.radiobutton3)
    handles.seleccion = 1;
    % Se ha seleccionado el primero
elseif (hObject == handles.radiobutton4)
    handles.seleccion = 2;
    % Se ha seleccionado el segundo
end
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function uipanel11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.seleccion = 1;
guidata(hObject,handles)
