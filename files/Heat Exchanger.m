%                         THIS PROGRAM PERFORMS CALCULATIONS ON SHELL-AND-TUBE HEAT EXCHANGER


clear all
close all hidden
                             %INTRODUCTION
disp('                                    HEAT EXCHANGER ')
disp('This program analyses the performance of a shell and tube heat exchanger:')
disp('for a given exchanger,for which construction details are known,')
disp('and for which the inlet flow rates and temperatures are known,')
disp('the program calculates the outlet temperatures,the heat exchanged,')
disp('and estimates the pressure drop on both sides.The method used by this program is KERNS METHOD')
disp(' ')
disp('                                    LIMITATIONS')
disp('This program is suitable only for bare-tube exchangers handling liquids')
disp('on both sides.The thermophysical properties of streams are assumed to be constant with temperature.')
disp('This program is not valid for shell passes more than two. ')
disp(' ')
disp('                                    CAUTION!')
disp('The user Should test this program by analyzing an heat exchanger of known performance') 
disp('and construction.While entering the various inputs user must take care of units and given instructions.')
disp(' ')
disp(' ')
disp(' ')
                           %INPUTS
disp('                                    INPUTS FOR FLUID:')
disp(' ')
mc=input('ENTER THE VALUE OF MASS FLOW RATE USED FOR COLD FLUID(Kg/Hr) :');
disp(' ')
mc=mc/3600;
mh=input('ENTER THE VALUE OF MASS FLOW RATE USED FOR HOT  FLUID(Kg/Hr) :');
disp(' ')
mh=mh/3600;
tci=input('ENTER THE VALUE OF INLET TEMPERATURE FOR COLD FLUID(DEGREE CELCIUS) :');
disp(' ')
thi=input('ENTER THE VALUE OF INLET TEMPERATURE FOR HOT FLUID(DEGREE CELCIUS)  :');
disp(' ')
disp('ENTER THE CODE FOR TYPE OF FLOW :')
disp(' ')
disp('CODE        TYPE OF FLOW')
disp(' ')
disp('1           COUNTER FLOW')
disp(' ')
disp('2           PARALLEL    ')
code4=input('CODE:');
disp(' ')
disp('HOT FLUID IS KEROSENE AND COLD FLUID IS CRUDE OIL AS GIVEN IN THE PROBLEM');

                        %CONSTANTS TO CALCULATE SPECIFIC HEAT

                        %CALCULATING SPECIFIC HEATS AT INLET TEMPERATURE
cpc=2.05*1000;
cph=2.47*1000;

                        %SYNTAX TO INPUT OUTLET TEMPERATURE OF ANY OF THE STREAMS
disp(' ')
disp(' ')
disp('FOR ENTERING OUTLET TEMPERATURES OF HOT OR COLD FLUID ENTER FOLLOWING CODE:')
disp(' ')
disp(' ')
disp('MAKE SURE ONLY CORRECT CODE IS ENTERED AND TEMERATURES ARE ENTERED CORRECTLY ')
disp(' ')
disp('CODE        OUTLET TEMPERATURE')
disp(' ')
disp('1           HOT')
disp(' ')
disp('2           COLD    ')
code2=input('CODE:');
ratio=mc*cpc/mh/cph;
                      %CALCULATING LIMIT OF OUTLET TEMPERATURES
max_t=(thi+ratio*tci)/(1+ratio);
if code2==1
    disp(' ')
    disp('MAKE SURE THAT FINAL TEMPERATURE(DEGREE CELCIUS) OF HOT FLUID IS GREATER THAN:')
    disp(max_t)
    disp(' ')
    thf=input('ENTER THE OUTLET TEMPERATURE OF HOT FLUID(DEGREE CELCIUS) :');
    tcf=mh*cph*(thi-thf)/mc/cpc+tci;
    disp(' ')
    disp('HENCE THE OUTLET TEMPERATURE OF COLD FLUID IS (DEGREE CELCIUS):')
    disp(tcf)
