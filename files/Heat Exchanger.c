#include<stdio.h>
#include<math.h>

int main()
{
    printf("HEAT EXCHANGER :\n");
    printf("\n\tThis program analyses the performance of a shell and tube heat exchanger for a given exchanger,for which construction details are known,and for which the inlet flow rates and temperatures are known,the program calculates the outlet temperatures,the heat exchanged,and estimates the pressure drop on both sides.");
    printf("The method used by this program is KERNS METHOD\n\n");
    printf("\nLIMITATIONS :\n");
    printf("\n\tThis program is suitable only for bare-tube exchangers handling liquids on both sides.The thermophysical properties of streams are assumed to be constant with temperature. ");
    printf("This program is not valid for shell passes more than two.\n\n");
    printf("\nCAUTION :\n");
    printf("\n\tThe user Should test this program by analyzing an heat exchanger of known performance and construction.While entering the various inputs user must take care of units and given instructions.");
    printf("\n\n\n\n");

    float thi,thf,tci,tcf,mh,mc,mid,q,LMTD,cal1,cal2,ar;
    float cpc=2.05*1000;
    float cph=2.47*1000;
    float kh=0.14;
    float kc=0.13;
    float muh=1.4/3600;
    float muc=12.95/3600;
    float roh=0.75*100;
    float roc=0.85*1000;
    float ph=7.24;
    float pc=55.36;

/* GIVEN VALUES */

    //printf("\nMass Flow Rate of Kerosene (Kg/Hr) : 24000 ");
    //scanf("%f",&mh);
    mh=24000;
    mh=mh/3600;
    //printf("\n\nMass Flow Rate used of Crude (Kg/Hr) : 68000");
    //scanf("%f",&mc);
    mc=68000;
    mc=mc/3600;

    //printf("\n\nThe Initial Temperature of Kerosene (DEGREE CELSIUS)  : 199 ");
    //scanf("%f",&thi);
    //printf("\n\nThe Final Temperature of Kerosene (DEGREE CELSIUS)  : 121 ");
    //scanf("%f",&thf);
    //printf("\n\nThe Initial Temperature of Crude Oil (DEGREE CELSIUS)  : 38 ");
    //scanf("%f",&tci);
    printf("\n\n\n*********  INPUTS  **********\n\n\n");
    printf("\n\nMass Flow Rate of Kerosene (Kg/Hr) : 24000 Kg/Hr\n");
    printf("\n\nMass Flow Rate of Crude Oil (Kg/Hr) : 68000 Kg/Hr\n");
    printf("\n\nThe Initial Temperature of Kerosene (DEGREE CELSIUS)  : 199 Degree Celsius\n ");
    printf("\n\nThe Final Temperature of Kerosene (DEGREE CELSIUS)  : 121 Degree Celsius\n");
    printf("\n\nThe Initial Temperature of Crude Oil (DEGREE CELSIUS)  : 38 Degree Celsius\n");

/*  FINDING THE FINAL TEMPERATURE OF COLD FLUID */

    tcf=(((mh*cph*(thi-thf)))/(mc*cpc))+tci;

    //printf("\n\nThe Final Temperature of Crude Oil : %f <Degree Celsius>",tcf);

/* HEAT DUTY */

    q=mh*cph*(thi-thf);
    //printf("\n\n\nThe Heat Duty : %f kJ/Kg",q);


/* TRY FOR 1-1 PASS COUNTERCURRENT EXCHANGER */

    cal1=thi-tcf;
    cal2=thf-tci;
    LMTD=(cal1-cal2)/log(cal1/cal2);

    //printf("\n\n\nLMTD : %f ",LMTD);

    printf("\n\n\nUdo Initial Guess = 232\n\nTaking as Initial Guess for Kerosene and Crude Oil form a given range of value\n");
    int udo=232;

    ar=q/(udo*LMTD);
    //printf("\n\n\nArea Required = %f <m^2>",ar);
    printf("\n\n\nSelecting BWG for 13 Tube\n\n");

    float OD_tube=0.0254,ID_tube=0.0206,t_tube=0.002,len_tube,aot,fat,cal,vel_tube;
    int no_tubes;
    len_tube=12*(0.3048);
    aot=3.1415*OD_tube*len_tube;
    no_tubes=ar/aot;
    //printf("\n\nNo of Tubes = %d",no_tubes);
    cal=3.1415*ID_tube*ID_tube*no_tubes;
    fat=cal/4;
    //printf("\n\n\nFlow Area Tube : %f",fat);
    vel_tube=mc/(roc*fat);
    //printf("\n\n\n%f",vel_tube);
    int n=1/(vel_tube);
    //printf("\n\n\nNo of Tube Passes : %d",n);

/* TRIAL FOR 1-4 PASS */

    /*Selecting no of tubes as 214 , for 5/4 square pitch (from table 8.3) */

    float shell_id=0.635;
    //printf("\n\n\n Shell Inside Diameter : %f",shell_id);
    float no_tube=188;
    //printf("\n\n\nNo of Tubes : %f",no_tube);
    float tube_per_pass=no_tube/4;
    float tube_pass=4;
    float shell_pass=1;
    float tube_pitch=0.03;
    //printf("\n\n\nTube Pitch : %f m",tube_pitch);

/* BAFFLE SPACING */

    float a=shell_id/5;
    float c=0.05;
    float b;
    if(a>c)
    {
        b=a;
        //printf("\n\n\nBaffle Spacing : %f",b);
    }
    else
    {
        b=c;
        //printf("\n\n\nBaffle Spacing : %f",b);
    }
    shell_id=0.59055;
/* ESTIMATION OF HEAT TRANSFER COEFFICIENTS */

    float tube_side_flow_per_pass=(3.1415*0.0206*0.0206*53)/4;
    float tube_side_linear_velocity=mc/(roc*tube_side_flow_per_pass);
    float tube_side_reynolds=0.0254*tube_side_linear_velocity*roc/muc;

    /* jh= Corresponding Colburr Factor from Graph */
    float jh=15;
    float hi=(jh*pow(((muc*cpc)/kc),1/3)*pow((muc/0.00075),0.44)*kc)/0.0206;
    float d=tube_pitch-b;

/* SHELL SIDE CALCULATION */

    float shell_side_flow_area=c*b*0.635/tube_pitch;
    float shell_side_fluid_velocity=mh/(roh*shell_side_flow_area);

/* HYDRAULIC DIAMETER */

    float dh=(4*(tube_pitch*tube_pitch)-(3.1415*0.0254*0.0254))/(3.1415*0.0254);
    float shell_side_reynolds_no=roh*dh*shell_side_fluid_velocity/muh;

    /* Corresponding Colburr Factor for Shell Side */

    float jh2=71;
    float ho=jh2*kh*pow(cph*muh/kh,1/3)*pow(muh/0.00075,0.44)/dh;

/* CALCULATION OF OVER ALL HEAT TRANSFER COEFFICIENT (Udo) - OVERALL HEAT TRANSFER COEFFICIENT BASED ON THE OUTSIDE TUBE AREA */

    float rdo=0.000409;
    float rdi=0.000615;
    float am=0.354;
    float ao=0.389;
    float y=1.23;       /* y = ao/ai */
    float x=0.000107;   /* x=(ro-ri)/kw  */
    float Udo=(1/((1/ho)+(rdo)+(ao*x/am)+(y*rdi)+(y/hi)));



/* CALCULATON OF Ft AND AREA REQUIRED */


    float tc=(tcf-tci)/(thi-tci);
    float R=(thi-thf)/(tcf-tci);
    float Ft=0.9;
    float Fps=0.3216;
    float FPT=1.6844;
    float arr=q/(Udo*Ft*LMTD);
    float area=3.1415*OD_tube*len_tube*no_tube;
    float percent_excess_area=(area-arr)/arr;



/* PRESSURE DROP CALCULATION */


    float f=0.0052;
    float g=9.8;
    float Pt=f*tube_side_linear_velocity*tube_side_linear_velocity*len_tube*tube_pass/(2*g*roc*0.0206*pow(muh/0.00075,0.14));
    float Pr=4*tube_pass*roh*tube_side_linear_velocity*tube_side_linear_velocity/(2*g);
    float PT=Pr+Pt;




/* SHELL SIDE PRESSURE DROP CALCULATION */


    float fs=0.042;
    float ps=fs*shell_side_fluid_velocity*shell_side_fluid_velocity*0.635*(len_tube/0.127)/(2*g*roc*dh*pow(muc/0.00075,0.14));



/* OUTPUTS */


    printf("\n\n\n\n********  OUTPUTS  ********\n\n\n");


    printf("\n\nhell Inner Diameter = %f meters\n",shell_id);
    printf("\n\nNo Of Tubes : %f \n",no_tube);
    printf("\n\nTube Inner Diameter : %f meters\n",ID_tube);
    printf("\n\nTube Outer Diameter : %f meters\n",OD_tube);
    printf("\n\nTube Length : %f meters\n",len_tube);
    printf("\n\nTube Pitch : %f m^2\n",tube_pitch);
    printf("\n\nTube Pass : %f passes\n",tube_pass);
    printf("\n\nShell Pass : %f pass\n",shell_pass);
    printf("\n\nShell Side Press Drap : %f Kg/cm^2\n",Fps);
    printf("\n\nTube Side Press Drap : %f Kg/cm^2\n",FPT);

    printf("\n\n");


    return 0;
}

