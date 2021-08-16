dtmc 
// quest�o 3.66

module random_walk
	//local state
	s: [0..5] init 0;
	
	// matriz de transi��o
	[a] s=0 -> 1/4 : (s'=1) + 1/4 : (s'=2) + 1/4 : (s'=3) + 1/4 : (s'=4);
	[b] s=1 -> 1/2 : (s'=0) + 1/2 : (s'=3); 
	[f] s=2 -> 1/2 : (s'=0) + 1/2 : (s'=4);
	[c] s=3 -> 1/4 : (s'=0) + 1/4 : (s'=1) + 1/4 : (s'=4) + 1/4 : (s'=5);
	[e] s=4 -> 1/4 : (s'=0) + 1/4 : (s'=2) + 1/4 : (s'=3) + 1/4 : (s'=5);
	[d] s=5 -> (s'=5);

endmodule

rewards "visits"

	true : 1;
endrewards