else
    disp(' ')
    disp('MAKE SURE THAT FINAL TEMPERATURE(DEGREE CELCIUS) OF COLD FLUID IS LESS THAN :')
    disp(max_t)
    disp(' ')
    tcf=input('ENTER THE OUTLET TEMPERATURE OF COLD FLUID(DEGREE CELCIUS) :');
    thf=thi-mc*cpc*(tcf-tci)/mh/cph;
    disp(' ')
    disp('HENCE THE OUTLET TEMPERATURE OF HOT FLUID IS(DEGREE CELCIUS) :')
    disp(thf)
end
    
                             %INPUTS FOR TUBE
disp(' ')
disp(' ')
disp(' ')
disp('                                  INPUTS FOR TUBE:')
disp(' ')
pass_tube=input('ENTER THE NUMBER OF TUBE PASSES :');
disp(' ')
tod=input('ENTER THE VALUE OF TUBE OUSIDE DIAMETER(Inches) :');
disp(' ')
tod=tod*0.0254;
bwg=input('ENTER THE VALUE OF B.W.G FOR THE PIPE :');
disp(' ')
if bwg==19
    disp('BWG=19 DOES NOT EXIST ')
    disp('ENTER THE CORRECT VALUE OF BWG')
    disp('PRESS ANY KEY TO EXIT...')
    pause
    exit;
elseif (bwg>20)|(bwg<8)
    disp('ENTER THE CORRECT VALUE OF BWG')
    disp('PRESS ANY KEY TO EXIT...')
    pause
    exit;
else
                         %TABLE OF BWG Vs TUBE THICKNESS
table=[8,9,10,11,12,13,14,15,16,17,18,19,20;.165,.148,.134,.120,.109,.095,.083,.072,.065,.058,.049,0,.035];

disp(' ')
disp('TUBE WALL THICKNESS(in Inches) IS EQUAL TO :')
disp(table(2,bwg-7))
thk=table(2,bwg-7)*0.0254;
disp('PRESS ANY KEY TO CONTINUE...')
pause
end
disp(' ')

disp(' ')               %INPUTTING TYPE OF ARRANGEMENT OF TUBE
disp('ENTER THE CODE FOR TYPE OF ARRANGEMENT OF TUBES:')
disp(' ')
disp('CODE        TYPE OF ARRANGEMENT')
disp(' ')
disp('1           TRIANGULAR')
disp(' ')
disp('2           SQUARE    ')
code=input('CODE:');
disp(' ')
                     %TABLE FOR CALCULATING CONSTANTS FOR DIFFRENT TYPES OF ARRANGEMENTS TO CALCULATE TUBE BUNDLE DIAMETER
if code==1
    table1=[1 2 4 6 8;.319 .249 .175 .0743 .0365;2.142 2.207 2.285 2.499 2.675];
else
    table1=[1 2 4 6 8;.215 .156 .158 .0402 .0331;2.207 2.291 2.263 2.617 2.643];
end
if pass_tube==1
    k=table1(2,1);
    m=table1(3,1);
else
    k=table1(2,pass_tube/2+1);
    m=table1(3,pass_tube/2+1);
    
end
pitch=input('ENTER THE VALUE OF TUBE PITCH(Inches) :');
disp(' ')
pitch=pitch*0.0254;
tube_length=input('AND FINALLY...ENTER THE VALUE OF TUBE LENGTH(mts) : ');
disp(' ')
disp(' ')
disp(' ')
disp(' ')
                                %INPUTS FOR SHELL
disp('                               INPUTS FOR SHELL:')
pass_shell=input('ENTER THE NUMBER OF SHELL PASSES(Either One or Two) :');
disp(' ')


sid=input('ENTER THE VALUE OF SHELL INSIDE DIAMETER(Inches) :');
disp(' ')
sid=sid*0.0254;
disp(' ')
disp('ENTER THE CODE FOR TYPE OF SHELL:')
disp(' ')
disp('CODE        SHELL')
disp(' ')
disp('1           PIPE SHELL(ONLY FOR 6inches <SHELL-DIAMETER< 25inches)')
disp(' ')
disp('2           PLATE SHELL(FOR SHELL-DIAMETER> 6inches)    ')
code1=input('CODE:');
disp(' ')
                               %INPUTS FOR BAFFLE
disp('                                 BAFFLE INPUT :')
baffle_pitch=input('ENTER THE VALUE OF NUMBER OF BAFFLES PER METRE OF TUBE LENGTH :');
disp(' ')

