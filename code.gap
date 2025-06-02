###
##  This code for GAP ( version 4.14.0 of 2024-12-05 ) accompanies the paper
##  
##  "Refined conjugate generation in sporadic groups"
## 
##  by Danila O. Revin and Andrei V. Zavarnitsine
##
##  Date: May 11, 2025

###
##  Each section of the following code can be copy-pasted into a working GAP session.
##  The output of a command is given after a single '#'.
##  A comment is given after a double '#'.


###  
##  Section. Involutions
##
##  This section relates to the proof of [ Proposition 1  - check this reference !!! ]
##  Table 1 [ check this reference !!! ] of the paper is based on the output of the following code.
  
GroupNames := [ "B", "Co1", "Co2", "Co3", "F3+.2", "Fi22.2", "Fi23", "HN.2", 
                "HS.2", "He.2", "J1", "J2.2", "J3.2", "J4", "Ly", "M", "M11", 
       "M12.2", "M22.2", "M23", "M24", "McL.2", "ON.2", "Ru", "Suz.2", "Th" ];; ## names of automorphism groups of sporadic simple groups:

result:=[];                                                                     ## list to collect the total result. Each member of this list is a quadruple 
                                                                                ## 
                                                                                ## [ <Name of group G >, <Class 2X of involutions of G>, <set of primes>, <remaining primes>] 
                                                                                ## 
                                                                                ## where  <set of primes> is those prime divisors r of |G| for which there is
                                                                                ## a conjugacy class rX with nonzero multiplication coefficient m(2X,2X,rX), and 
                                                                                ## <remaining primes> is those not in <set of primes>
      
for name in GroupNames do                                                       ## run through all group names 
         
  CharTable := CharacterTable( name );                                          ## character table of current group 
      
  ClassNamesG := ClassNames( CharTable );                                       ## names of conjugacy classes of current group
      
  OrdersReps := OrdersClassRepresentatives( CharTable );                        ## orders of representatives of the conjugacy classes
      
  OddPrimes := Set( Filtered( OrdersReps,         
                               o -> IsPrime(o) and not o = 2 ) );               ## odd prime divisors of the order of current group
         
  ClassPositionsOddPrime := Filtered( [ 1..Size( ClassNamesG ) ],         
                                   p ->  OrdersReps[p] in OddPrimes );          ## positions of classes of odd prime order
      
  ClassPositionsInv := Filtered( [ 1..Size( ClassNamesG ) ],         
                                   p ->  OrdersReps[p]=2 );                     ## positions of classes of involutions
      
  for pos_2X in  ClassPositionsInv do                                           ## run through all classes 2X of involutions 
  
    PositionsNonZero := Filtered( ClassPositionsOddPrime, pos_rX -> 
  
    ClassMultiplicationCoefficient( CharTable, pos_2X, pos_2X, pos_rX ) <> 0);  ## positions of classes rX with nonzero coefficients m(2X,2X,rX)
     
    FoundPrimes := Set( OrdersReps{PositionsNonZero} );                         ## orders of elements in found classes
      
    OtherPrimes := Difference( OddPrimes, FoundPrimes );                        ## remaining odd primes 
  
    Add( result, [name, ClassNamesG[pos_2X], FoundPrimes, OtherPrimes ]);       ## collect the result
  od;
od;

Perform(result,function(tup) Print(tup,"\n"); end);                             ## print the result
 
