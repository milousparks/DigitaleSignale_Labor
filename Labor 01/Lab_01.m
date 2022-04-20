% Aufgabenblatt 1
%a
close all;
f=2; % Hz
t= [0 1]; % s
y= @(t) sin(2*pi*f*t);
fplot(y,t)
grid on
xlabel("t [s]")
hold on;
phi=30*pi/180;
fplot(@(t) sin(2*pi*f*t+phi),t,'--r')
legend('Ohne Phasenverschiebung','Mit Phasenverschiebung')
ylabel('Amplitude')
title('Sinus und 30°Phsaenverscchobener Sinus')
set(gca,'FontSize',15)

% Durch die Phasenverschiebung wird das Signal nach links verschoben
%%
% 1.2 Funktionsdarstellung mit Wertetabelle
close all;
clear;
f=2; % Hz
A=2; % Amplitude
t= [0 1]; % s
y= @(t) sin(2*pi*f*t);
fplot(y,'b',t)

tn=linspace(0,1,17);
sample=y(tn);
hold on;
plot(tn,sample,'--dg')
grid on
xlabel("t [s]")
ylabel('Amplitude')
set(gca,'FontSize',15)
stem(tn,sample,'black')
legend("Sin",'Sin Abgetastet und interpoliert','Sin Abtastung')
title('Abtastung des Sinus')
% Es wird mit 16 Hz abgetastet

%% 1.3 Quantisierung
close all;
clear;
f=2; % Hz
A=2 ;% Amplitude
t= [0 1]; % s
y= @(t) A*sin(2*pi*f*t);
fplot(y,'b',t)

tn=linspace(0,1,17);
sample=round(y(tn));
hold on;
stem(tn,sample,'black')
err=y(tn)-sample;
stem(tn,err,'r')
legend("Sin",'Sin Quantisiert mit N=5','Quantisierungsfehler')

grid on
xlabel("t [s]")
ylabel('Amplitude')
set(gca,'FontSize',15)
%%
% N-Bit Quantisierung
clear;
close all;
f=2; % Hz
A=1 ;% Amplitude
t= [0 1]; % s
y= @(t) A*sin(2*pi*f*t);

fplot(y,t)

%Abtastung
fs=16; %Hz Abtastung
tn=linspace(0,1,fs+1);
sample=y(tn); %Abgetastete sin-Werte

%Quantisierung
N=3; %Bit
level=2^N;
yq=quant(sample,level);

% Ausgabe Quantisiertes Signal
hold on
stem(tn,yq,'black')
% Ausgabe Fehler
err=y(tn)-yq;
stem(tn,err,'r')



%Formattierung
title('N-Bit Quantisierung')
legend("Sin",'Sin mit 16 Hz Abtastung/ 3-Bit quantisierung ','Quantisierungsfehler')
grid on
xlabel("t [s]")
ylabel('Amplitude')
set(gca,'FontSize',15)

% Der Quantisierungsfehler ist im Vergleich mit 1.3 gesunken, da unsere
% Quantisierungsstuffen erhöht wurden
%%
% 1.5 Audioausgabe
clear;
close all;
f=500; % Hz

A=1 ;% Amplitude

y= @(t) A*sin(2*pi*f*t);

%Abtastung
fs=44100; %2 Abtastung
tn=linspace(0,1,fs);
sample=y(tn); %Abgetastete sin-Werte

%Quantisierung
N=3; %Bit
level=2^N;
yq=quant(sample,level);

%Fehler
err=y(tn)-yq;

%Ausgabe
playblocking(audioplayer(sample,fs))
playblocking(audioplayer(yq,fs))
% Error Ausgabe
playblocking(audioplayer(err,fs))
% Der Ton wird Verzerrt und es ist ein Rausche zu hören

%% Vergleichsausgabe
clear;
close all;
f=500; % Hz

A=1 ;% Amplitude
t= [0 1]; % s
y= @(t) A*sin(2*pi*f*t); %Funktion

%Abtastung
fs=44100; % Abtastung
tn=linspace(0,1,fs);
sample=y(tn); %Abgetastete sin-Werte
n=2;
while n>1
    %Quantisierung
    level=2^(n-1);
    z=quant(sample,level-1);
    disp(["Sound mit",n-1,'Bit']);        
    playblocking(audioplayer(z,fs))
    n=n+1;
    if n==16
        for n=2:16
            level=2^(n-1);
            z=quant(sample,level-1);
            %Fehler berechnen
            err=y(tn)-z;
            disp(["Error mit",n-1,'Bit']);
            % Error Ausgabe
            playblocking(audioplayer(err,fs))
        end
        break;
    end

end

function y = quant(x,level)
y1=round(x*level);
y=y1/(level);
end