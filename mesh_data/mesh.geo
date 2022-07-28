//Subdomain 1
h1 = 0.1;
Point(1) = {0,0,0,h1};
Point(2) = {5.82,0,0,h1};
Point(3) = {5.82,1.0,0,h1};
Point(4) = {3.59,1.0,0,h1};
Point(5) = {0,1.0,0,h1};

//Subdomain 1
Line(1) = {1,2};
Line(2) = {2,3};
Line(3) = {3,4};
Line(4) = {4,5};
Line(5) = {5,1};
Line Loop(1) = {1,2,3,4,5};
Physical Line(1) = {1};//\gamma_-
Physical Line(2) = {5};//\gamma_s

//Subdomain 1
Plane Surface(1) = {1};
Physical Surface(1) = {1};

//Subdomain 2
h2 = 0.1;
//Point(4) = {3.59,1.0,0,h1};
Point(6) = {3.59,1.6,0,h2};
Point(7) = {0.39,1.6,0,h2};
Point(8) = {0,1.6,0,h2};
//Point(5) = {0,1.0,0,h1};

//Subdomain 2
Line(6) = {4,6};
Line(7) = {6,7};
Line(8) = {7,8};
Line(9) = {8,5};
//Line(-4)
Line Loop(2) = {6,7,8,9,-4};
Physical Line(3) = {9};//\gamma_s

//Subdomain 2
Plane Surface(2) = {2};
Physical Surface(2) = {2};

//Subdomain 3
h3 = 0.1;
//Point(6) = {3.59,1.6,0,h2};
Point(9) = {4.6,1.6,0,h3};
Point(10) = {5.0,1.6,0,h3};
Point(11) = {5.0,5.2,0,h3};
Point(12) = {5.82,5.2,0,h3};
//Point(3) = {5.82,1.0,0,h1};
//Point(4) = {3.59,1.0,0,h1};

//Subdomain 3
Line(10) = {6,9};
Line(11) = {9,10};
Line(12) = {10,11};
Line(13) = {11,12};
Line(14) = {12,3};
//Line(3)
//Line(6)
Line Loop(3) = {10,11,12,13,14,3,6};

//Subdomain 3
Plane Surface(3) = {3};
Physical Surface(3) = {3};

//Subdomain 4
h4 = 0.1;
//Point(11) = {5.0,5.2,0,h2};
Point(13) = {5.0,6.4,0,h4};
Point(14) = {5.15,6.4,0,h4};
Point(15) = {5.15,7.35,0,h4};
Point(16) = {5.82,7.35,0,h4};
//Point(12) = {5.82,5.2,0,h3};

//Subdomain 4
Line(15) = {11,13};
Line(16) = {13,14};
Line(17) = {14,15};
Line(18) = {15,16};//\gamma_+
Line(19) = {16,12};
//Line(-13)
Line Loop(4) = {15,16,17,18,19,-13};
Physical Line(4) = {18};

//Subdomain 4
Plane Surface(4) = {4};
Physical Surface(4) = {4};

//Subdomain 5
h5 = 0.1;
//Point(7) = {0.39,1.6,0,h2};
Point(17) = {0.39,2.1,0,h5};
Point(18) = {0,2.1,0,h5};
//Point(8) = {0,1.6,0,h2};

//Subdomain 5
Line(20) = {7,17};
Line(21) = {17,18};//\gamma_sf
Line(22) = {18,8};///\gamma_s
//Line(-8)
Line Loop(5) = {20,21,22,-8};
Physical Line(5) = {21};
Physical Line(6) = {22};

//Subdomain 5
Plane Surface(5) = {5};
Physical Surface(5) = {5};

//Subdomain 6
h6 = 0.1;
//Point(17) = {0.39,2.1,0,h5};
Point(19) = {4.6,2.1,0,h6};
Point(20) = {4.6,6.6,0,h6};
Point(21) = {4.95,6.6,0,h6};
Point(22) = {4.95,7.4,0,h6};
Point(23) = {5.15,7.4,0,h6};
//Point(15) = {5.15,7.35,0,h4};
//Point(14) = {5.15,6.4,0,h4};
//Point(13) = {5.0,6.4,0,h4};
//Point(11) = {5.0,5.2,0,h2};
//Point(10) = {5.0,1.6,0,h3};
//Point(9) = {4.6,1.6,0,h3};
//Point(6) = {3.59,1.6,0,h2};
//Point(7) = {0.39,1.6,0,h2};

//Subdomain 6
Line(23) = {17,19};
Line(24) = {19,20};
Line(25) = {20,21};
Line(26) = {21,22};
Line(27) = {22,23};
Line(28) = {23,15};
//Line(-17)
//Line(-16)
//Line(-15)
//Line(-12)
//Line(-11)
//Line(-10)
//Line(7)
//Line(20)
Physical Line(7) = {23};//\gamma_{sf}
Physical Line(8) = {24};//\gamma_{sf}
Physical Line(9) = {25};//\gamma_{sf}
Physical Line(10) = {26};//\gamma_{sf}
Physical Line(11) = {27};//\gamma_{+}
Physical Line(12) = {28};//\gamma_{+}
Line Loop(6) = {23,24,25,26,27,28,-17,-16,-15,-12,-11,-10,7,20};

//Subdomain 6
Plane Surface(6) = {6};
Physical Surface(6) = {6};

//Subdomain 7
h7 = 0.02;
//Point(16) = {5.82,7.35,0,h4};
Point(24) = {5.82,7.4,0,h7};
Point(25) = {6.02,7.4,0,h7};
Point(26) = {6.02,0,0,h7};
//Point(2) = {5.82,0,0,h1};
//Point(3) = {5.82,1.0,0,h1};
//Point(12) = {5.82,5.2,0,h3};

//Subdomain 7
Line(29) = {16,24};//\gamma_+
Line(30) = {24,25};//\gamma_+
Line(31) = {25,26};//\gamma_out
Line(32) = {26,2};
//Line(2)
//Line(-14)
//Line(-19)
Physical Line(13) = {29};
Physical Line(14) = {30};
Physical Line(15) = {31};
Line Loop(7) = {29,30,31,32,2,-14,-19};

//Subdomain 7
Plane Surface(7) = {7};
Physical Surface(7) = {7};

/*
Carbon block 1 = 1
Carbon block 2 = 2
BB surround = 3
Carbon block 2 upper = 4
Center block = 5
Ceramic cup = 6
Steel shell = 7

\gamma_s = 2,3,6
\gamma_- = 1
\gamma_+ = 4,11,12,13,14
\gamma_sf = 5,7,8,9,10
\gamma_out = 15
*/