disp(' ')
       %CALCULATING LMTD
    if code4==2
       if thf~=tcf
    lmtd=(thf-tcf-thi+tci)/log((thf-tcf)/(thi-tci));
     
    
else
    lmtd=(thi+tci)/2;
end

    
    r=(thi-thf)/(tcf-tci);
    s=(tcf-tci)/(thi-tci);
    if pass_shell==1
        f_t=sqrt(r^2+1)*log((1-s)/(1-r*s))/(r-1)/log((2-s*(r+1-sqrt(r^2+1)))/(2-s*(r+1+sqrt(r^2+1))));
    else
        f_t=sqrt(r^2+1)*log((1-s)/(1-r*s))/2/(r-1)/log((2/s-1-r+2/s*sqrt((1-s)*(1-r*s))+sqrt(r^2+1))/(2/s-1-r+2/s*sqrt((1-s)*(1-r*s))-sqrt(r^2+1)));
    end    
    
else
    if (thf-tci)~=(thi-tcf)
    lmtd=(thf-tci-thi+tcf)/log((thf-tci)/(thi-tcf));
    r=(thi-thf)/(tcf-tci);
    s=(tcf-tci)/(thi-tci);
    if pass_shell==1
        f_t=sqrt(r^2+1)*log((1-s)/(1-r*s))/(r-1)/log((2-s*(r+1-sqrt(r^2+1)))/(2-s*(r+1+sqrt(r^2+1))));
    else
        f_t=sqrt(r^2+1)*log((1-s)/(1-r*s))/2/(r-1)/log((2/s-1-r+2/s*sqrt((1-s)*(1-r*s))+sqrt(r^2+1))/(2/s-1-r+2/s*sqrt((1-s)*(1-r*s))-sqrt(r^2+1)));
    end    
else
    lmtd=thf-tci;
    f_t=1;
end
end
    
    true_lmtd=f_t*lmtd;         %CALCULATING ACTUAL LMTD
    thc=(thi+thf)/2;
    tcc=(tci+tcf)/2;
                               %CALCULATING DENSITIES
    density_hot=785;
    density_cold=850;
    
                              %TUBE SIDE CALCULATIONS
    qh=mh/density_hot;        %VOLUMETRIC FLOW RATE
    tid=tod-2*thk;
                             
   vh=2;                    %INITIAL GUESS FOR TUBE SIDE VELOCITY
   delta_v=5;
    viscosity_h=3.88*10^-4; 
    k_h=0.14;
    
    viscosity_c=3.598*10^-3;
    k_c=0.13;
   
x=1;
while(delta_v>.001)          %LOOP TO CALCULATE TUBE SIDE VELOCITY
    
x=x+1;
reynold_t=density_hot*vh*tid/viscosity_h;    %CALCULATING REYNOLDS NUMBER
    pr_h=7.24;                                          
                                   
          %CALCULATING NUSSELT NUMBER
    if reynold_t<=2300    
    t_nu=1.86*(reynold_t*pr_h*(tid/tube_length))^(1/3);
else
    t_nu=.027*reynold_t^.8*pr_h^(1/3);
end

t_coeff=t_nu*k_h/tid; %CALCULATING TUBE SIDE HEAT TRANSFER COEFFICIENT
                       %CALCULATING EQUIVALENT DIAMETER DEPENDING ON TUBE ARRANGEMENT
                       
                       %SHELL SIDE CALCULATIONS
if code==2
    d_s_e=1.27/tod*(pitch^2-.785*tod^2);
else
    d_s_e=1.1/tod*(pitch^2-.9*tod^2);
end
if baffle_pitch==1
    a_s=(pitch-tod)*sid*.5/pitch;
else
a_s=(pitch-tod)*sid/((baffle_pitch-1)*2*pitch);
end
g_s=mc/a_s;
v_s=g_s/density_cold;
%viscosity1=6.528*10^-4;
pr_c=55.36;

reynold_s=d_s_e*g_s/viscosity_c;  %CALCULATING REYNOLDS NUMBER

