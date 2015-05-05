function varargout = Interface(varargin)
global fs n audio nn;
fs=8000;
n=0.05;
nn=100;

% INTERFACE MATLAB code for Interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interface

% Last Modified by GUIDE v2.5 01-May-2015 08:37:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interface_OpeningFcn, ...
                   'gui_OutputFcn',  @Interface_OutputFcn, ...
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

% --- Executes just before Interface is made visible.
function Interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interface (see VARARGIN)

% Choose default command line output for Interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% This sets up the initial plot - only do when we are invisible
% so window can get raised using Interface.

if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end

% UIWAIT makes Interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interface_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
global fs;
varargout{1} = handles.output;
handles.audio2=[];
handles.audio=[];
handles.audioraw=[];
handles.audioraw2=[];
handles.respuesta=[];
handles.grabarinterno = audiorecorder(fs,16,1);
% handles.grabarinternotarjeta2 = audiorecorder(fs,16,2,2);
% handles.grabarinternotarjeta = audiorecorder(fs,16,1,2);
guidata(hObject,handles)






% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% live = audiorecorder(44100, 16, 1);
global fs;
index=get(handles.popupmenu1, 'Value');
live=false;
cha=1;
fsi=fs;
if isempty(handles.audio)
    if (index==6)
        cha=2;
        % fsi=2*fs;
    end
    % 'OutputNumUnderrunSamples', true,
   input = dsp.AudioRecorder('NumChannels', cha,'QueueDuration', 1, 'SamplesPerFrame', fsi, 'SampleRate', fs);
   %input2 = dsp.AudioRecorder('NumChannels', 2,'OutputNumOverrunSamples',true);
   live=true; 
else
   input = handles.audio;
end


output = dsp.AudioPlayer('SampleRate', fs, 'QueueDuration', 1);
    if ~isempty(handles.respuesta)
        respuesta_al_impulso=wavread(handles.respuesta);
    end;
    tic;
ciclo = 1;
enda=false;
 while ( (live && toc < 8) || ( ~live && ~isDone(input)) ) && ~enda
     %data=[floor(toc/ciclo), mod(toc, ciclo)];
        audio = step(input);
 switch index
     case 1
         result=effect_tremolo(audio);
     case 2
         result=effect_rinng(audio);
     case 3
         result=effect_distortion(audio);
     case 4
         result=effect_wahwah(audio);
     case 5
         result=effect_overdrive(audio);
     case 6
        result=effect_cathedral_reverb(audio,respuesta_al_impulso);
     case 7
         result=effect_vibrato(audio);
 end
    
    plot(handles.axes1,audio);
    plot(handles.axes2,result);    
    drawnow;
    %[size(audio);size(result)]
    %[audio, result]
    
    step(output, result);
    % enda=true;
 end
 release(output);
 release(input);
 disp('End of effect');
% end 
    % drawnow;
% AR = dsp.AudioRecorder('OutputNumOverrunSamples',true, 'SampleRate', 44100, 'SamplesPerFrame', 1024);
% AP = dsp.AudioPlayer('SampleRate',44100, 'QueueDuration',1, 'OutputNumUnderrunSamples', true);
%         
% disp('Speak into microphone now');
% tic;
% toc=0;
% while toc < 100,
%   audioIn = step(AR);
%   step(AP,audioIn);
%   toc = toc + 1;
% end
% release(AR);
% release(AP);
% disp('Recording complete'); 

% set(live, 'TimerPeriod', 0.05);
% set(live, 'StartFcn', @start);
% set(live, 'TimerFcn',@analyze);
% set(live, 'StopFcn', @stop)
% record(live)
% for v = 0:1:10
%     recordblocking(live, 1);
%     data=getaudiodata(live);
%     plot(data)
%     sound(data, 44100, 16);
% end

%recordblocking(live, 5);

%function stop(one, two)
%disp('End')




% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)


% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


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

set(hObject, 'String', {'effect_tremolo', 'effect_rinng', 'effect_distortion', 'effect_wahwah', 'effect_overdrive', 'effect_cathedral_reverb', 'effect_vibrato'});


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[nombre, ruta] = uigetfile({'*.*'});

set(handles.nombreaudio, 'String', nombre);
set(handles.limpiar, 'Enable', 'on');
%handles.audio=dsp.AudioFileReader(strcat(ruta,nombre));
handles.respuesta=strcat(ruta,nombre);
guidata(hObject,handles);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton4.
function pushbutton4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in limpiar.
function limpiar_Callback(hObject, eventdata, handles)

set(handles.nombreaudio, 'String', 'Selecciona un archivo');
set(handles.limpiar, 'Enable', 'off');
handles.audio=[];
guidata(hObject,handles);
% hObject    handle to limpiar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in grabar.
function grabar_Callback(hObject, eventdata, handles)

record(handles.grabarinterno);
set(handles.parar, 'Enable', 'on');
% hObject    handle to grabar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in parar.
function parar_Callback(hObject, eventdata, handles)
stop(handles.grabarinterno);
handles.audio= dsp.SignalSource(getaudiodata(handles.grabarinterno), 1024);
guidata(hObject,handles);
set(handles.parar, 'Enable', 'off');
set(handles.limpiar, 'Enable', 'on');
% hObject    handle to parar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in grabart.
function grabart_Callback(hObject, eventdata, handles)
% hObject    handle to grabart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
record(handles.grabarinternotarjeta);
record(handles.grabarinternotarjeta2);
set(handles.parart, 'Enable', 'on');


% --- Executes on button press in parart.
function parart_Callback(hObject, eventdata, handles)
% hObject    handle to parart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stop(handles.grabarinternotarjeta);
stop(handles.grabarinternotarjeta2);
%handles.audio= dsp.SignalSource(getaudiodata(handles.grabarinternotarjeta), 1024);
handles.audioraw= getaudiodata(handles.grabarinternotarjeta);
handles.audioraw2=getaudiodata(handles.grabarinternotarjeta2);
handles.audio= dsp.SignalSource(getaudiodata(handles.grabarinternotarjeta), 1024);
guidata(hObject,handles);
set(handles.parart, 'Enable', 'off');
set(handles.limpiar, 'Enable', 'on');


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
disp('Bye');


% guidata(hObject,handles);
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
