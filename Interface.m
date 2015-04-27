function varargout = Interface(varargin)
global fs n audio nn;
fs=44100;
n=0.05;
nn=100;
audio = [];
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

% Last Modified by GUIDE v2.5 25-Apr-2015 13:03:28

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
varargout{1} = handles.output;





% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Init')
% live = audiorecorder(44100, 16, 1);



input = dsp.AudioRecorder;
output = dsp.AudioPlayer;

tic;

while (toc < 10)
    stream = step(input);
    axes(handles.axes1);
    
    
    out_L = length(stream) -1; % + length(stream)-1;
out_L2 = pow2(nextpow2(out_L))
    ff=real(ifft(stream, out_L2));

    plot(ff);
    axes(handles.axes2);
    result=effect_wahwah(stream);
    plot(result);
    
    step(output, result);
    
    
    % drawnow;
end
disp('end')

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

function stop(one, two)
disp('End')

function analyze(one, two)
audio = getaudiodata(one);
play(one)
plot(audio)
disp('Hola')

function start(one, two)
disp('Inicio')


% global audio fs nn
% index=get(handles.popupmenu1, 'Value');
% result = [];
% while nn > 1
%     
%     player = audioplayer(result, fs);
% 
%   clear audio result;
%   audio=lib_audio();
% axes(handles.axes2);
% plot(audio)
% axes(handles.axes1);
% 
% switch index
%     case 1
%         result=effect_tremolo(audio);
%     case 2
%         result=effect_rinng(audio);
%     case 3
%         result=effect_distortion(audio);
%     case 4
%         result=effect_wahwah(audio);
%     case 5
%         result=effect_overdrive(audio);
%     case 6
%         audio2=lib_audio('Nice Drum Room');
%         result=effect_cathedral_reverb(audio, audio2);
% end
% plot(result)
% 
% 
%     
%     
%     nn=nn-1;
% end


% wavplay(audio, fs);


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

set(hObject, 'String', {'effect_tremolo', 'effect_rinng', 'effect_distortion', 'effect_wahwah', 'effect_overdrive', 'effect_cathedral_reverb'});