if reynold_s<=2300              %CALCULATING NUSSELT NUMBER FOR SHELL SIDE 
    s_nu=1.86*(reynold_s*pr_c*d_s_e/tube_length*pass_tube)^(1/3);
else
    s_nu=.027*reynold_s^.8*pr_c^(1/3);
end
    s_coeff=s_nu*k_c/d_s_e;
                      %FOULING FACTORS
foul_t=5.283*10^-4;
foul_s=5.283*10^-4;
k_w=74.5;          %THERMAL CONDUCTIVITY
                       %CALCULATING CLEAN COEFFICIENT
overall_clean=(1/s_coeff+tod/tid/t_coeff+tod*log(tod/tid)/2/k_w)^-1;
overall_coeff=(1/s_coeff+tod/tid/t_coeff+tod*pi*tube_length*(foul_t+foul_s)+tod*log(tod/tid)/2/k_w)^-1;
heat=mh*cph*(thi-thf);         %NET HEAT TRANSFERRED
vh_new=4*qh*tod*tube_length*overall_coeff*true_lmtd/tid^2/heat;
delta_v=abs(vh_new-vh);
vh=vh_new;
end                          %while loop ends



shell_length=tube_length/pass_tube;




%CALCULATION FOR PRESSURE DROP
%TUBE SIDE CALCULATIONS    
if reynold_t<850
        j_f=8/reynold_t;
    else
        m1=log10(1.5)/log10(.2);
        c1=.006/(4000^m1);
        j_f=c1*(reynold_t)^m1;
    end
    delta_p=pass_tube*(8*j_f*tube_length/tid+2.5)*density_hot*vh^2/2;
    
%SHELL SIDE CALCULATIONS     
disp(' ')

if  code1==1
    baff_dia=sid-1/16*.0254;
else
    if 6*.0254<sid<25*.0254
        baff_dia=sid-1/8*.0254;
    else
        baff_dia=sid-3/16*.0254;
    end
end
percent=[.15,.25,.35,.45];
for i=1:4
    baffle_cut(i)=percent(i)*baff_dia;
    
    if reynold_s<300
        if i==1
        jh(i)=30.95*reynold_s^-.93;
    elseif i==2
        jh(i)=20.63*reynold_s^-.93;
    elseif i==3
        jh(i)=18.57*reynold_s^-.93;
    else
        jh(i)=14.44*reynold_s^-.93;
    end
    
else
    if i==1
        jh(i)=.446*reynold_s^-.191;
    elseif i==2
        jh(i)=.297*reynold_s^-.191;
    elseif i==3
        jh(i)=.268*reynold_s^-.191;
    else
        jh(i)=.208*reynold_s^-.191;
    end
end

delta_p_s(i)=8*jh(i)*sid/d_s_e*tube_length*2/baffle_pitch*density_cold*v_s^2/2;
end
nt=4*qh/pi/tid^2/vh;
i=0;
while(i<nt)
    i=i+1;
end
nt=i;
shell_length=tube_length/pass_tube;
db=tod*(nt/k)^(1/m);

disp('PRESS ANY KEY TO CONTINUE...')
    pause
    disp(' ')
    disp(' ')
    disp(' ')
    disp(' ')
    disp(' ')
    

%                    DISPLAYING THE INPUTS
    
disp('                                 GIVEN:')
disp('MASS FLOW RATE OF COLD FLUID(Kg/Hr) :')
disp(mc*3600)
disp('MASS FLOW RATE OF HOT FLUID(Kg/Hr) :')
disp(mh*3600)
if code2==1
    disp('OUTLET TEMPERATURE OF HOT FLUID(DEGREE CELCIUS) :')
    disp(thf)
else
    disp('OUTLET TEMPERATURE OF COLD FLUID(DEGREE CELCIUS) :')
    disp(tcf)
end
disp('NUMBER OF TUBE PASSES :')
disp(pass_tube)
disp('TUBE OUTER DIAMETER(INCHES) :')
disp(tod/.0254)
disp('BWG FOR TUBE :')
disp(bwg)
disp('TYPE OF ARRANGEMENT FOR TUBE :')
if code==1
    disp('TRIANGULAR PITCH')
else
    disp('SQUARE PITCH')
