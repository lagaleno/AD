dtmc
// questão 2.16
module lunch
	// estados
	// 0: burrito; 1: falafel; 2: pizza; 3: sushi
	s: [0..3] init 0;
	// weekday
	// 0: sunday; 1: monday...6: saturday
	w: [0..6] init 0;
	
	[]s=0 -> 0.5 : (s'=1) + 0.5 : (s'=2) & (w'=0); 
	[]s=0 -> 0.5 : (s'=1) + 0.5 : (s'=2);
	[]s=1 -> 0.5 : (s'=0) + 0.5 : (s'=2);
	[]s=2 -> 0.4 : (s'=0) + 0.6 : (s'=3);
	[]s=3 -> 0.2 : (s'=1) + 0.6 : (s'=2) + 0.2 : (s'=3);
	
endmodule