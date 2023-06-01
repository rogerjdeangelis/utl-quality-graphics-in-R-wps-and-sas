%let pgm=utl-quality-graphics-in-R-wps-and-sas;

github
https://tinyurl.com/3fek8pef
https://github.com/rogerjdeangelis/utl-quality-graphics-in-R-wps-and-sas

 quality graphics in R wps and sas

   Solutions

      1. WPS Proc R
      2. WPS Proc sgplot (ods graphics)
      3. WPS Proc gplot  (legacy sas graph wps does not support pointlabel at present)
      4. WPS SAS graphs  (legacy sas graph)

  All support jpg png wmf pdf tiff svg emf?
  Have not verified all of these.

  SOAPBOX ON
   Perhaps we should add R graphics to our tool chest?
  SOAPBOX OFF

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

data have;
informat city $12.;
input city month temperature @@;
if city ne "Miami";
output;
if city eq "Phoenix" then do;
    temperature = temperature + 20;
    city = "Miami";
    output;
end;
cards4;
Detroit 1 24 Detroit 2 29 Detroit 3 42 Detroit 4 58 Detroit 5 70 Detroit 6 79
Detroit 7 83 Detroit 8 80 Detroit 9 71 Detroit 10 58 Detroit 11 42
Detroit 12 28 Miami 1 76 Miami 2 77 Miami 3 79 Miami 4 82 Miami 5 85
Miami 6 88 Miami 7 89 Miami 8 89 Miami 9 88 Miami 10 85 Miami 11 80
Miami 12 77 Phoenix 1 67 Phoenix 2 71 Phoenix 3 78 Phoenix 4 86 Phoenix 5 95
Phoenix 6 104 Phoenix 7 106 Phoenix 8 104 Phoenix 9 99
Phoenix 10 88 Phoenix 11 75 Phoenix 12 66
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Up to 40 obs from last table WORK.HAVSRT total obs=36 01JUN2023:09:37:33                                              */
/*                                                                                                                        */
/*   CITY      MONTH    TEMPERATURE    CITY      MONTH    TEMPERATURE   CITY      MONTH    TEMPERATURE                    */
/*                                                                                                                        */
/*  Detroit       1          24        Miami         1          87     Phoenix       1          67                        */
/*  Detroit       2          29        Miami         2          91     Phoenix       2          71                        */
/*  Detroit       3          42        Miami         3          98     Phoenix       3          78                        */
/*  Detroit       4          58        Miami         4         106     Phoenix       4          86                        */
/*  Detroit       5          70        Miami         5         115     Phoenix       5          95                        */
/*  Detroit       6          79        Miami         6         124     Phoenix       6         104                        */
/*  Detroit       7          83        Miami         7         126     Phoenix       7         106                        */
/*  Detroit       8          80        Miami         8         124     Phoenix       8         104                        */
/*  Detroit       9          71        Miami         9         119     Phoenix       9          99                        */
/*  Detroit      10          58        Miami        10         108     Phoenix      10          88                        */
/*  Detroit      11          42        Miami        11          95     Phoenix      11          75                        */
/*  Detroit      12          28        Miami        12          86     Phoenix      12          66                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  x 'tree "d:/png" /F /A | clip';                                                                                       */
/*                                                                                                                        */
/*  D:\PNG                                                                                                                */
/*  |   r_city_temperature.png            R png                                                                           */
/*  |   sas_sgplot_city_temperature.png   SAS SGPLOT                                                                      */
/*  |   wps_gplot_city_temperature.png    WPS GPLOT                                                                       */
/*  \   wps_sqplot_city_temperature.png   WPS SGPLOT                                                                      */
/*                                                                                                                        */
/*                                                                                                                        */
/*                                                                                                                        */
/*                                Average Monthly Temperature                                                             */
/*                                                                                                                        */
/*  TEMPERATURE |                                                                                                         */
/*              |       Pheonix          - P 126                                                                          */
/*              |                      P 124   P 124                                                                      */
/*          120 +                    /             P 119                                                                  */
/*              |                  P 115             \                                                                    */
/*              |                /                    \                                                                   */
/*              |              P 106     . M 106       P 108                                                              */
/*              |            /         M 104   M 104    \                                                                 */
/*          100 +          P 98      /             M 99  \                                                                */
/*              |        /         M 95   Miami     \      P 95                                                           */
/*              |    . P 91      /                   \                                                                    */
/*              |  P 87        M 86       D 83         M 88 86 P                                                          */
/*              |            /          /    \          \                                                                 */
/*           80 +          M 78      . D 79   D 80       \                                                                */
/*              |        /          /          \           M 75                                                           */
/*              |     / D 71       D 70 Detriot .D 71                                                                     */
/*              |  M 67          /                \         66 M                                                          */
/*              |               /                  .                                                                      */
/*           60 +              D 58                  \ D 58                                                               */
/*              |             /                        \                                                                  */
/*              |            /                           \                                                                */
/*              |           /                             \                                                               */
/*              |          D 42                            . D 42                                                         */
/*           40 +         /                                \                                                              */
/*              |        /                                  \                                                             */
/*              |       /                                    \                                                            */
/*              |    . D 29                                28 D                                                           */
/*              |  D 24       D=Detroit M=Miami P-Pheonix                                                                 */
/*           20 +                                                                                                         */
/*              |                                                                                                         */
/*              ---+---+---+---+---+---+---+---+---+---+---+---+--                                                        */
/*                 1   2   3   4   5   6   7   8   9  10  11  12                                                          */
/*                                                                                                                        */
/*                                     MONTH                                                                              */
/*                                                                                                                        */
/**************************************************************************************************************************/
                                   MONTH

