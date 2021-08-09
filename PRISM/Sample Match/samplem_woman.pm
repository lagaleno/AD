dtmc // modelo deterministico de Cadeia de Markov

//------------------------------------------------------
// Lista de Preferência
// homen (m) i prefere mulher (w) j acima de mulher k se mij>mik
// mulher (w) i prefere homem (h) j acima de homem k se wij>wik

// lista de preferência das mulheres

// w1 : m3,m2,m1
const int w11=3;
const int w12=2;
const int w13=1;

// w2 : m3,m2,m1
const int w22=3;
const int w23=2;
const int w21=1;

// w3: m3, m2, m1
const int w33=3;
const int w31=2;
const int w32=1;

// lista de preferência dos homens

// m1 : w3,w2,w1
const int m12=3;
const int m13=2;
const int m11=1;

// w2 : m3,m1,m2
const int m23=3;
const int m21=2;
const int m22=1;

// w3 : m1,m2,m3
const int m31=3;
const int m32=2;
const int m33=1;

//------------------------------------------------------
// Constantes usadas no momento em que as preferências das mulheres serão levadas em consideração
const int N1=1;
const int N2=2;
const int N3=3;

//------------------------------------------------------
// modelo usando o primeiro homem como exemplo
module woman1

	// diz o atual casal da mulher 1, se está com 0 significa que está solteira
	w1 : [0..3];

	// mudar o casamento do homem 1
	[e11] w1=0 | (w1=1 & w11>w11)|(w1=2 & w11>w12)|(w1=3 & w11>w13) -> (w1'=1); // [e11] evento da mulher 1 casar com o homem 1
	[e12] w1=0 | (w1=1 & w12>w11)|(w1=2 & w12>w12)|(w1=3 & w12>w13) -> (w1'=2); // [e12] evento da mulher 1 casar com o homem 2
	[e13] w1=0 | (w1=1 & w13>w11)|(w1=2 & w13>w12)|(w1=3 & w13>w13) -> (w1'=3); // [e13] evento da mulher 1 casar com o homem 3
	
	// se ocorrer mudança no casamento da mulher1, checar os outros casamentos
	[e21] true -> (w1'=(w1=1)?0:w1); // condicional no PRISM: se (w1=1) for verdade w1' assume valor 0 se não segue no valor w1
	[e31] true -> (w1'=(w1=1)?0:w1);
	[e22] true -> (w1'=(w1=2)?0:w1);
	[e32] true -> (w1'=(w1=2)?0:w1);
	[e23] true -> (w1'=(w1=3)?0:w1);
	[e33] true -> (w1'=(w1=3)?0:w1);
	
endmodule

// a partir do módulo man1 crio man2 e man3, porém substituindo as variáveis para ficarem compatíveis
module woman2 = woman1[w1=w2, w11=w21, e11=e21, e12=e22, e13=e23, w12=w22, e21=e31, e22=e32, e23=e33, w13=w23, e31=e11, e32=e12, e33=e13 ] endmodule
module woman3 = woman1[w1=w3, w11=w31, e11=e31, e12=e32, e13=e33, w12=w32, e21=e11, e22=e12, e23=e13, w13=w33, e31=e21, e32=e22, e33=e23 ] endmodule

//------------------------------------------------------
// usando a primeira mulher como exemplo
module man1

	// do not need to store the matching (can work it out from the men's variables)

	// o caso dos honmens quiserem trocar e teve empate, avaliar a priordade da mulher
	[e11] ( w1!=N1 & w2!=N1 & w3!=N1 ) | (w1=N1 & m11>m11)|(w2=N1 & m11>m12)|(w3=N1 & m11>m13) -> true;
	[e21] ( w1!=N1 & w2!=N1 & w3!=N1 ) | (w1=N1 & m12>m11)|(w2=N1 & m12>m12)|(w3=N1 & m12>m13) -> true;
	[e31] ( w1!=N1 & w2!=N1 & w3!=N1 ) | (w1=N1 & m13>m11)|(w2=N1 & m13>m12)|(w3=N1 & m13>m13) -> true;
	
endmodule

// a partir do módulo woman1 crio woman2 e woman3, porém substituindo as variáveis para ficarem compatíveis
module man2 = man1[ N1=N2, m11=m21, e11=e12, e21=e22, e31=e32, m12=m22, e12=e13, e22=e23, e32=e33, m13=m23, e13=e11, e23=e21, e33=e31 ] endmodule
module man3 = man1[ N1=N3, m11=m31, e11=e13, e21=e23, e31=e33, m12=m32, e12=e11, e22=e21, e32=e31, m13=m33, e13=e12, e23=e22, e33=e32 ] endmodule

//------------------------------------------------------
// reward structure: expected rounds
rewards "rounds"

	true : 1;
endrewards