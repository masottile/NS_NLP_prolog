% A playground for testing out different Natural Selection Code

% Rate Equation Based NS -----------------------------------------------------------------
% entity_traits(type_of_entity, reproduction_probability, death_probability)
entity_traits(blob, 0.5, 0.75).

% population( initial_number_of_entities, type_of_entity, number_of_days_to_simulate, final_number_of_entities)
population(N, _, 0, N). % Without advancing any days initial = final
population(N, Entity, D1, F) :-  N > 0, D1 > 0, entity_traits(Entity, Birth, Death), I is N + N*Birth - N*Death, D2 is D1-1, population(I, Entity, D2, F).
% -----------------------------------------------------------------------------------------


% geography(Biome, Temp, Rain, Food)
%   Biome is the biome identifier
%   Temp is the relative temperature: hot, normal, cold
%   Rain is the humidity/rainfall: humid, normal, dry
%   Food is the food availability: plentiful, normal, scarce
geography(desert, hot, dry, scarce)
geography(jungle, hot, humid, plentiful)
geography(plains, normal, normal, normal)

% entity(Species, PS, PR)
%   Species is the type of species
%   PS is the probability that the entity survives
%   PR is the conditional probability that it reproduces (if it survives)
entity(blob, 0.75, 0.5).

% pop1day(N, Species, Survive, Reproduce, T, F)
%   N is the number of individuals in the population
%   Specied is the species of this population
%   Survive is true if this individual will survive this day, false otherwise
%   Reproduce (conditional on survival) is true is the individual reproduces, false otherwise
%   T is the accumulator
%   F is the final population of these N individuals plus the value of the accumulator

pop1day(0,_,_,_,F,F).
% case that individual dies
pop1day(N1, Species, false, _ , T1, F) :- N1 > 0, N2 is N1-1, T2 is T1, entity(Species, PR, PS), pop1day(N2, Species, random_float() < PS, random_float() < PR, T2, F).
% case individual survives but doesn't reproduce
pop1day(N1, Species, true, false , T1, F) :- N1 > 0, N2 is N1-1, T2 is T1+1, entity(Species, PR, PS), pop1day(N2, Species, random_float() < PS, random_float() < PR, T2, F).
% case individual survives and reproduces
pop1day(N1, Species, true, true , T1, F) :- N1 > 0, N2 is N1-1, T2 is T1+2, entity(Species, PR, PS), pop1day(N2, Species, random_float() < PS, random_float() < PR, T2, F).