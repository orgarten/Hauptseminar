pkg load io

A = {1,2, 'Hallo'};
B = {3,4, 'Welt'};

ab = [A; B];
abc = [B; ab]

writeEXCEL('data.xlsx', abc)