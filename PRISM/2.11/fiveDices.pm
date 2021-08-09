dtmc

module fiveDices
	// estados que representam a quantidade de dados que tiraram 6
	s: [0..5] init 0;
	// n�mero de jogadas
	n: [0..3] init 0;
	
	// matriz de transi��o aproximada para 3 casas decimais
	[] s=0 & (n<3) -> 0.402 : (s'=0) & (n'=n+1) + 0.402 : (s'=1) & (n'=n+1) + 0.161 : (s'=2) & (n'=n+1) + 0.032 : (s'=3) & (n'=n+1) + 0.003 : (s'=4) & (n'=n+1) + 0 : (s'=5) & (n'=n+1);
	[] s=1 & (n<3) -> 0.482 : (s'=1) & (n'=n+1) + 0.386 : (s'=2) & (n'=n+1) + 0.116 : (s'=3) & (n'=n+1) + 0.015 : (s'=4) & (n'=n+1) + 0.001 : (s'=5) & (n'=n+1);
	[] s=2 & (n<3) -> 0.579 : (s'=2) & (n'=n+1) + 0.347 : (s'=3) & (n'=n+1) + 0.069 : (s'=4) & (n'=n+1) +  0.005 : (s'=5) & (n'=n+1);
	[] s=3 & (n<3) -> 0.694 : (s'=3) & (n'=n+1) + 0.278 : (s'=4) & (n'=n+1) + 0.028 : (s'=5) & (n'=n+1);
	[] s=4 & (n<3) -> 0.833 : (s'=4) & (n'=n+1) + 0.167 : (s'=5) & (n'=n+1);
	[] s=5 & (n<3) -> (s'=5);
	
	[] n=3 -> (n'=3);
endmodule