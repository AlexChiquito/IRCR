Fss = 44100;
ypr = wavrecord(5*Fss,Fss,'int16');
resultado=wahwah(ypr);
wavplay(resultado);