# [ "B", "2a", [ 3 ], [ 5, 7, 11, 13, 17, 19, 23, 31, 47 ] ]
# [ "B", "2b", [ 3, 5 ], [ 7, 11, 13, 17, 19, 23, 31, 47 ] ]
# [ "B", "2c", [ 3, 5, 7, 11, 13, 17, 19 ], [ 23, 31, 47 ] ]
# [ "B", "2d", [ 3, 5, 7, 11, 13, 17, 19 ], [ 23, 31, 47 ] ]
# [ "Co1", "2a", [ 3, 5 ], [ 7, 11, 13, 23 ] ]
# [ "Co1", "2b", [ 3, 5, 7, 11, 13 ], [ 23 ] ]
# [ "Co1", "2c", [ 3, 5, 7, 11, 13 ], [ 23 ] ]
# [ "Co2", "2a", [ 3 ], [ 5, 7, 11, 23 ] ]
# [ "Co2", "2b", [ 3, 5 ], [ 7, 11, 23 ] ]
# [ "Co2", "2c", [ 3, 5, 7, 11 ], [ 23 ] ]
# [ "Co3", "2a", [ 3, 5 ], [ 7, 11, 23 ] ]
# [ "Co3", "2b", [ 3, 5, 7 ], [ 11, 23 ] ]
# [ "F3+.2", "2a", [ 3, 5 ], [ 7, 11, 13, 17, 23, 29 ] ]
# [ "F3+.2", "2b", [ 3, 5, 7, 11, 13, 17, 29 ], [ 23 ] ]
# [ "F3+.2", "2c", [ 3 ], [ 5, 7, 11, 13, 17, 23, 29 ] ]
# [ "F3+.2", "2d", [ 3, 5, 7, 11, 13, 17 ], [ 23, 29 ] ]
# [ "Fi22.2", "2a", [ 3 ], [ 5, 7, 11, 13 ] ]
# [ "Fi22.2", "2b", [ 3, 5 ], [ 7, 11, 13 ] ]
# [ "Fi22.2", "2c", [ 3, 5, 7, 13 ], [ 11 ] ]
# [ "Fi22.2", "2d", [ 3 ], [ 5, 7, 11, 13 ] ]
# [ "Fi22.2", "2e", [ 3, 5, 7, 11 ], [ 13 ] ]
# [ "Fi22.2", "2f", [ 3, 5, 7, 11 ], [ 13 ] ]
# [ "Fi23", "2a", [ 3 ], [ 5, 7, 11, 13, 17, 23 ] ]
# [ "Fi23", "2b", [ 3, 5 ], [ 7, 11, 13, 17, 23 ] ]
# [ "Fi23", "2c", [ 3, 5, 7, 11, 13, 17 ], [ 23 ] ]
# [ "HN.2", "2a", [ 3, 5 ], [ 7, 11, 19 ] ]
# [ "HN.2", "2b", [ 3, 5, 7, 11 ], [ 19 ] ]
# [ "HN.2", "2c", [ 3, 5, 7, 11, 19 ], [  ] ]
# [ "HS.2", "2a", [ 3, 5 ], [ 7, 11 ] ]
# [ "HS.2", "2b", [ 3, 5, 7 ], [ 11 ] ]
# [ "HS.2", "2c", [ 3 ], [ 5, 7, 11 ] ]
# [ "HS.2", "2d", [ 3, 5, 7, 11 ], [  ] ]
# [ "He.2", "2a", [ 3, 5 ], [ 7, 17 ] ]
# [ "He.2", "2b", [ 3, 5, 7, 17 ], [  ] ]
# [ "He.2", "2c", [ 3, 5, 7 ], [ 17 ] ]
# [ "J1", "2a", [ 3, 5, 7, 11, 19 ], [  ] ]
# [ "J2.2", "2a", [ 3, 5 ], [ 7 ] ]
# [ "J2.2", "2b", [ 3, 5, 7 ], [  ] ]
# [ "J2.2", "2c", [ 3, 7 ], [ 5 ] ]
# [ "J3.2", "2a", [ 3, 5, 17 ], [ 19 ] ]
# [ "J3.2", "2b", [ 3, 17, 19 ], [ 5 ] ]
# [ "J4", "2a", [ 3, 5, 11 ], [ 7, 23, 29, 31, 37, 43 ] ]
# [ "J4", "2b", [ 3, 5, 11, 23, 29, 31, 37, 43 ], [ 7 ] ]
# [ "Ly", "2a", [ 3, 5, 7, 31, 37, 67 ], [ 11 ] ]
# [ "M", "2a", [ 3, 5 ], [ 7, 11, 13, 17, 19, 23, 29, 31, 41, 47, 59, 71 ] ]
# [ "M", "2b", [ 3, 5, 7, 11, 13, 17, 19, 29, 41 ], [ 23, 31, 47, 59, 71 ] ]
# [ "M11", "2a", [ 3, 5 ], [ 11 ] ]
# [ "M12.2", "2a", [ 3, 5 ], [ 11 ] ]
# [ "M12.2", "2b", [ 3, 5 ], [ 11 ] ]
# [ "M12.2", "2c", [ 3, 5, 11 ], [  ] ]
# [ "M22.2", "2a", [ 3, 5 ], [ 7, 11 ] ]
# [ "M22.2", "2b", [ 3 ], [ 5, 7, 11 ] ]
# [ "M22.2", "2c", [ 3, 5, 11 ], [ 7 ] ]
# [ "M23", "2a", [ 3, 5 ], [ 7, 11, 23 ] ]
# [ "M24", "2a", [ 3, 5 ], [ 7, 11, 23 ] ]
# [ "M24", "2b", [ 3, 5, 11 ], [ 7, 23 ] ]
# [ "McL.2", "2a", [ 3, 5 ], [ 7, 11 ] ]
# [ "McL.2", "2b", [ 3, 5, 7 ], [ 11 ] ]
# [ "ON.2", "2a", [ 3, 5, 7, 11, 19 ], [ 31 ] ]
# [ "ON.2", "2b", [ 3, 5, 7, 11, 19, 31 ], [  ] ]
# [ "Ru", "2a", [ 3, 5, 7, 13 ], [ 29 ] ]
# [ "Ru", "2b", [ 3, 5, 7, 13, 29 ], [  ] ]
# [ "Suz.2", "2a", [ 3, 5 ], [ 7, 11, 13 ] ]
# [ "Suz.2", "2b", [ 3, 5, 7, 11, 13 ], [  ] ]
# [ "Suz.2", "2c", [ 3, 5, 7 ], [ 11, 13 ] ]
# [ "Suz.2", "2d", [ 3, 5, 7, 11 ], [ 13 ] ]
# [ "Th", "2a", [ 3, 5, 7, 13, 19 ], [ 31 ] ]

##
###
