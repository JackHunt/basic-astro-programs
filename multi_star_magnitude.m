% Compute the apparent or absolute magnitude of a multi star system.
% 
% ------------------------------------------------------------------------
% APPEARED IN ASTRONOMICAL COMPUTING, SKY & TELESCOPE, APRIL, 1984
% ------------------------------------------------------------------------
% 
% Translated from an old BASIC dialect by me (JH).


mags = [6.4, 3.1, 2.2];

B = 100^.2;

M = sum(arrayfun(@(x) B^(-x), mags));
M = -2.5 * log(M);