end
disp(' ')
disp('PITCH OF TUBE(INCHES) :')
disp(pitch/.0254)
disp('LENGTH OF TUBE(METRES) :')
disp(tube_length)
disp('NUMBER OF SHELL PASSES :')
disp(pass_shell)
disp('INSIDE DIAMETER OF SHELL(INCHES) :')
disp(sid/.0254)
disp('TYPE OF SHELL :')
if code1==1
    disp('PIPE SHELL')
else
    disp('PLATE SHELL')
end
disp(' ')
disp('NUMBER OF BAFFLES PER METRE OF TUBE LENGTH :')
disp(baffle_pitch)
disp(' ')
disp('                                 SCROLL UP TO SEE ALL THE GIVEN INPUTS :') 
disp(' ')
disp('                                 PRESS ANY KEY TO SEE OUTPUTS')
    pause
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(' ')
disp(' ')
%                        DISPLAYING THE OUTPUTS
disp(' ')
disp('                                OUTPUTS :')
disp('MATERIAL OF CONSTRUCTION :90-10CU_NI')
disp(' ')
disp('COLD FLUID FLOWS IN SHELL SIDE AND HOT FLUID FLOWS IN TUBE ')
disp(' ')
if code2==1
    disp('EXIT SHELL SIDE TEMPERATURE(DEGREE CELCIUS) :')
    disp(tcf)
else
    disp('EXIT TUBE SIDE TEMPERATURE(DEGREE CELCIUS) :')
    disp(thf)
end
disp(' ')
disp('HEAT TRANSFERRED FROM HOT FLUID TO COLD FLUID(J/Sec) :')
disp(heat)
disp(' ')    
disp('TUBE SIDE VELOCITY(m/sec) :')
disp(vh)
disp(' ')
disp('SHELL SIDE VELOCITY(m/sec) :')
disp(v_s);
disp(' ')
disp('NO OF TUBES :')
disp(nt)
disp(' ')
disp('THICKNESS OF TUBES(inches) :')
disp(thk/.0254)
disp(' ')
disp('TUBE BUNDLE DIAMETER(inches) : ')
disp(db/.0254)
disp(' ')
disp('LENGTH OF SHELL(mts) :')
disp(shell_length)
disp(' ')
disp('BAFFLE DIAMETER(inches) :')
disp(baff_dia/.0254)
disp(' ')
disp('OVERALL CLEAN U(watt/m^2/K) :')
disp(overall_clean)
disp('OVERALL DIRTY U(watt/m^2/K) :')
disp(overall_coeff)
disp(' ')
disp('                                SCROLL UP TO SEE ABOVE OUTPUTS :') 
disp(' ')
disp('                                PRESS ANY KEY TO SEE PRESSURE DROP')
    pause

    disp(' ')
    disp(' ')
    disp(' ')
    disp(' ')
                                   %DISPLAYING THE VALUE OF PRESSURE DROP
disp('                                   PRESSURE DROP :')


disp('PRESSURE DROP(Psi) IN SHELL FOR BAFFLE CUT PERCENTAGE =')
disp(percent*100)
disp(' ')
disp(delta_p_s*0.0001450377)
disp(',RESPECTIVELY')
disp(' ')
disp('PRESSURE DROP(Psi) IN TUBE :')
disp(delta_p*0.0001450377)

disp('                                PRESS ANY KEY TO CONTINUE...')
    pause
    disp(' ')
disp(' ')
disp(' ')
disp(' ') 
disp(' ')                                %DISPLAYING THE FINAL ANALYSIS
disp('                                       ANALYSIS :')
disp(' ')
if delta_p*0.0001450377>15
    disp('TUBE SIDE PRESSURE DROP EXCEEDS THE ALLOWABLE LIMIT i.e 15Psi')
else
    disp('TUBE SIDE PRESSURE IS ACCORDING TO THE ALLOWABLE LIMIT i.e 15Psi')
end
disp(' ')
if max(delta_p_s)*0.0001450377>15
    disp('SHELL SIDE PRESSURE DROP EXCEEDS THE ALLOWABLE LIMIT i.e 15Psi')
else
    disp('SHELL SIDE PRESSURE IS ACCORDING TO THE ALLOWABLE LIMIT i.e 15Psi')
end















