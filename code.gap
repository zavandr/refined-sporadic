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
## Section. Elements of order bigger than 2

## We consider the exceptional pairs (S,mX) with m > 2  and  α(x) > 2 from Theorem 1 [check reference !!!]
## and find prime divisors r of |S| with nonzero multiplication coefficients ( mX, mX, nX ) for n divisible by r.

## Column 3 of Table 2 [check reference !!!] of the paper is based on these calculations

## First, we deal with the elements of order m = 3 :
## Namely, for every exceptional pair (S,3X) we find all prime divisors r of |S|
## such that r ≠ 3 and the product of some two representatives of 3X has order divisible by r


pairs := [ ["J2","3a"],   ["McL","3a"],  ["Ly","3a"],   ["Co1","3a"],             ## Exceptional pairs [ <group_name>, <class_name_3X> ]
           ["Fi22","3a"], ["Fi22","3b"], ["Fi23","3a"], ["Fi23","3b"],            ## with <group_name> being GAP's name of S and
           ["F3+","3a"],  ["F3+","3b"],  ["Suz","3a"]  ];;                        ## <class_name_3X> the name of class 3X


result:=[];                                                                       ## a list to collect the total result. Each member of this list is a quadruple
                                                                                  ## [ <group_name>, <class_name_3X>, <FoundPrimes>, <OtherPrimes>], where 
                                                                                  ##  <group_name> and <class_name_3X> are as above,
                                                                                  ##  <FoundPrimes> is the list of prime divisors r ≠ 3 of |S| such that 
                                                                                  ##  the product of some two representatives of 3X has order divisible by r,
                                                                                  ##  <OtherPrimes> is the prime divisors ≠ 3 of |S| not in <FoundPrimes>

for pair in pairs do 

   CharTable := CharacterTable( pair[1] );                                        ## character table of current group 

   ClassNamesG := ClassNames( CharTable );                                        ## names of conjugacy classes of current group

   NumClasses := Size( ClassNamesG );                                             ## number of conjugacy classes   

   pos_3X := Position( ClassNamesG, pair[2] );                                    ## position of class 3X

   OrdersReps := OrdersClassRepresentatives( CharTable );                         ## orders of conjugacy class representatives

   AllPrimesNot3 := Set( Filtered( OrdersReps,         
                               o -> IsPrime(o) and not o = 3 ) );                 ## prime divisors other than 3 of the order of current group

   PositionsNonZero := Filtered( [ 1..NumClasses ],  pos_nX -> 
  
     ClassMultiplicationCoefficient( CharTable, pos_3X, pos_3X, pos_nX ) <> 0 );  ## positions of classes nX with nonzero coefficients m(3X,3X,nX)
   
   OrderFactors := List( OrdersReps{PositionsNonZero}, Factors );                 ## factorized orders of elements in found classes
    
   FoundPrimesNot3 := Difference( Union(OrderFactors), [1,3]);                    ## prime divisors other than 3 of found orders

     
   OtherPrimesNot3 := Difference( AllPrimesNot3, FoundPrimesNot3 );               ## remaining primes ≠ 3
  
   Add( result, [ pair[1], pair[2] , FoundPrimesNot3, OtherPrimesNot3 ]);         ## collect the result
 
od;

Perform(result,function(tup) Print(tup,"\n"); end);                               ## print the result

# [ "J2", "3a", [ 2, 5 ], [ 7 ] ]
# [ "McL", "3a", [ 2, 5 ], [ 7, 11 ] ]
# [ "Ly", "3a", [ 2, 5 ], [ 7, 11, 31, 37, 67 ] ]
# [ "Co1", "3a", [ 2, 5 ], [ 7, 11, 13, 23 ] ]
# [ "Fi22", "3a", [ 2, 5 ], [ 7, 11, 13 ] ]
# [ "Fi22", "3b", [ 2, 5, 7, 13 ], [ 11 ] ]
# [ "Fi23", "3a", [ 2, 5 ], [ 7, 11, 13, 17, 23 ] ]
# [ "Fi23", "3b", [ 2, 5, 7, 13 ], [ 11, 17, 23 ] ]
# [ "F3+", "3a", [ 2, 5 ], [ 7, 11, 13, 17, 23, 29 ] ]
# [ "F3+", "3b", [ 2, 5, 7, 13 ], [ 11, 17, 23, 29 ] ]
# [ "Suz", "3a", [ 2, 5 ], [ 7, 11, 13 ] ]


## We now deal with elements of order m = 4 :
## Namely, for every exceptional pair (Aut(S),4X) we find all odd prime divisors r of |S|
## such that the product of some two representatives of 4X has order r


pairs := [ ["HS","4a"], ["HN.2","4d"] ];;                                         ##  Exceptional pairs [ <group_name>, <class_name_4X> ]
                                                                                  ##  with <group_name> being GAP's name of S and 
                                                                                  ##  <class_name_4X> the name of class 4X

result:=[];                                                                       ## a list to collect the total result. Each member of this list is a ....
                                                                                  ## [ <group_name>, <class_name_4X>, <FoundPrimes>, <OtherPrimes>], where 
                                                                                  ##  <group_name> and <class_name_4X> are as above,
                                                                                  ##  <FoundPrimes> is the list of odd prime divisors r of |S| such that 
                                                                                  ##  the product of some two representatives of 4X has order divisible by r,
                                                                                  ##  <OtherPrimes> is the odd prime divisors of |S| not in <FoundPrimes>

for pair in pairs do 

   CharTable := CharacterTable( pair[1] );                                        ## character table of current group 

   ClassNamesG := ClassNames( CharTable );                                        ## names of conjugacy classes of current group

   NumClasses := Size( ClassNamesG );                                             ## number of conjugacy classes   

   pos_4X := Position( ClassNamesG, pair[2] );                                    ## position of class 4X

   OrdersReps := OrdersClassRepresentatives( CharTable );                         ## orders of conjugacy class representatives

   AllOddPrimes := Set( Filtered( OrdersReps,         
                               o -> IsPrime(o) and not o = 2 ) );                 ## odd prime divisors of the order of current group

   PositionsNonZero := Filtered( [ 1..NumClasses ],  pos_nX -> 
  
     ClassMultiplicationCoefficient( CharTable, pos_4X, pos_4X, pos_nX ) <> 0 );  ## positions of classes nX with nonzero coefficients m(4X,4X,nX)
   
   OrderFactors := List( OrdersReps{PositionsNonZero}, Factors );                 ## factorized orders of elements in found classes
    
   FoundOddPrimes := Difference( Union(OrderFactors), [1,2]);                     ## odd prime divisors of found orders

     
   OtherOddPrimes := Difference( AllOddPrimes, FoundOddPrimes );                  ## remaining odd primes
  
   Add( result, [ pair[1], pair[2] , FoundOddPrimes, OtherOddPrimes ]);           ## collect the result
 
od;

Perform(result,function(tup) Print(tup,"\n"); end);                               ## print the result

# [ "HS", "4a", [ 3, 5, 7 ], [ 11 ] ]
# [ "HN.2", "4d", [ 3, 5, 7 ], [ 11, 19 ] ]

###

