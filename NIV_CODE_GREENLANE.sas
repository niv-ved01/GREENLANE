 proc iml;
start main;
    /* Set seed */
    call streaminit(123456789);
    lambda = 0.44;
    /* CURRENT SITUATION */
    mu = 0.42;
    T = 60*60;
    current = j(T+1, 4, 0);
    do i = 1 to T+1;
        arrivals = rand("Poisson", lambda);
        departures = rand("Poisson", mu);
        /* Time */
        current[i, 1] = i-1;
        /* Arrivals and Departures */
        current[i, 2] = arrivals;
        current[i, 3] = departures;
        /* Queue Size */
        if i = 1 then 
            current[1, 4] = max(current[i, 2] - current[i, 3], 0);
        else 
            current[i, 4] = max(current[i-1, 4] + (current[i, 2] - current[i, 3]), 0);
        if current[i, 4] = 0 then 
            current[i, 3] = 0; 
    end;

    /* SOLUTION */
    mu1 = 0.59;
    T = 60*60;
    CASE1 = j(T+1, 4, 0);
    do i = 1 to T+1;
        arrivals = rand("Poisson", lambda);
        departures = rand("Poisson", mu1);
        /* Time */
        CASE1[i, 1] = i-1;
        /* Arrivals and Departures */
        CASE1[i, 2] = arrivals;
        CASE1[i, 3] = departures;
        /* Queue Size */
        if i = 1 then 
            CASE1[1, 4] = max(CASE1[i, 2] - CASE1[i, 3], 0);
        else 
            CASE1[i, 4] = max(CASE1[i-1, 4] + (CASE1[i, 2] - CASE1[i, 3]), 0);
        if CASE1[i, 4] = 0 then 
            CASE1[i, 3] = 0; 
    end;

    vars  = {"Time", "Arrivals", "Departures", "Queue_Size"};
    vars1 = {"Time", "Arrivals1", "Departures1", "Queue_Size1"};
    
    create work.current from current[colname=vars];
        append from current;
    close work.current;
    
    create work.CASE1 from CASE1[colname=vars1];
        append from CASE1;
    close work.CASE1;

finish main;
RUN;

DATA work.compare;
    merge work.current work.CASE1;
RUN;

title1 "Comparison of Current and Proposed Ramp";
PROC SGPLOT data=work.compare;
    series x=Time y=Queue_Size / name="current"; 
    series x=Time y=Queue_Size1 / name="CASE1";
    xaxis label="Time (Minutes)" values=(0 to 3600 by 300);
    yaxis label="Number of Vehicles" values=(0 to 90 by 5);
    keylegend "current" "CASE1" / location=inside position=top;
RUN;

title1 "Histogram of Queue Size Currently";
PROC UNIVARIATE data=work.current;
    histogram Queue_Size / midpoints=0 to 90 by 5 normal kernel;
RUN;

title1 "Histogram of Queue Size for Proposed Solution";
PROC UNIVARIATE data=work.CASE1;
    histogram Queue_Size1 / midpoints=0 to 12 by 1 normal exponential;
RUN;