/*
/ |   __      ___ __  ___   _ __  _ __ ___   ___   _ __
| |   \ \ /\ / / `_ \/ __| | `_ \| `__/ _ \ / __| | `__|
| |_   \ V  V /| |_) \__ \ | |_) | | | (_) | (__  | |
|_(_)   \_/\_/ | .__/|___/ | .__/|_|  \___/ \___| |_|
               |_|         |_|
*/

%utlfkil(d:/png/r_city_temperature.png);

%utl_submit_wps64('
libname wrk "&_pth";
proc r;
export data=wrk.have r=have;
submit;
library(ggplot2);
rplot <- ggplot(have,aes(x=MONTH,y=TEMPERATURE,group=CITY,color=CITY,label=CITY)) +
geom_point() +
geom_text(aes(label = TEMPERATURE), nudge_y=3.0) +
geom_line(size=1) +
geom_point(shape=1,size=2) +
scale_x_continuous(labels = paste(seq(1, 12, by = 1)), breaks=seq(1,12,by=1), limits = c(1, 12)) +
ggtitle(sprintf("                                R Average Monthly Temperature")) +
theme(legend.position="bottom");
ggsave(filename="d:/png/r_city_temperature.png",device="png",type="cairo",
   plot=rplot,dpi=100,height=5,width=7,units="in");
endsubmit;
run;quit;
');

/*___                                           _       _
|___ \    __      ___ __  ___   ___  __ _ _ __ | | ___ | |_
  __) |   \ \ /\ / / `_ \/ __| / __|/ _` | `_ \| |/ _ \| __|
 / __/ _   \ V  V /| |_) \__ \ \__ \ (_| | |_) | | (_) | |_
|_____(_)   \_/\_/ | .__/|___/ |___/\__, | .__/|_|\___/ \__|
                   |_|              |___/|_|
*/

%let _pth=%sysfunc(pathname(work));

%utlfkil(d:/png/wps_sgplot_city_temperature.png);

%utl_submit_wps64('
libname wrk "&_pth";
filename gsfout "d:/png/wps_sqplot_city_temperature.png";
goptions reset=all gsfmode = replace gsfname = gsfout  device=png;
proc sgplot data=wrk.have;
title1 height=13pt c=gray33 "WPS sgplot Average Monthly Temperatures";
series x=MONTH y=TEMPERATURE / group=CITY
   markers markerattrs=(symbol=circlefilled) datalabel datalabelattrs=(size=12)
   lineattrs=(thickness=.5);
   yaxis values=(20 to 140 by 20);
   xaxis values=(1 to 12 by 1);
   keylegend / across=3;
run;quit;
filename gsfout clear;
');

/*____                                     _       _
|___ /   __      ___ __  ___    __ _ _ __ | | ___ | |_
  |_ \   \ \ /\ / / `_ \/ __|  / _` | `_ \| |/ _ \| __|
 ___) |   \ V  V /| |_) \__ \ | (_| | |_) | | (_) | |_
|____(_)   \_/\_/ | .__/|___/  \__, | .__/|_|\___/ \__|
                  |_|          |___/|_|
*/

%utlfkil(d:/png/wps_gplot_city_temperature.png);

%utl_submit_wps64('
libname wrk "&_pth";
filename gsfout "d:/png/wps_gplot_city_temperature.png";
goptions reset=all gsfmode = replace gsfname = gsfout  device=png;
title1 "WPS gplot Average Monthly Temperature";
symbol1 interpol=spline width=2 value=triangle c=steelblue  ;
symbol2 interpol=spline width=2 value=circle c=indigo       ;
symbol3 interpol=spline width=2 value=square c=orchid       ;
axis1
      order = 1 to 12 by 1;
proc gplot data=wrk.have;
plot temperature*month=city /
        haxis=axis1 hminor=0
        vaxis=axis2 vminor=1
        legend=legend1;
run;
quit;
filename gsfout clear;
');

/*  _                                      _       _
| || |     ___  __ _ ___   ___  __ _ _ __ | | ___ | |_
| || |_   / __|/ _` / __| / __|/ _` | `_ \| |/ _ \| __|
|__   _|  \__ \ (_| \__ \ \__ \ (_| | |_) | | (_) | |_
   |_|(_) |___/\__,_|___/ |___/\__, | .__/|_|\___/ \__|
                               |___/|_|
*/


%let _pth=%sysfunc(pathname(work));

%utlfkil(d:/png/sas_sgplot_city_temperature.png);

libname wrk "&_pth";
ods graphics on / reset=index imagefmt=png antialias height=5in width=5in imagename="sas_sgplot_city_temperature";
ods listing  gpath="d:/png";
proc sgplot data=wrk.have noautolegend;
ods escapechar="^";
title1 height=13pt c=gray33 "SAS sgplot Average Monthly Temperatures";
series x=MONTH y=TEMPERATURE / group=CITY
   markers markerattrs=(symbol=circlefilled) datalabel datalabelattrs=(size=9)
   lineattrs=(thickness=.5);
   yaxis values=(20 to 140 by 20);
   xaxis values=(1 to 12 by 1);
run;quit;
ods graphics off;


/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
